﻿using Microsoft.Practices.EnterpriseLibrary.Data;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Threading.Tasks;
using pix_dynamic_payload_generator.net;
using pix_dynamic_payload_generator.net.Requests.RequestServices;
using System.Runtime.InteropServices;
using Newtonsoft.Json;
using System.Data.Common;

namespace global.admin
{
    public partial class lote : System.Web.UI.Page
    {
        public void Page_Load(object sender, EventArgs e)
        {
            hdfIdUsuario.Value = Session["idcliente"].ToString();
            //traz o conteudo do contrato para salvar no cadastro final
            //using (IDataReader reader = DatabaseFactory.CreateDatabase("ConnectionString").ExecuteReader(CommandType.Text,
            //                  "SELECT * from contrato where idtipocliente = '2'"))
            //{
            //    if (reader.Read())
            //    {
            //        hdfContrato.Value = reader["conteudo"].ToString();
            //    }
            //}
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = true;
            txtLote.Text = "";
            txtQuantidade.Text = "";
        }

        protected void btnSalvar_Click1(object sender, EventArgs e)
        {
            Database db = DatabaseFactory.CreateDatabase("ConnectionString");

            try
            {
                DbCommand command = db.GetSqlStringCommand("INSERT INTO lote (numlote, name_produto, quantidade, status, data_criacao) values (@lote, @name, @quantidade, @status, GETDATE())");
                db.AddInParameter(command, "@lote", DbType.String, txtLote.Text);
                db.AddInParameter(command, "@name", DbType.String, Convert.ToInt16(ddlProduto.SelectedValue));
                db.AddInParameter(command, "@quantidade", DbType.String, txtQuantidade.Text);
                db.AddInParameter(command, "@status", DbType.String, ddlStatus.SelectedValue);

                try
                {
                    db.ExecuteNonQuery(command);
                    lblMensagem.Text = "Informação salva com sucesso!";
                }
                catch (Exception ex)
                {
                    lblMensagem.Text = "Erro ao tentar salvar informação. " + ex.Message;
                }

            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Erro ao entrar no banco. " + ex.Message;
            }

        }

        protected void lkbFechar_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }

        protected void lkbFiltro_Click(object sender, EventArgs e)
        {
            sdsDados.SelectCommand = "select * from lote where name_produto like '%" + txtBuscar.Text + "%'";
            gdvDados.DataBind();
        }

        protected void gdvDados_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {

            hdfId.Value = e.CommandArgument.ToString();

            if (e.CommandName == "Excluir")
            {
                ExcluirRegistro();
            }
            else if (e.CommandName == "Editar")
            {
                EditarRegistro();
            }
        }

        protected void EditarRegistro()
        {
            using (IDataReader reader = DatabaseFactory.CreateDatabase("ConnectionString").ExecuteReader(CommandType.Text,
                  "SELECT * from lote"))
            {
                if (reader.Read())
                {
                    ddlProduto.SelectedValue = reader["name_produto"].ToString();
                    txtQuantidade.Text = reader["quantidade"].ToString();
                    ddlStatus.SelectedValue = reader["status"].ToString();
                    pnlModal.Visible = true;
                    lblMensagem.Text = "";
                }
            }
        }

        protected void ExcluirRegistro()
        {

            System.Threading.Thread.Sleep(1000);

            using (IDataReader reader = DatabaseFactory.CreateDatabase("ConnectionString").ExecuteReader(CommandType.Text,
                          "Delete from lote where id = '" + hdfId.Value + "'")) ;
        }
    }
}
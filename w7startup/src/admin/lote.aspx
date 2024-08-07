﻿<%@ Page Async="true" Title="" Language="C#" MasterPageFile="~/src/admin/principal.Master" AutoEventWireup="true" CodeBehind="lote.aspx.cs" Inherits="global.admin.lote" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdfId" runat="server" />
            <asp:HiddenField ID="hdfIdUsuario" runat="server" />

            <!-- Title and Top Buttons Start -->
            <div class="page-title-container">
                <div class="row g-0">

                    <!-- Title -->
                    <div class="col-auto mb-3 mb-md-0 me-auto">
                        <div class="w-auto sw-md-30">
                            <a href="dashboard.aspx" class="muted-link pb-1 d-inline-block breadcrumb-back">
                                <i data-acorn-icon="chevron-left" data-acorn-size="13"></i>
                                <span class="text-small align-middle">Administrador</span>
                            </a>
                            <br />
                            <h1 class="mb-0 pb-0 display-4" id="title">Lote</h1>
                            <br />
                        </div>
                    </div>

                    <!-- Teste -->
                    <asp:Label ID="lblTeste" runat="server"></asp:Label> 

                    <!-- Add Lote -->
                    <div class="w-100 d-md-none"></div>
                    <div class="col-12 col-sm-6 col-md-auto d-flex align-items-end justify-content-end mb-2 mb-sm-0 order-sm-3">
                        <asp:LinkButton ID="lkbAdicionarPerfil" runat="server" CssClass="btn btn-outline-primary btn-icon btn-icon-start ms-0 ms-sm-1 w-100 w-md-auto" OnClick="LinkButton1_Click">
                         <i data-acorn-icon="plus"></i> Novo Lote</asp:LinkButton>                       
                    </div>
                </div>
            </div>

            <!-- Search -->
            <div class="row mb-2">
                <div class="col-sm-12 col-md-5 col-lg-4 col-xxl-2 mb-1">
                    <div class="">
                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Filtrar"></asp:TextBox>
                    </div>                        
                </div>
                <div class="col-sm-12 col-md-5 col-lg-4 col-xxl-2 mb-1">
                    <asp:LinkButton ID="lkbFiltro" runat="server" CssClass="btn btn-outline-primary btn-icon btn-icon-start ms-0 ms-sm-1 w-100 w-md-auto" OnClick="lkbFiltro_Click">
                    <i data-acorn-icon="search"></i> Filtrar</asp:LinkButton>     
                </div>
                <br />
            </div>

            <!-- Grid -->
            <div class="row">
                <div class="col-12 mb-5">
                    <asp:GridView ID="gdvDados" runat="server" Width="100%" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" EmptyDataText="Não há dados para visualizar" DataSourceID="sdsDados" OnRowCommand="gdvDados_RowCommand">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button data-bs-offset="0,3" data-bs-toggle="modal" data-bs-target="#pnlModal" ID="btnEditar" CssClass="btn btn-icon btn-icon-end btn-primary" CommandArgument='<%# Eval("ID") %>' CommandName="Editar" runat="server" Text="Editar" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Lote" HeaderText="Lote" SortExpression="Lote" />
                            <asp:BoundField DataField="Produto" HeaderText="Produto" SortExpression="Produto" />
                            <asp:BoundField DataField="Quantidade" HeaderText="Quantidade" SortExpression="Quantidade" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle Height="4em" BackColor="White" ForeColor="#a59e9e" CssClass="fix-margin" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                    <asp:SqlDataSource ID="sdsDados" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT MAX(l.idlote) AS ID, MAX(l.numlote) AS Lote, MAX(p.titulo) AS Produto, COUNT(li.IMEI) AS Quantidade, MAX(l.[status]) AS Status FROM lote l JOIN produto p ON l.idproduto = p.id JOIN lote_imei li ON li.idlote = l.idlote WHERE l.status = 'Ativo' GROUP BY l.numlote">
                    </asp:SqlDataSource>
                </div>
            </div>


            <!-- Discount Add Modal Start -->
            <asp:Panel ID="pnlModal" runat="server" CssClass="modal-right" Visible="false">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Adicionar Lote</h5>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">                                
                                <label class="form-label">Número do Lote</label>
                                <asp:DropDownList ID="ddlLote" runat="server" AppendDataBoundItems="true" AutoPostBack="true" CssClass="form-control shadow dropdown-menu-end" DataSourceID="sdsLote" DataTextField="cod" DataValueField="idlote" OnSelectedIndexChanged="ddlLote_SelectedIndexChanged">
                                    <asp:ListItem Text="Novo Lote" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsLote" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=
                                            "select distinct idlote, numlote as cod from lote where status = 'Ativo' order by cod">
                                        </asp:SqlDataSource>      
                                <asp:TextBox ID="txtLote" runat="server" CssClass="form-control" Required></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Nome do Produto</label>
                                <asp:DropDownList ID="ddlProduto" runat="server" CssClass="form-control shadow dropdown-menu-end" DataSourceID="sdsProduto" DataTextField="nome" DataValueField="id"></asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsProduto" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="select id, titulo +' : R$ '+ convert(varchar, valor) as nome from produto where status = 'Ativo'order by nome">
                                    </asp:SqlDataSource>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">IMEI</label>
                                <asp:TextBox ID="txtIMEI" runat="server" CssClass="form-control" Required></asp:TextBox>
                            </div>
                            <div class="mb-3 w-100">
                                <label class="form-label">Status</label>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control shadow dropdown-menu-end">
                                    <asp:ListItem Text="Ativo" CssClass="dropdown-item"></asp:ListItem>
                                    <asp:ListItem Text="Inativo" CssClass="dropdown-item"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="modal-footer border-0">
                            <asp:Label ID="lblMensagem" runat="server" Text=""></asp:Label>
                            <br />
                            <asp:LinkButton ID="lkbFechar" runat="server" CssClass="btn btn-danger btn-icon btn-icon-start" OnClick="lkbFechar_Click"><i data-acorn-icon="close"></i> Fechar </asp:LinkButton>         
                            <asp:Button ID="btnSalvar" CssClass="btn btn-icon btn-icon-end btn-success" runat="server" Text="Salvar" OnClick="btnSalvar_Click1" />
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

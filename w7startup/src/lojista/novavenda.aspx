﻿<%@ Page Async="true" Title="" Language="C#" MasterPageFile="~/src/lojista/principal.Master" AutoEventWireup="true" CodeBehind="novavenda.aspx.cs" Inherits="global.lojista.novavenda" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../js/mascara.js"></script>
    <asp:HiddenField ID="hdfId" runat="server" />
    <asp:HiddenField ID="hdfIdCliente" runat="server" />
    <asp:HiddenField ID="hdfIdCartao" runat="server" />
    <asp:HiddenField ID="hdfIdProduto" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <!-- Título Página -->
            <div class="page-title-container">
                <div class="row g-0">
                    <div class="col-auto mb-6 mb-md-0 me-auto">
                        <div class="w-auto sw-md-30">
                            <a href="dashboard.aspx" class="muted-link pb-1 d-inline-block breadcrumb-back">
                                <i data-acorn-icon="chevron-left" data-acorn-size="13"></i>
                                <span class="text-small align-middle">Lojista</span>
                            </a>
                            <%-- Número da Venda --%>
                            <h1 class="mb-0 pb-0 display-4" id="title">Número #:
                                <asp:Label ID="lblNumeroPedido" runat="server" Text=""></asp:Label></h1>
                            <asp:Label ID="lblIdCliente" Visible="false" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblMsgErro" Visible="false" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblIdCartao" Visible="false" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Opção de Cliente --%>
            <div id="card-body">
                <asp:Panel ID="pnlCliente" runat="server">
                    <div class="mb-3">
                        <label class="form-label">Escolha uma opção</label>
                        <asp:RadioButtonList ID="rblCliente" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblCliente_SelectedIndexChanged" RepeatDirection="Vertical" CssClass="radio-list-item">
                            <asp:ListItem Text="Novo Cliente"></asp:ListItem>
                            <asp:ListItem Text="Cliente Cadastrado"></asp:ListItem>
                        </asp:RadioButtonList>
                        <style>
                            .radio-list-item {
                                margin-bottom: 10px;
                            }
                        </style>
                    </div>
                    <div class="mb-3">
                        <asp:DropDownList ID="ddlCliente" Visible="false" CssClass="form-control" AppendDataBoundItems="true" runat="server" DataSourceID="sdsClientes" DataTextField="nomecliente" DataValueField="id" AutoPostBack="True" OnSelectedIndexChanged="ddlCliente_SelectedIndexChanged">
                            <asp:ListItem Text="Selecione o cliente" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsClientes" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand=
                            "select id, nomecompleto +' '+ substring(cnpj_cpf, 0,4)+'********'+substring(cnpj_cpf, 13,3) as nomecliente from cliente
                            where cadastrado_por = @id
                            order by nomecompleto">
                            <SelectParameters>
                                <asp:SessionParameter Name="id" SessionField="idcliente" />
                            </SelectParameters>
                        </asp:SqlDataSource></div>
                </asp:Panel>

                <%-- Cadastro de Novo Cliente --%>
                <asp:Panel ID="pnlDadosCliente" runat="server" Visible="false">
                    <h2 class="small-title">Cadastro de Cliente</h2>
                    <div class="mb-3">
                        <label class="form-label">Nome do Cliente</label>
                        <asp:TextBox ID="txtNomeCliente" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">CPF/CNPJ</label>
                        <asp:TextBox ID="txtCPFCNPJ" onkeyup="determinarTipoDocumento(this);" MaxLength="18" runat="server" CssClass="form-control" Required></asp:TextBox>
                        <script>
                            function determinarTipoDocumento(textBox) {
                                var value = textBox.value.replace(/\D/g, '');
        
                                if (value.length <= 11) {
                                    textBox.maxLength = 14;
                                    formataCPF(textBox);
                                } else {
                                    textBox.maxLength = 18;
                                    formataCNPJ(textBox);
                                }
                            }
                        </script>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">RG</label>
                        <asp:TextBox ID="txtRG" onkeyup="formataRG(this,event);" MaxLength="12" runat="server" CssClass="form-control" ></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Celular</label>
                        <asp:TextBox ID="txtCelular" onkeyup="formataTelefone(this,event);" MaxLength="15" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">E-mail</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">CEP</label>
                        <asp:TextBox ID="txtCEP" onkeyup="formataCEP(this,event);" MaxLength="10" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="txtCEP_TextChanged" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Endereço</label>
                        <asp:TextBox ID="txtEndereco" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Num</label>
                        <asp:TextBox ID="txtNum" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Bairro</label>
                        <asp:TextBox ID="txtBairro" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Complemento</label>
                        <asp:TextBox ID="txtComplemento" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Estado</label>
                        <asp:DropDownList runat="server" ID="ddlUF" CssClass="form-control">
                            <asp:ListItem Text="Acre - AC" Value="AC" />
                            <asp:ListItem Text="Alagoas - AL" Value="AL" />
                            <asp:ListItem Text="Amapá - AP" Value="AP" />
                            <asp:ListItem Text="Amazonas - AM" Value="AM" />
                            <asp:ListItem Text="Bahia - BA" Value="BA" />
                            <asp:ListItem Text="Ceará - CE" Value="CE" />
                            <asp:ListItem Text="Espiríto Santo - ES" Value="ES" />
                            <asp:ListItem Text="Goiás - GO" Value="GO" />
                            <asp:ListItem Text="Maranhão - MA" Value="MA" />
                            <asp:ListItem Text="Mato Grosso - MT" Value="MT" />
                            <asp:ListItem Text="Mato Grosso do Sul - MS" Value="MS" />
                            <asp:ListItem Text="Minas Gerais - MG" Value="MG" />
                            <asp:ListItem Text="Pará - PA" Value="PA" />
                            <asp:ListItem Text="Paraíba - PB" Value="PB" />
                            <asp:ListItem Text="Paraná - PR" Value="PR" />
                            <asp:ListItem Text="Pernambuco - PE" Value="PE" />
                            <asp:ListItem Text="Piauí - PI" Value="PI" />
                            <asp:ListItem Text="Rio de Janeiro - RJ" Value="RJ" />
                            <asp:ListItem Text="Rio Grande do Norte - RN" Value="RN" />
                            <asp:ListItem Text="Rio Grande do Sul - RS" Value="RS" />
                            <asp:ListItem Text="Rondônia - RO" Value="RO" />
                            <asp:ListItem Text="Roraima - RR" Value="RR" />
                            <asp:ListItem Text="Santa Catarina - SC" Value="SC" />
                            <asp:ListItem Text="São Paulo - SP" Value="SP" />
                            <asp:ListItem Text="Sergipe - SE" Value="SE" />
                            <asp:ListItem Text="Tocantins - TO" Value="TO" />
                            <asp:ListItem Text="Distrito Federal - DF" Value="DF" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Cidade</label>
                        <asp:TextBox ID="txtCidade" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="modal-footer border-0">
                        <asp:Label ID="lblMensagemCliente" runat="server" Text=""></asp:Label>
                        <br />
                        <asp:Button ID="btnSalvarCliente" CssClass="btn btn-icon btn-icon-end btn-success" runat="server" Text="Avançar" OnClick="btnSalvarCliente_Click" />
                    </div>
                </asp:Panel>

                <%-- Cadastro de Venda --%>
                <asp:Panel ID="pnlCarrinho" runat="server" Visible="false">
                    <h2 class="small-title">Carrinho de Produtos</h2>
                    <div class="mb-3">
                        <label class="form-label">Produto</label>
                        <asp:DropDownList ID="ddlProduto" runat="server" CssClass="form-control shadow dropdown-menu-end" DataSourceID="sdsProduto" DataTextField="nome" DataValueField="id">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsProduto" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=
                            "select id, titulo as nome from produto where status = 'ATIVO' order by nome"></asp:SqlDataSource>
                    </div>
                    <%--<div class="mb-3">
                        <label class="form-label">Quant.</label>
                        <asp:TextBox ID="txtQtde" onkeyup="formataInteiro(this,event);" runat="server" Text="1" CssClass="form-control"></asp:TextBox>
                    </div>--%>
                    <div class="mb-3">
                        <label class="form-label">Lote</label>
                        <asp:DropDownList ID="ddlLote" runat="server" CssClass="form-control shadow dropdown-menu-end" DataSourceID="sdsLote" DataTextField="numlote" DataValueField="idlote">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsLote" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=
                            "SELECT DISTINCT l.numlote as numlote, p.lote as idlote
                            FROM pedido p
                            JOIN lote l ON l.idlote = p.lote 
                            WHERE p.idconsumidor = @id AND l.idproduto = @produto">
                            <SelectParameters>
                                <asp:SessionParameter Name="id" SessionField="idcliente" />
                                <asp:ControlParameter ControlID="ddlProduto" Name="produto" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>                
                    </div>
                    <div class="mb-3">
                        <label class="form-label">IMEI</label>
                        <asp:TextBox ID="imei" onkeyup="formataInteiro(this,event);" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Placa</label>
                        <asp:TextBox ID="txtPlaca" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Marca</label>
                        <asp:TextBox ID="txtMarca" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Modelo</label>
                        <asp:TextBox ID="txtModelo" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ano do Modelo</label>
                        <asp:TextBox ID="txtAno" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Cor</label>
                        <asp:TextBox ID="txtCor" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Chassi</label>
                        <asp:TextBox ID="txtChassi" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Renavam</label>
                        <asp:TextBox ID="txtRenavam" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ano de Fabricação</label>
                        <asp:TextBox ID="txtAnoFabricacao" runat="server" CssClass="form-control" Required></asp:TextBox>
                    </div>

                    <asp:Button ID="btnAdicionarItem" CssClass="btn btn-icon btn-icon-end btn-success" runat="server" Text="Adicionar ao carrinho" OnClick="btnAdicionarItem_Click" />
                    <br />
                    <br />

                    <!-- Carrinho -->
                    <div class="row">
                        <div class="col-12 mb-5">
                            <asp:GridView ID="gdvDados" runat="server" Width="100%" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" EmptyDataText="Não há dados produtos no carrinho" DataSourceID="sdsDados" OnRowCommand="gdvDados_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="idpedido" HeaderText="#Cód." SortExpression="idpedido" />
                                    <asp:BoundField DataField="titulo" HeaderText="Produto" SortExpression="titulo" />
                                    <asp:BoundField DataField="qtde" HeaderText="Quant." SortExpression="qtde" />
                                    <asp:BoundField DataField="valor" HeaderText="Valor" SortExpression="valor" />
                                    <asp:BoundField DataField="marca" HeaderText="Marca" SortExpression="marca" />
                                    <asp:BoundField DataField="modelo" HeaderText="Modelo" SortExpression="modelo" />
                                    <asp:BoundField DataField="placa" HeaderText="Placa" SortExpression="placa" />
                                    <asp:BoundField DataField="ano_modelo" HeaderText="Ano" SortExpression="ano_modelo" />
                                    <asp:BoundField DataField="cor" HeaderText="Cor" SortExpression="cor" />
                                    <asp:BoundField DataField="chassi" HeaderText="Chassi" SortExpression="chassi" />
                                    <asp:BoundField DataField="renavam" HeaderText="Renavam" SortExpression="renavam" />
                                    <%-- Excluir Item --%>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button data-bs-offset="0,3" data-bs-toggle="modal" data-bs-target="#discountAddModal" ID="btnEditar" CssClass="btn btn-icon btn-icon-end btn-danger" CommandArgument='<%# Eval("id") %>' CommandName="Excluir" runat="server" Text="Retirar" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                                <EditRowStyle BackColor="#7C6F57" />
                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle />
                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle Height="4em" BackColor="White" ForeColor="#a59e9e" CssClass="fix-margin" />
                                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                                <SortedAscendingHeaderStyle BackColor="#246B61" />
                                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                                <SortedDescendingHeaderStyle BackColor="#15524A" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsDados" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand=
                                "select pp.idproduto as id, imagem, pp.idpedido, pp.lote, titulo, qtde, pp.valor, pp.marca, pp.modelo, pp.placa, pp.ano_modelo, pp.cor, pp.chassi, pp.renavam from pedido_produto pp
                                join produto p on p.id = pp.idproduto 
                                where pp.idpedido = @id">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblNumeroPedido" Name="id" PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <%-- Cupom de Desconto --%>
                     <div class="mb-3">
                         <label class="form-label">Cupom de Desconto</label>
                         <asp:TextBox ID="txtCupom" runat="server" CssClass="form-control"></asp:TextBox>
                         <asp:Button ID="btnValidarCupom" runat="server" Text="Validar Cupom" CssClass="btn btn-icon btn-icon-end btn-success" OnClick="btnValidarCupom_Click" />
                         <asp:Label ID="lblMsgCupom" runat="server" Text=""></asp:Label>
                     </div>
                    <div class="modal-footer border-0">
                        <asp:Label ID="lblMensagemCarrinho" runat="server" Text=""></asp:Label>
                        <br />
                        <asp:Button ID="btnSalvarCarrinho" CssClass="btn btn-icon btn-icon-end btn-success" runat="server" Text="Avançar" OnClick="btnSalvarCarrinho_Click" />
                    </div>
                </asp:Panel>

                <%-- Pagamento --%>
                <asp:Panel ID="pnlDadosPagamento" runat="server" Visible="false">
                    <h2 class="small-title">Informações de Pagamento</h2>
                                        <div class="mb-3">
                        <asp:DropDownList ID="ddlCartao" Visible="false" CssClass="form-control" AppendDataBoundItems="true" runat="server" DataSourceID="sdsCartao" DataTextField="dadoscartao" DataValueField="id" AutoPostBack="True" OnSelectedIndexChanged="ddlCartao_SelectedIndexChanged">
                            <asp:ListItem Text="Novo Cartão" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Novo Cartão" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCartao" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select id, substring(numero,0,5)+'.****.****'+substring(numero,15,5) as dadoscartao from cartao where idcliente = @id">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCliente" Name="id" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource></div>
                    <label class="form-label"><i data-acorn-icon="user" class="icon" data-acorn-size="18"></i>Número do Cartão</label>
                    <div class="form-line">
                        <asp:TextBox ID="txtNumeroCartao" MaxLength="19" onkeyup="formataCartaoCredito(this,event);" CssClass="form-control" runat="server" placeHolder="" Required></asp:TextBox>
                    </div>
                    <label class="form-label"><i data-acorn-icon="user" class="icon" data-acorn-size="18"></i>Data de Validade</label>
                    <div class="form-line">
                        <asp:TextBox ID="txtDataValidade" onkeyup="formataMesAno(this,event);" MaxLength="5" CssClass="form-control" runat="server" placeHolder="  /  " Required></asp:TextBox>
                    </div>
                    <label class="form-label"><i data-acorn-icon="user" class="icon" data-acorn-size="18"></i>CVC/CVV</label>
                    <div class="form-line">
                        <asp:TextBox ID="txtCodSegunraca" onkeyup="formataInteiro(this,event);" CssClass="form-control" runat="server" placeHolder="" MaxLength="3" Required></asp:TextBox>
                    </div>
                    <label class="form-label"><i data-acorn-icon="user" class="icon" data-acorn-size="18"></i>Primeiro Nome</label>
                    <div class="form-line">
                        <asp:TextBox ID="txtNomeCartao" CssClass="form-control" runat="server" placeHolder="" Required></asp:TextBox>
                    </div>
                     <label class="form-label"><i data-acorn-icon="user" class="icon" data-acorn-size="18"></i>Último Nome</label>
                     <div class="form-line">
                         <asp:TextBox ID="txtUltimoNome" CssClass="form-control" runat="server" placeHolder="" Required></asp:TextBox>
                     </div>
                    <div class="modal-footer border-0">
                        <asp:Label ID="lblMensagemCartao" runat="server" Text=""></asp:Label>
                        <br />
                        <asp:Button ID="btnSalvarCartao" CssClass="btn btn-icon btn-icon-end btn-success" runat="server" Text="Avançar" OnClick="btnSalvarCartao_Click" />
                    </div>
                </asp:Panel>

                <%-- Finalização --%>
                <asp:Panel ID="pnlDadosFinais" runat="server" Visible="false">
                    <h2 class="small-title">Informações Gerais</h2>
                    <div class="mb-3 w-100">
                        <label class="form-label">Status</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control shadow dropdown-menu-end">
                            <asp:ListItem Text="Aguardando Pagamento" CssClass="dropdown-item"></asp:ListItem>
                            <asp:ListItem Text="Em Rota" CssClass="dropdown-item"></asp:ListItem>
                            <asp:ListItem Text="Entrega Realizada" CssClass="dropdown-item"></asp:ListItem>
                            <asp:ListItem Text="Cancelado" CssClass="dropdown-item"></asp:ListItem>
                            <asp:ListItem Text="Aguardando Envio" CssClass="dropdown-item"></asp:ListItem>
                            <asp:ListItem Text="Pagamento Realizado" CssClass="dropdown-item"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Observações</label>
                        <asp:TextBox ID="txtObservacoes" TextMode="MultiLine" Rows="3" MaxLength="500" runat="server" CssClass="form-control"></asp:TextBox>

                        <div class="modal-footer border-0">
                            <p>Sub-total: R$
                                <asp:Label ID="lblSUbTotal" runat="server" Text="0,00"></asp:Label></p>
                            <p>Desconto: R$
                                <asp:Label ID="lblDesconto" runat="server" Text="0,00"></asp:Label></p>
                            <p>Total: R$
                                <asp:Label ID="lblValorTotal" runat="server" Text="0,00"></asp:Label></p>

                            <asp:Label ID="lblMensagem" runat="server" Text="" Font-Size=""></asp:Label>
                            <br />
                            <br />

                            <asp:Button ID="btnSalvar" CssClass="btn btn-icon btn-icon-end btn-success" runat="server" Text="Finalizar Pedido" OnClick="btnSalvar_Click" />
                            <asp:UpdateProgress ID="LoaderBar" runat="server" DisplayAfter="300" DynamicLayout="true">
                                <ProgressTemplate>
                                <style type="text/css">
                                    .updateprogress-overlay {
                                        position: fixed;
                                        top: 0;
                                        left: 0;
                                        width: 100%;
                                        height: 100%;
                                        background-color: rgba(0, 0, 0, 0.5);
                                        z-index: 1000; 
                                    }

                                    .updateprogress-centered {
                                        position: absolute;
                                        top: 50%;
                                        left: 50%;
                                        transform: translate(-50%, -50%);
                                        z-index: 1001; 
                                    }

                                    h1 {
                                        font-size: 20px;
                                        color: white;
                                    }
                                    </style>
                                    <div class="updateprogress-centered">
                                        <h1>Salvando... Por favor aguarde!</h1>
                                    </div>
                                    <div class="updateprogress-overlay"></div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </div>
                </asp:Panel>

                <%-- Pedido Final --%>
                <asp:Panel ID="pnlFinal" runat="server" Visible="false">
                    <h2>Número do Pedido #:
                        <asp:Label ID="lblNumeroPedidoFinal" runat="server" Text=""></asp:Label></h2>
                    <asp:HyperLink ID="hplVerPedido" runat="server" Target="_blank">Visualizar/Imprimir Pedido</asp:HyperLink><br />
                    <asp:HyperLink ID="hplVerContrato" runat="server" Target="_blank">Visualizar/Imprimir Contrato</asp:HyperLink><br />
                    <asp:Label ID="lblMensagemFinal" runat="server" Text="" Font-Size="1.5em"></asp:Label><br />
                    <br />
                    <asp:Label ID="txtPagamento" runat="server" Text="" Font-Size="1.5em"></asp:Label><br />
                    <br />
                    <asp:Button ID="btnPagamento1" runat="server" Text="Clique aqui para assinar" CssClass="btn btn-primary" Visible="false" onClick="btnPagamento1_Click"/>
                    <asp:Button ID="btnPagamento2" runat="server" Text="Clique aqui para assinar" CssClass="btn btn-primary" Visible="false" onClick="btnPagamento2_Click"/>
                    <asp:Button ID="btnPagamento3" runat="server" Text="Clique aqui para assinar" CssClass="btn btn-primary" Visible="false" onClick="btnPagamento3_Click"/>
                    <asp:Button ID="btnPagamento4" runat="server" Text="Clique aqui para assinar" CssClass="btn btn-primary" Visible="false" onClick="btnPagamento4_Click"/>
                    <asp:Button ID="btnPagamento5" runat="server" Text="Clique aqui para assinar" CssClass="btn btn-primary" Visible="false" onClick="btnPagamento5_Click"/>
                    <br />
                    <br />
<%--                    <asp:Button ID="btnNovoPedido" CssClass="btn btn-icon btn-icon-end btn-success" runat="server" Text="Iniciar Novo Pedido" OnClick="btnNovoPedido_Click" />--%>
                </asp:Panel>

            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

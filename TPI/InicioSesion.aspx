<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="InicioSesion.aspx.cs" Inherits="TPI.InicioSesion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container text-center">
        <div class="row">
            <div class="col">
            </div>
            <div class="col">
                <div>
                    <asp:Label ID="lblTitulo" CssClass="display-3" runat="server" Text="INICIE SESION"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lblUser" runat="server" Text="Ingrese su usuario"></asp:Label>
                </div>
                <div>  
                    <asp:TextBox ID="txtbUser" runat="server"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="lblPassword" runat="server" Text="Ingrese su contraseña"></asp:Label>
                </div>
                <div>
                    <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                </div>
                <div>
                </div>
                <div>
                    <asp:Button ID="btnAceptarInicioSesion" runat="server" CssClass="btn btn-primary" BackColor="LightGreen" BorderColor="LightGreen" Text="Aceptar" />
                </div>
            </div>
            <div class="col">
            </div>
        </div>
    </div>
</asp:Content>

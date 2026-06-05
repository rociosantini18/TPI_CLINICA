<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="InicioSesion.aspx.cs" Inherits="TPI.InicioSesion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="card shadow p-4" style="width: 100%; max-width: 420px;">
            <div class="text-center mb-4">
                <h1 class="display-5 fw-bold">PROMEDIC</h1>
                <p class="text-muted">Ingresá tus credenciales para continuar</p>
            </div>
            <div class="mb-3">
                <asp:Label ID="lblUser" runat="server" Text="Usuario" CssClass="form-label fw-semibold"></asp:Label>
                <asp:TextBox ID="txtbUser" runat="server" CssClass="form-control" placeholder="Ingrese su usuario"></asp:TextBox>
            </div>
            <div class="mb-4">
                <asp:Label ID="lblPassword" runat="server" Text="Contraseña" CssClass="form-label fw-semibold"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su contraseña"></asp:TextBox>
            </div>
            <div class="d-grid">
                <asp:Button ID="btnAceptarInicioSesion" runat="server" CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" Text="Ingresar" />
            </div>
             <a href="PruebaBD.aspx" class="d-inline-flex focus-ring py-1 px-2 text-decoration-none border rounded-2" style="--bs-focus-ring-x: 10px; --bs-focus-ring-y: 10px; --bs-focus-ring-blur: 4px">
                Soy Admin</a>
        </div>
    </div>
</asp:Content>
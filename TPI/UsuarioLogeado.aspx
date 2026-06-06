<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="UsuarioLogeado.aspx.cs" Inherits="TPI.UsuarioLogeado" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container my-5">

        <div class="mb-4">
            <h2 class="fw-bold">Central de Turnos Online de PROMEDIC</h2>
            <hr />
        </div>

        <div class="text-end mb-3">
            <span class="badge text-bg-success fs-6 px-3 py-2">
                Conectado como: 
                <asp:Label ID="lblNombreUsuario" runat="server" Text=""></asp:Label>
            </span>
        </div>

        <div class="row g-3">

            <div class="col-md-3">
                <asp:Button ID="btnMisTurnos" runat="server" Text="Mis Turnos"
                    CssClass="btn btn-primary w-100 py-3 fs-5"
                    PostBackUrl="~/MisTurnos.aspx" />
            </div>

            <div class="col-md-3">
                <asp:Button ID="btnTomarTurno" runat="server" Text="Tomar Turno"
                    CssClass="btn btn-primary w-100 py-3 fs-5"
                    PostBackUrl="~/SacarTurno.aspx" />
            </div>

            <div class="col-md-3">
                <asp:Button ID="btnMisDatos" runat="server" Text="Mis Datos"
                    CssClass="btn btn-primary w-100 py-3 fs-5"
                    PostBackUrl="~/MisDatos.aspx" />
            </div>

        </div>
    </div>

</asp:Content>
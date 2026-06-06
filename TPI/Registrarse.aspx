<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="SacarTurno.aspx.cs" Inherits="TPI.SacarTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Label ID="lblTitulo" CssClass="display-2 fw-bold" runat="server" Text="REGISTRARSE"></asp:Label>
                <p class="lead mt-3 text-muted">Completá tus datos para crear tu cuenta en PROMEDIC.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-5">

                    <h4 class="fw-bold mb-4 text-center">Datos personales</h4>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Melina"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Ej: Vicente"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="Ej: 45265789"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Fecha de nacimiento:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 11-1234-5678"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Ej: Av. Corrientes 1234, CABA"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Obra social:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtObraSocial" runat="server" CssClass="form-control" placeholder="Ej: OSDE, Swiss Medical (opcional)"></asp:TextBox>
                    </div>

                    <hr class="my-4" />
                    <h4 class="fw-bold mb-4 text-center">Datos de acceso</h4>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Ej: meli@gmail.com"></asp:TextBox>
                        <small class="text-muted">Este email será tu usuario para iniciar sesión.</small>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Contraseña:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Mínimo 8 caracteres"></asp:TextBox>
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" Text="Confirmar contraseña:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtPasswordConfirm" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repetí tu contraseña"></asp:TextBox>
                    </div>

                    <asp:Label ID="lblError" runat="server" CssClass="text-danger mb-3 d-block" Visible="false"></asp:Label>

                    <div class="d-grid">
                        <asp:Button ID="btnRegistrarse" runat="server" CssClass="btn btn-lg" 
                            BackColor="LightGreen" BorderColor="LightGreen" 
                            Text="Crear cuenta" />
                    </div>

                    <p class="text-center text-muted mt-3 mb-0" style="font-size:13px;">
                        ¿Ya tenés cuenta? <a href="InicioSesion.aspx">Iniciá sesión acá</a>
                    </p>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
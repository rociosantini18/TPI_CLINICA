<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="MisDatos.aspx.cs" Inherits="TPI.MisDatos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Mis Datos</h1>
                <p class="lead text-muted mt-2">Revisá y actualizá tu información personal.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-5">

                    <h5 class="fw-bold mb-4 text-center">Datos personales</h5>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        <small class="text-muted">El DNI no puede modificarse.</small>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Fecha de nacimiento:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" ReadOnly="true" TextMode="Date"></asp:TextBox>
                        <small class="text-muted">La fecha de nacimiento no puede modificarse.</small>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" Text="Obra social:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlObraSocial" runat="server"></asp:DropDownList>
                    </div>

                    <hr class="my-4" />
                    <h5 class="fw-bold mb-4 text-center">Datos de acceso</h5>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Nueva contraseña:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"
                            placeholder="Dejá en blanco para no cambiarla"></asp:TextBox>
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" Text="Confirmar nueva contraseña:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtPasswordConfirm" runat="server" CssClass="form-control" TextMode="Password"
                            placeholder="Repetí la nueva contraseña"></asp:TextBox>
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="d-block mb-3" Visible="false"></asp:Label>

                    <div class="d-grid">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios"
                            CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" />
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

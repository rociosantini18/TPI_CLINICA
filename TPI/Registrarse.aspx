<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="Registrarse.aspx.cs" Inherits="TPI.Registrarse" %>

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

                    <asp:Label ID="lblExito" runat="server" Visible="false"></asp:Label>
                    <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
                    <asp:Panel ID="pnlRegistro" runat="server">
                        <h4 class="fw-bold mb-4 text-center">Datos personales</h4>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold"></asp:Label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Melina"></asp:TextBox>
                                <asp:RequiredFieldValidator
                                    runat="server"
                                    ControlToValidate="txtNombre"
                                    ErrorMessage="El nombre es obligatorio"
                                    CssClass="text-danger small"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold"></asp:Label>
                                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Ej: Vicente"></asp:TextBox>
                                <asp:RequiredFieldValidator
                                    runat="server"
                                    ControlToValidate="txtApellido"
                                    ErrorMessage="El apellido es obligatorio"
                                    CssClass="text-danger small"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="Ej: 45265789"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtDni"
                                ErrorMessage="El dni es obligatorio"
                                CssClass="text-danger small"
                                Display="Dynamic"> </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator
                                runat="server"
                                ControlToValidate="txtDNI"
                                ValidationExpression="^\d{7,8}$"
                                ErrorMessage="El DNI debe tener 8 numeros, sin puntos ni espacios."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Fecha de nacimiento:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>

                            <asp:CustomValidator ID="cvFecha" runat="server"
                                ControlToValidate="txtFechaNacimiento"
                                ErrorMessage="La fecha de nacimiento no puede ser una fecha futura."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidateEmptyText="true"
                                OnServerValidate="cvFecha_ServerValidate" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 11-1234-5678"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtTelefono"
                                ErrorMessage="El telefono es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server"
                                ControlToValidate="txtTelefono"
                                ValidationExpression="^[\d\s\-\+]{7,15}$"
                                ErrorMessage="El telefono solo puede contener numeros, guiones y espacios."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Ej: Av. Corrientes 1234, CABA"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtDireccion"
                                ErrorMessage="La dirección es obligatoria."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Obra social:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:DropDownList ID="ddlObraSocial" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <hr class="my-4" />
                        <h4 class="fw-bold mb-4 text-center">Datos de acceso</h4>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Ej: meli@gmail.com"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtEmail"
                                ErrorMessage="El email es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server"
                                ControlToValidate="txtEmail"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ErrorMessage="El formato del email no es válido."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Nombre de Usuario:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Ej: melg"></asp:TextBox>
                            <small class="text-muted">Este nombre será tu usuario para iniciar sesión.</small>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtEmail"
                                ErrorMessage="El usuario es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Contraseña:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Mínimo 8 caracteres"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtPassword"
                                ErrorMessage="La contraseña es obligatoria."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server"
                                ControlToValidate="txtPassword"
                                ValidationExpression="^.{8,}$"
                                ErrorMessage="La contraseña debe tener al menos 8 caracteres."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="mb-4">
                            <asp:Label runat="server" Text="Confirmar contraseña:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtPasswordConfirm" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repetí tu contraseña"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtPasswordConfirm"
                                ErrorMessage="Confirma tu contraseña."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CompareValidator runat="server"
                                ControlToValidate="txtPasswordConfirm"
                                ControlToCompare="txtPassword"
                                ErrorMessage="Las contraseñas no coinciden."
                                CssClass="text-danger small"
                                Display="Dynamic"></asp:CompareValidator>
                        </div>

                        <div class="d-grid">
                            <asp:Button ID="btnRegistrarse" runat="server" CssClass="btn btn-lg"
                                BackColor="LightGreen" BorderColor="LightGreen"
                                Text="Crear cuenta"
                                OnClick="btn_registrarse_click" />
                        </div>
                    </asp:Panel>

                    <p class="text-center text-muted mt-4 mb-0" style="font-size: 14px;">
                        ¿Ya tenés cuenta? <a href="InicioSesion.aspx" class="fw-bold text-success text-decoration-none">Iniciá sesión acá</a>
                    </p>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

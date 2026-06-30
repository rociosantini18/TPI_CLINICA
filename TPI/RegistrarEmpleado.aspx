<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="RegistrarEmpleado.aspx.cs" Inherits="TPI.RegistrarEmpleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Label CssClass="display-2 fw-bold" runat="server" Text="REGISTRAR EMPLEADO" />
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-5">

                    <div class="mb-4">
                        <asp:Label runat="server" Text="Tipo de empleado:" CssClass="form-label fw-semibold fs-5" />
                        <asp:DropDownList ID="ddlTipoEmpleado" runat="server"
                            CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlTipoEmpleado_SelectedIndexChanged">
                            <asp:ListItem Text="Seleccioná un tipo..." Value="" />
                            <asp:ListItem Text="Recepcionista"   Value="Recepcionista" />
                            <asp:ListItem Text="Administrador"   Value="Administrador" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server"
                            ControlToValidate="ddlTipoEmpleado"
                            InitialValue=""
                            ErrorMessage="Seleccioná un tipo de empleado."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <h4 class="fw-bold mb-4 text-center">Datos personales</h4>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
                                ErrorMessage="El nombre es obligatorio."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido"
                                ErrorMessage="El apellido es obligatorio."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDNI"
                            ErrorMessage="El DNI es obligatorio."
                            CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDNI"
                            ValidationExpression="^\d{7,8}$"
                            ErrorMessage="El DNI debe tener 7 u 8 números, sin puntos ni espacios."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Fecha de nacimiento:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date" />
                        <asp:CustomValidator ID="cvFecha" runat="server"
                            ControlToValidate="txtFechaNacimiento"
                            ErrorMessage="La fecha de nacimiento no puede ser una fecha futura."
                            CssClass="text-danger small" Display="Dynamic"
                            ValidateEmptyText="true"
                            OnServerValidate="cvFecha_ServerValidate" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTelefono"
                            ErrorMessage="El teléfono es obligatorio."
                            CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono"
                            ValidationExpression="^[\d\s\-\+]{7,15}$"
                            ErrorMessage="El teléfono solo puede contener números, guiones y espacios."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDireccion"
                            ErrorMessage="La dirección es obligatoria."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="El email es obligatorio."
                            CssClass="text-danger small" Display="Dynamic" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="El formato del email no es válido."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <h4 class="fw-bold mb-3 mt-2 text-center">Credenciales de acceso</h4>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Usuario:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsuario"
                            ErrorMessage="El usuario es obligatorio."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Contraseña:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtContrasena" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContrasena"
                            ErrorMessage="La contraseña es obligatoria."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="text-success fw-semibold mb-3 d-block" />
                    <asp:Label ID="lblError"   runat="server" CssClass="text-danger mb-3 d-block" />

                    <div class="d-grid mt-2">
                        <asp:Button ID="btnRegistrar" runat="server"
                            CssClass="btn btn-lg"
                            BackColor="LightGreen" BorderColor="LightGreen"
                            Text="Registrar"
                            OnClick="btnRegistrar_Click" />
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
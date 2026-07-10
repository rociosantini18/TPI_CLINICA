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
                            <asp:RequiredFieldValidator
                                ID="rfvNombre"
                                runat="server"
                                ControlToValidate="txtNombre"
                                ErrorMessage="El nombre es obligatorio."
                                ForeColor="Red"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator
                                ID="rfvApellido"
                                runat="server"
                                ControlToValidate="txtApellido"
                                ErrorMessage="El apellido es obligatorio."
                                ForeColor="Red"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
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
                        <asp:RequiredFieldValidator
                            ID="rfvTelefono"
                            runat="server"
                            ControlToValidate="txtTelefono"
                            ErrorMessage="El telefono es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="rfvDireccion"
                            runat="server"
                            ControlToValidate="txtDireccion"
                            ErrorMessage="La direccion es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
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
                        <asp:RequiredFieldValidator
                            ID="rfvEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="El email es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
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

                    <asp:Label ID="lblExito" runat="server" CssClass="text-success fw-bold mb-3 d-block" Visible="false"></asp:Label>
                    <asp:Label ID="lblError" runat="server" CssClass="text-danger mb-3 d-block" Visible="false"></asp:Label>

                    <div class="d-grid">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios"
                            CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" OnClick="btnGuardar_Click" />
                       <asp:Button ID="btnVolver" runat="server" Text="Cancelar" 
                                    CssClass="btn btn-lg btn-outline-secondary" 
                                    OnClick="btnVolver_Click" />
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

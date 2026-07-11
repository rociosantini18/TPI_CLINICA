<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="DatosMedico.aspx.cs" Inherits="TPI.DatosMedico" %>

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
            <div class="text-start mb-3">
                <asp:Button ID="btnVolver" runat="server" Text="VOLVER" OnClick="btnVolver_Click"
                    CssClass="btn btn-primary w-15 py-3 fs-5" />
            </div>
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-5">

                    <h5 class="fw-bold mb-4 text-center">Datos personales</h5>

                    <div class="row mb-3">
                        <img src='<%# Eval("imagenURL") %>' alt='<%# Eval("Especialidad.Nombre") %>'
                            class="rounded-circle mx-auto mb-3"
                            style="width: 120px; height: 120px; object-fit: cover;" />
                    </div>

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
                        <asp:Label runat="server" Text="Matricula:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        <small class="text-muted">La matricula no puede modificarse.</small>
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
                        <asp:Label runat="server" Text="Expecialidad:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlEspecialidades" runat="server"></asp:DropDownList>
                    </div>

                    <hr class="my-4" />

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold" Visible="false"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Visible="false"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Nueva contraseña:" CssClass="form-label fw-semibold" Visible="false"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" ReadOnly="true" Visible="false"></asp:TextBox>
                    </div>


                    <asp:Label ID="lblExito" runat="server" CssClass="text-success fw-bold mb-3 d-block" Visible="false"></asp:Label>
                    <asp:Label ID="lblError" runat="server" CssClass="text-danger mb-3 d-block" Visible="false"></asp:Label>

                    <div class="d-grid">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios"
                            CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" OnClick="btnGuardar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

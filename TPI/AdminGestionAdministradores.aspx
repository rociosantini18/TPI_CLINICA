<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="AdminGestionAdministradores.aspx.cs" Inherits="TPI.AdminGestionAdministradores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Administrador</h1>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link" href="AdminGestionPacientes.aspx">Pacientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminGestionMedicos.aspx">Medicos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminGestionRecepcionistas.aspx">Recepcionistas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="AdminGestionAdministradores.aspx">Administradores</a>
                    </li>
                </ul>
                <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
            </div>
        </div>
        <div class="row g-3 justify-content-center">

            <div class="col-md-3">
                <asp:Button ID="btnAgregarAdmin" runat="server" Text="Agregar Administrador Nuevo"
                    CssClass="btn btn-primary w-100 py-3 fs-5"
                    PostBackUrl="~/RegistrarEmpleado.aspx" />
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row g-4 justify-content-center">
            <asp:Label ID="lblError" runat="server" CssClass="text-danger fw-semibold" />
            <asp:GridView runat="server" ID="dgvAdmins"
                CssClass="table table-hover table-responsive"
                AutoGenerateColumns="False"
                OnRowCommand="dgvAdmins_RowCommand"
                EmptyDataText="No hay administradores registrados.">
                <Columns>
                    <asp:BoundField HeaderText="DNI" DataField="Dni" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Telefono" DataField="Telefono" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Usuario" DataField="Perfil.NombreUsuario" />
                    <asp:BoundField HeaderText="Contraseña" DataField="Perfil.Contraseña" />

                    <asp:TemplateField HeaderText="Fecha de Nacimiento">
                        <ItemTemplate><%# ((DateTime)Eval("FechaNacimiento")).ToString("dd/MM/yyyy") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:LinkButton runat="server"
                                CommandName="Eliminar"
                                CommandArgument='<%# Eval("Id") %>'
                                CssClass="btn btn-sm btn-outline-danger">
                                Eliminar
                            </asp:LinkButton>
                            <asp:LinkButton runat="server"
                                CommandName="Modificar"
                                CommandArgument='<%# Eval("Id") %>'
                                CssClass="btn btn-sm btn-outline-primary me-1">
                                Modificar
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Panel ID="pnlConfirmarEliminarAdmin" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                <asp:HiddenField ID="hfIdEliminarAdmin" runat="server" />
                <p class="fw-semibold mb-2">¿Seguro que querés dar de baja este administrador?</p>
                <asp:Button ID="btnConfirmarEliminarAdmin" runat="server" Text="Sí, dar de baja" CssClass="btn btn-danger btn-sm me-2" CausesValidation="false" OnClick="btnConfirmarEliminarAdmin_Click" />
                <asp:Button ID="btnCancelarEliminarAdmin" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnCancelarEliminarAdmin_Click" />
            </asp:Panel>
        </div>
    </div>

    <asp:Panel ID="pnlEditarAdmin" runat="server" Visible="false" CssClass="container my-4">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-4 text-start">
                    <h5 class="fw-bold mb-3">Modificar Administrador</h5>
                    <asp:HiddenField ID="hfIdAdmin" runat="server" />

                    <div class="row g-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditDni" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditDni"
                                ValidationGroup="vgEditAdmin" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditNombre" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditNombre"
                                ValidationGroup="vgEditAdmin" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditApellido" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditApellido"
                                ValidationGroup="vgEditAdmin" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Usuario:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditUsuario" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditUsuario"
                                ValidationGroup="vgEditAdmin" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Contraseña:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditContraseña" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditContraseña"
                                ValidationGroup="vgEditAdmin" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditTelefono" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditDireccion" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Fecha de Nacimiento:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditFechaNac" runat="server" CssClass="form-control" TextMode="Date" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditFechaNac"
                                ValidationGroup="vgEditAdmin" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                    </div>

                    <asp:Label ID="lblMensajeAdmin" runat="server" CssClass="text-success fw-semibold mt-3 d-block" />

                    <div class="d-flex gap-2 mt-3">
                        <asp:Button ID="btnGuardarAdmin" runat="server" Text="Guardar cambios"
                            CssClass="btn btn-primary"
                            ValidationGroup="vgEditAdmin"
                            OnClick="btnGuardarAdmin_Click" />
                        <asp:Button ID="btnCancelarAdmin" runat="server" Text="Cancelar"
                            CssClass="btn btn-outline-secondary"
                            CausesValidation="false"
                            OnClick="btnCancelarAdmin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="row g-3 justify-content-center mt-5 mb-4 border-top pt-4">
        <div class="col-md-4">
            <asp:Button ID="btnRecuperarAdmin" runat="server" Text="Recuperar Administrador" CssClass="btn btn-secondary w-100 py-2" OnClick="btnRecuperarAdmin_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:Panel ID="pnlAdminInactivos" runat="server" Visible="false" CssClass="container my-4 bg-light p-4 rounded shadow-sm">
        <h5 class="fw-bold mb-3 text-secondary">Admins Dados de Baja</h5>
        <asp:GridView runat="server" ID="dgvAdminInactivos" CssClass="table table-secondary table-hover" AutoGenerateColumns="False" OnRowCommand="dgvAdminInactivos_RowCommand" EmptyDataText="No hay Admins inactivos.">
            <Columns>
                <asp:BoundField HeaderText="DNI" DataField="DNI" />
                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CommandName="ReactivarAdmin" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-success">Reactivar</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
</asp:Content>

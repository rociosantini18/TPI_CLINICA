<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="AdminGestionPacientes.aspx.cs" Inherits="TPI.GestionAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Administrador</h1>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="AdminGestionPacientes.aspx">Pacientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminGestionMedicos.aspx">Medicos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminGestionRecepcionistas.aspx">Recepcionistas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminGestionAdministradores.aspx">Administradores</a>
                    </li>
                </ul>
                <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
                
            </div>
        </div>
        <div class="row g-3 justify-content-center">

            <div class="col-md-3">
                <asp:Button ID="btnAgregarPaciente" runat="server" Text="+ Agregar Paciente Nuevo"
                    CssClass="btn btn-primary w-100 py-3 fs-5"
                    PostBackUrl="~/Registrarse.aspx" />
            </div>
        </div>

    </div>

    <div class="container my-5">
        <div class="row g-4 justify-content-center">
            <asp:GridView runat="server" ID="dgvPacientes" CssClass="table table-hover table-responsive" AutoGenerateColumns="False"  OnRowCommand="dgvPacientes_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="DNI" DataField="DNI" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Obra Social" DataField="ObraSocial" />
                    <asp:BoundField HeaderText="Direccion" DataField="Direccion" />
                    <asp:BoundField HeaderText="Fecha de Nacimiento" DataField="FechaNacimiento" />
                    <asp:BoundField HeaderText="Usuario" DataField="Perfil.NombreUsuario" />
                    <asp:BoundField HeaderText="Contraseña" DataField="Perfil.Contraseña" />

                    <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:LinkButton runat="server"
                            CommandName="Eliminar"
                            CommandArgument='<%# Eval("Id") %>'
                            CssClass="btn btn-sm btn-outline-danger"
                            OnClientClick="return confirm('¿Seguro que querés eliminar este paciente?');">
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
            </div>
        </div>
            <%-- Tabla modificarsss --%>
            <asp:Panel ID="pnlEditarPaciente" runat="server" Visible="false" CssClass="container my-4">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-4 text-start">
                    <h5 class="fw-bold mb-3">Modificar Paciente</h5>
                    <asp:HiddenField ID="hfIdPaciente" runat="server" />

                    <div class="row g-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditDni" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditDni"
                                ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditNombre" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditNombre"
                                ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditApellido" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditApellido"
                                ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditEmail" runat="server" CssClass="form-control" TextMode="Email" />
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
                                ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                    </div>

                    <asp:Label ID="lblMensajePac" runat="server" CssClass="text-success fw-semibold mt-3 d-block" />

                    <div class="d-flex gap-2 mt-3">
                        <asp:Button ID="btnGuardarPac" runat="server" Text="Guardar cambios"
                            CssClass="btn btn-primary"
                            ValidationGroup="vgEditPaciente"
                            OnClick="btnGuardarPac_Click" />
                        <asp:Button ID="btnCancelarPac" runat="server" Text="Cancelar"
                            CssClass="btn btn-outline-secondary"
                            CausesValidation="false"
                            OnClick="btnCancelarPac_Click" />
                    </div>
                </div>
        </div>
    </div>
                </asp:Panel>
</asp:Content>

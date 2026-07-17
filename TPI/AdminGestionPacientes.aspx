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
            <div class="col-md-3">
                <asp:Button ID="btnAgregarObraSocial" runat="server" Text="+ Agregar Obra Social"
                    CssClass="btn btn-success w-100 py-3 fs-5"
                    OnClick="btnAgregarObraSocial_Click" CausesValidation="false" />
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnMostrarListaObrasSociales" runat="server" Text="Mostrar Obras Sociales"
                    CssClass="btn btn-outline-success w-100 py-3 fs-5"
                    OnClick="btnMostrarListaObrasSociales_Click" CausesValidation="false" />
            </div>
        </div>

    </div>

    <%-- Tabla de obras sociales --%>
    <asp:Panel ID="pnlListaObrasSociales" runat="server" Visible="false">
        <div class="container my-5">
            <div class="row g-4 justify-content-center">
                <h5 class="fw-bold mb-3 text-start">Obras Sociales</h5>

                <asp:Label ID="lblErrorGrillaOS" runat="server" CssClass="text-danger fw-semibold mb-3 d-block" Text=""></asp:Label>

                <asp:GridView runat="server" ID="dgvObrasSociales" CssClass="table table-hover table-responsive" AutoGenerateColumns="False" OnRowCommand="dgvObrasSociales_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="Obra Social" DataField="Value" />
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton runat="server"
                                    CommandName="EliminarOS"
                                    CommandArgument='<%# Eval("Key") %>'
                                    CssClass="btn btn-sm btn-outline-danger">
                            Eliminar
                                </asp:LinkButton>
                                <asp:LinkButton runat="server"
                                    CommandName="ModificarOS"
                                    CommandArgument='<%# Eval("Key") %>'
                                    CssClass="btn btn-sm btn-outline-primary me-1">
                            Modificar
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:Panel ID="pnlConfirmarEliminarOS" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                    <asp:HiddenField ID="hfIdEliminarOS" runat="server" />
                    <p class="fw-semibold mb-2">¿Seguro que querés eliminar esta obra social?</p>
                    <asp:Button ID="btnConfirmarEliminarOS" runat="server" Text="Sí, eliminar" CssClass="btn btn-danger btn-sm me-2" CausesValidation="false" OnClick="btnConfirmarEliminarOS_Click" />
                    <asp:Button ID="btnCancelarEliminarOS" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnCancelarEliminarOS_Click" />
                </asp:Panel>
            </div>
        </div>

        <asp:Panel ID="pnlEditarObraSocial" runat="server" Visible="false" CssClass="container my-4">
            <div class="row justify-content-center">
                <div class="col-md-7">
                    <div class="card shadow-sm border-0 p-4 text-start">
                        <h5 class="fw-bold mb-3">Modificar Obra Social</h5>
                        <asp:HiddenField ID="hfIdObraSocial" runat="server" />

                        <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtEditNombreObraSocial" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditNombreObraSocial"
                            ValidationGroup="vgEditObraSocial" ErrorMessage="Requerido."
                            CssClass="text-danger small" Display="Dynamic" />

                        <asp:Label ID="lblMensajeObraSocialEdit" runat="server" CssClass="text-success fw-semibold mt-3 d-block" />

                        <div class="d-flex gap-2 mt-3">
                            <asp:Button ID="btnGuardarObraSocialEdit" runat="server" Text="Guardar cambios"
                                CssClass="btn btn-primary"
                                ValidationGroup="vgEditObraSocial"
                                OnClick="btnGuardarObraSocialEdit_Click" />
                            <asp:Button ID="btnCancelarObraSocialEdit" runat="server" Text="Cancelar"
                                CssClass="btn btn-outline-secondary"
                                CausesValidation="false"
                                OnClick="btnCancelarObraSocialEdit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </asp:Panel>
    <asp:Panel ID="pnlNuevaObraSocial" runat="server" Visible="false" CssClass="container my-4">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-4 text-start">
                    <h5 class="fw-bold mb-3">Nueva Obra Social</h5>

                    <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtNombreObraSocial" runat="server" CssClass="form-control"
                        placeholder="Ej: Swiss Medical" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreObraSocial"
                        ValidationGroup="vgObraSocial" ErrorMessage="Requerido."
                        CssClass="text-danger small" Display="Dynamic" />

                    <asp:Label ID="lblMensajeObraSocial" runat="server" CssClass="text-success fw-semibold mt-3 d-block" />

                    <div class="d-flex gap-2 mt-3">
                        <asp:Button ID="btnGuardarObraSocial" runat="server" Text="Guardar"
                            CssClass="btn btn-success"
                            ValidationGroup="vgObraSocial"
                            OnClick="btnGuardarObraSocial_Click" />
                        <asp:Button ID="btnCancelarObraSocial" runat="server" Text="Cancelar"
                            CssClass="btn btn-outline-secondary"
                            CausesValidation="false"
                            OnClick="btnCancelarObraSocial_Click" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="container my-5">
        <div class="row g-4 justify-content-center">
            <asp:GridView runat="server" ID="dgvPacientes" CssClass="table table-hover table-responsive" AutoGenerateColumns="False" OnRowCommand="dgvPacientes_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="DNI" DataField="DNI" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Obra Social" DataField="ObraSocial" />
                    <asp:BoundField HeaderText="Direccion" DataField="Direccion" />
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

            <asp:Panel ID="pnlConfirmarEliminarPac" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                <asp:HiddenField ID="hfIdEliminarPac" runat="server" />
                <p class="fw-semibold mb-2">¿Seguro que querés eliminar este paciente?</p>
                <asp:Button ID="btnConfirmarEliminarPac" runat="server" Text="Sí, eliminar" CssClass="btn btn-danger btn-sm me-2" CausesValidation="false" OnClick="btnConfirmarEliminarPac_Click" />
                <asp:Button ID="btnCancelarEliminarPac" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnCancelarEliminarPac_Click" />
            </asp:Panel>
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
                            <asp:Label runat="server" Text="Usuario:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditUsuario" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditUsuario"
                                ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Contraseña:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditContraseña" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditContraseña"
                                ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
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
                                ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
                                CssClass="text-danger small" Display="Dynamic" />
                            <div class="col-md-6">
                                <asp:Label runat="server" Text="Obra Social:" CssClass="form-label fw-semibold" />
                                <asp:DropDownList ID="ddlEditObraSocial" runat="server" CssClass="form-select" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlEditObraSocial"
                                    ValidationGroup="vgEditPaciente" ErrorMessage="Requerido."
                                    CssClass="text-danger small" Display="Dynamic" InitialValue="" />
                            </div>
                        </div>
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
    <div class="row g-3 justify-content-center mt-5 mb-4 border-top pt-4">
        <div class="col-md-3">
            <asp:Button ID="btnRecuperarPacientes" runat="server" Text="Recuperar Pacientes" CssClass="btn btn-secondary w-100 py-2" OnClick="btnRecuperarPacientes_Click" CausesValidation="false" />
        </div>
        <div class="col-md-3">
            <asp:Button ID="btnRecuperarObraSocial" runat="server" Text="Recuperar Obras Sociales" CssClass="btn btn-outline-secondary w-100 py-2" OnClick="btnRecuperarObraSocial_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:Panel ID="pnlPacientesInactivos" runat="server" Visible="false" CssClass="container my-4 bg-light p-4 rounded shadow-sm">
        <h5 class="fw-bold mb-3 text-secondary">Pacientes Dados de Baja</h5>
        <asp:GridView runat="server" ID="dgvPacientesInactivos" CssClass="table table-secondary table-hover" AutoGenerateColumns="False" OnRowCommand="dgvPacientesInactivos_RowCommand" EmptyDataText="No hay pacientes inactivos.">
            <Columns>
                <asp:BoundField HeaderText="DNI" DataField="DNI" />
                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CommandName="Reactivar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-success">Reactivar</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="pnlObrasSocialesInactivas" runat="server" Visible="false" CssClass="container my-4 bg-light p-4 rounded shadow-sm">
        <h5 class="fw-bold mb-3 text-secondary">Obras Sociales Dadas de Baja</h5>
        <asp:GridView runat="server" ID="dgvObrasSocialesInactivas" CssClass="table table-secondary table-hover" AutoGenerateColumns="False" OnRowCommand="dgvObrasSocialesInactivas_RowCommand" EmptyDataText="No hay obras sociales inactivas.">
            <Columns>
                <asp:BoundField HeaderText="Obra Social" DataField="Value" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CommandName="ReactivarOS" CommandArgument='<%# Eval("Key") %>' CssClass="btn btn-sm btn-success">Reactivar</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
</asp:Content>

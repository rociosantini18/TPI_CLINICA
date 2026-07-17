<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="AdminGestionMedicos.aspx.cs" Inherits="TPI.AdminGestionMedicos" %>

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
                        <a class="nav-link active" aria-current="page" href="AdminGestionMedicos.aspx">Medicos</a>
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
                <asp:Button ID="btnAgregarMedico" runat="server" Text="+ Agregar Medico Nuevo"
                    CssClass="btn btn-primary w-100 py-3 fs-5"
                    PostBackUrl="~/RegistrarMedico.aspx" />
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnMostrarFormEspecialidad" runat="server"
                    Text="+ Agregar Especialidad"
                    CssClass="btn btn-success w-100 py-3 fs-5"
                    OnClick="btnMostrarFormEspecialidad_Click" />
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnMostrarListaEspecialidades" runat="server"
                    Text="Mostrar Especialidades"
                    CssClass="btn btn-outline-success w-100 py-3 fs-5"
                    CausesValidation="false"
                    OnClick="btnMostrarListaEspecialidades_Click" />
            </div>
        </div>
    </div>
    <%-- Tabla de especialidades Nueva --%>
    <asp:Panel ID="pnlNuevaEspecialidad" runat="server" Visible="false" CssClass="row justify-content-center mt-4">
        <div class="col-md-6">
            <div class="card shadow-sm border-0 p-4 text-start">
                <h5 class="fw-bold mb-3">Nueva Especialidad</h5>

                <div class="mb-3">
                    <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtNombreEsp" runat="server" CssClass="form-control" placeholder="Ej: Cardiología" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreEsp" ValidationGroup="vgEspecialidad" ErrorMessage="El nombre es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                </div>

                <div class="mb-3">
                    <asp:Label runat="server" Text="Descripción:" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtDescripcionEsp" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Descripción breve de la especialidad" />
                </div>

                <asp:Label ID="lblMensajeEsp" runat="server" CssClass="text-success fw-semibold" />

                <div class="d-flex gap-2 mt-2">
                    <asp:Button ID="btnGuardarEsp" runat="server" Text="Guardar" CssClass="btn btn-success" ValidationGroup="vgEspecialidad" OnClick="btnGuardarEsp_Click" />
                    <asp:Button ID="btnCancelarEsp" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="btnCancelarEsp_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>
    <%-- Tabla de especialidades Listar --%>
    <asp:Panel ID="pnlListaEspecialidades" runat="server" Visible="false">
        <div class="container my-5">
            <div class="row g-4 justify-content-center">
                <h5 class="fw-bold mb-3 text-start">Especialidades</h5>
                <asp:Label ID="lblErrorGrillaEsp" runat="server" CssClass="text-danger fw-semibold mb-3 d-block" Text=""></asp:Label>

                <asp:GridView runat="server" ID="dgvEspecialidades" CssClass="table table-hover table-responsive" AutoGenerateColumns="False" OnRowCommand="dgvEspecialidades_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                        <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="EliminarEsp" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-danger">Eliminar</asp:LinkButton>
                                <asp:LinkButton runat="server" CommandName="ModificarEsp" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary me-1">Modificar</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:Panel ID="pnlConfirmarEliminarEsp" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                    <asp:HiddenField ID="hfIdEliminarEsp" runat="server" />
                    <p class="fw-semibold mb-2">¿Seguro que querés eliminar esta especialidad?</p>
                    <asp:Button ID="btnConfirmarEliminarEsp" runat="server" Text="Sí, eliminar" CssClass="btn btn-danger btn-sm me-2" CausesValidation="false" OnClick="btnConfirmarEliminarEsp_Click" />
                    <asp:Button ID="btnCancelarEliminarEsp" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnCancelarEliminarEsp_Click" />
                </asp:Panel>
            </div>
        </div>

        <asp:Panel ID="pnlEditarEspecialidad" runat="server" Visible="false" CssClass="container my-4">
            <div class="row justify-content-center">
                <div class="col-md-7">
                    <div class="card shadow-sm border-0 p-4 text-start">
                        <h5 class="fw-bold mb-3">Modificar Especialidad</h5>
                        <asp:HiddenField ID="hfIdEspecialidad" runat="server" />

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditNombreEsp" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditNombreEsp" ValidationGroup="vgEditEspecialidad" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" Text="Descripción:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditDescripcionEsp" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                        </div>

                        <asp:Label ID="lblMensajeEspEdit" runat="server" CssClass="text-success fw-semibold mt-3 d-block" />

                        <div class="d-flex gap-2 mt-3">
                            <asp:Button ID="btnGuardarEspEdit" runat="server" Text="Guardar cambios" CssClass="btn btn-primary" ValidationGroup="vgEditEspecialidad" OnClick="btnGuardarEspEdit_Click" />
                            <asp:Button ID="btnCancelarEspEdit" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="btnCancelarEspEdit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </asp:Panel>

    <div class="container my-5">
        <div class="row g-4 justify-content-center">
            <asp:GridView runat="server" ID="dgvMedicos" CssClass="table table-hover table-responsive" AutoGenerateColumns="False" OnRowCommand="dgvMedicos_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="DNI" DataField="DNI" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Matricula" DataField="Matricula" />
                    <asp:BoundField HeaderText="Especialidad" DataField="Especialidad.Nombre" />
                    <asp:BoundField HeaderText="Direccion" DataField="Direccion" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Telefono" DataField="Telefono" />
                    <asp:TemplateField HeaderText="Fecha de Nacimiento">
                        <ItemTemplate><%# ((DateTime)Eval("FechaNacimiento")).ToString("dd/MM/yyyy") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-danger">Eliminar</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Modificar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary me-1">Modificar</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Panel ID="pnlConfirmarEliminarMed" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                <asp:HiddenField ID="hfIdEliminarMed" runat="server" />
                <p class="fw-semibold mb-2">¿Seguro que querés dar de baja este médico?</p>
                <asp:Button ID="btnConfirmarEliminarMed" runat="server" Text="Sí, dar de baja" CssClass="btn btn-danger btn-sm me-2" CausesValidation="false" OnClick="btnConfirmarEliminarMed_Click" />
                <asp:Button ID="btnCancelarEliminarMed" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnCancelarEliminarMed_Click" />
            </asp:Panel>
        </div>
    </div>

    <%-- Tabla modificarsss --%>
    <asp:Panel ID="pnlEditarMedico" runat="server" Visible="false" CssClass="container my-4">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-4 text-start">
                    <h5 class="fw-bold mb-3">Modificar Médico</h5>
                    <asp:HiddenField ID="hfIdMedico" runat="server" />

                    <div class="row g-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMedDni" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditMedDni" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMedNombre" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditMedNombre" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMedApellido" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditMedApellido" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMedEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Usuario:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditUsuario" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditUsuario" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Contraseña:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditContraseña" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditContraseña" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMedTelefono" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMedDireccion" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Fecha de Nacimiento:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMedFechaNac" runat="server" CssClass="form-control" TextMode="Date" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditMedFechaNac" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Matricula:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditMatri" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditMatri" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="URL Imagen:" CssClass="form-label fw-semibold" />
                            <asp:TextBox ID="txtEditFoto" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditFoto" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Especialidad:" CssClass="form-label fw-semibold" />
                            <asp:DropDownList ID="ddlEditEspecialidad" runat="server" CssClass="form-select" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlEditEspecialidad" ValidationGroup="vgEditMedico" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" InitialValue="" />
                        </div>
                        <div class="col-md-12 mt-3">
                            <asp:Label runat="server" Text="Días de Atención:" CssClass="form-label fw-semibold" />
                            <div class="border rounded p-2 bg-light">
                                <asp:CheckBoxList ID="cblEditDias" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="d-flex gap-3 flex-wrap">
                                    <asp:ListItem Text="Dom" Value="0" />
                                    <asp:ListItem Text="Lun" Value="1" />
                                    <asp:ListItem Text="Mar" Value="2" />
                                    <asp:ListItem Text="Mié" Value="3" />
                                    <asp:ListItem Text="Jue" Value="4" />
                                    <asp:ListItem Text="Vie" Value="5" />
                                    <asp:ListItem Text="Sáb" Value="6" />
                                </asp:CheckBoxList>
                            </div>
                        </div>
                    </div>
                    <asp:Label ID="lblMensajeMed" runat="server" CssClass="text-success fw-semibold mt-3 d-block" />

                    <div class="d-flex gap-2 mt-3">
                        <asp:Button ID="btnGuardarMed" runat="server" Text="Guardar cambios" CssClass="btn btn-primary" ValidationGroup="vgEditMedico" OnClick="btnGuardarMed_Click" />
                        <asp:Button ID="btnCancelarMed" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="btnCancelarMed_Click" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="row g-3 justify-content-center mt-5 mb-4 border-top pt-4">
        <div class="col-md-3">
            <asp:Button ID="btnRecuperarMedicos" runat="server" Text="Recuperar Médicos" CssClass="btn btn-secondary w-100 py-2" OnClick="btnRecuperarMedicos_Click" CausesValidation="false" />
        </div>
        <div class="col-md-3">
            <asp:Button ID="btnRecuperarEspecialidad" runat="server" Text="Recuperar Especialidades" CssClass="btn btn-outline-secondary w-100 py-2" OnClick="btnRecuperarEspecialidad_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:Panel ID="pnlMedicosInactivos" runat="server" Visible="false" CssClass="container my-4 bg-light p-4 rounded shadow-sm">
        <h5 class="fw-bold mb-3 text-secondary">Médicos Dados de Baja</h5>
        <asp:GridView runat="server" ID="dgvMedicosInactivos" CssClass="table table-secondary table-hover" AutoGenerateColumns="False" OnRowCommand="dgvMedicosInactivos_RowCommand" EmptyDataText="No hay médicos inactivos.">
            <Columns>
                <asp:BoundField HeaderText="DNI" DataField="DNI" />
                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                <asp:BoundField HeaderText="Matricula" DataField="Matricula" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CommandName="ReactivarMed" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-success">Reactivar</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="pnlEspecialidadesInactivas" runat="server" Visible="false" CssClass="container my-4 bg-light p-4 rounded shadow-sm">
        <h5 class="fw-bold mb-3 text-secondary">Especialidades Dadas de Baja</h5>
        <asp:GridView runat="server" ID="dgvEspecialidadesInactivas" CssClass="table table-secondary table-hover" AutoGenerateColumns="False" OnRowCommand="dgvEspecialidadesInactivas_RowCommand" EmptyDataText="No hay especialidades inactivas.">
            <Columns>
                <asp:BoundField HeaderText="Especialidad" DataField="Nombre" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CommandName="ReactivarEsp" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-success">Reactivar</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
</asp:Content>

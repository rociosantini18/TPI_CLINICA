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
                </p>
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
        </div>
    </div>
     <%-- Tabla de especialidadesssss --%>
            <asp:Panel ID="pnlNuevaEspecialidad" runat="server" Visible="false"
            CssClass="row justify-content-center mt-4">
            <div class="col-md-6">
                <div class="card shadow-sm border-0 p-4 text-start">
                    <h5 class="fw-bold mb-3">Nueva Especialidad</h5>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtNombreEsp" runat="server" CssClass="form-control"
                            placeholder="Ej: Cardiología" />
                        <asp:RequiredFieldValidator runat="server"
                            ControlToValidate="txtNombreEsp"
                            ValidationGroup="vgEspecialidad"
                            ErrorMessage="El nombre es obligatorio."
                            CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Descripción:" CssClass="form-label fw-semibold" />
                        <asp:TextBox ID="txtDescripcionEsp" runat="server" CssClass="form-control"
                            TextMode="MultiLine" Rows="3"
                            placeholder="Descripción breve de la especialidad" />
                    </div>


                    <asp:Label ID="lblMensajeEsp" runat="server" CssClass="text-success fw-semibold" />

                    <div class="d-flex gap-2 mt-2">
                        <asp:Button ID="btnGuardarEsp" runat="server" Text="Guardar"
                            CssClass="btn btn-success"
                            ValidationGroup="vgEspecialidad"
                            OnClick="btnGuardarEsp_Click" />
                        <asp:Button ID="btnCancelarEsp" runat="server" Text="Cancelar"
                            CssClass="btn btn-outline-secondary"
                            CausesValidation="false"
                            OnClick="btnCancelarEsp_Click" />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>

    <div class="container my-5">
        <div class="row g-4 justify-content-center">
            <asp:GridView runat="server" ID="dgvMedicos" CssClass="table table-hover table-responsive" AutoGenerateColumns="False"  OnRowCommand="dgvMedicos_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="DNI" DataField="DNI" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Matricula" DataField="Matricula" />
                    <asp:BoundField HeaderText="Especialidad" DataField="Especialidad.Nombre" />
                    <asp:BoundField HeaderText="Fecha de Nacimiento" DataField="FechaNacimiento" />

                    <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:LinkButton runat="server"
                            CommandName="Eliminar"
                            CommandArgument='<%# Eval("Id") %>'
                            CssClass="btn btn-sm btn-outline-danger"
                            OnClientClick="return confirm('¿Seguro que querés dar de baja este médico?');">
                            Eliminar
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

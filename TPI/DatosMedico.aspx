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
                        <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="El email es obligatorio."
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
                            ErrorMessage="La direccion es obligatoria."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="URL Imagen:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtURL" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            ID="rfvURL"
                            runat="server"
                            ControlToValidate="txtURL"
                            ErrorMessage="La URL es obligatoria."
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-4">
                        <asp:Panel ID="pnlListaEspecialidades" runat="server">
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
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                    <asp:Button ID="btnAgregarEspecialidad" Text="Agregar Especialidad" runat="server" CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" OnClick="btnAgregarEspecialidad_Click" />

                                    <asp:Panel ID="pnlAgregarEspecialidad" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                                        <asp:DropDownList ID="ddlEspecialidadesDisponibles" runat="server" CssClass="form-select" />
                                        <asp:HiddenField ID="hdfAgregarEspecialidad" runat="server" />
                                        <p class="fw-semibold mb-2">¿Seguro que querés agregar esta especialidad?</p>
                                        <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-danger btn-sm me-2" CausesValidation="false" OnClick="btnAgregar_Click" />
                                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnCancelar_Click" />
                                        <asp:Label ID="lblEspecialidadRepetida" runat="server" CssClass="text-danger fw-semibold mb-3 d-block" Text="" Visible="false" />
                                    </asp:Panel>

                                    <asp:Panel ID="pnlConfirmarEliminarEsp" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                                        <asp:HiddenField ID="hfIdEliminarEsp" runat="server" />
                                        <p class="fw-semibold mb-2">¿Seguro que querés dar de baja esta especialidad?</p>
                                        <asp:Button ID="btnConfirmarEliminarEsp" runat="server" Text="Sí, eliminar" CssClass="btn btn-danger btn-sm me-2" CausesValidation="false" OnClick="btnConfirmarEliminarEsp_Click" />
                                        <asp:Button ID="btnCancelarEliminarEsp" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnCancelarEliminarEsp_Click" />
                                    </asp:Panel>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>

                    <hr class="my-4" />

                    <p class="lead text-muted mt-2">Datos de Inicio de Sesión</p>


                    <div class="mb-3">
                        <asp:Label runat="server" Text="Usuario:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Nueva contraseña:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
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

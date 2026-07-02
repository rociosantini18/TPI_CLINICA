<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="NuevoTurnoRecepcionista.aspx.cs" Inherits="TPI.NuevoTurnoRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Nuevo Turno</h1>
                <p class="lead text-muted mt-2">Buscá al paciente y completá los datos del turno.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm border-0 p-5">

                    <asp:UpdatePanel runat="server" ID="upFormularioTurno">
                        <ContentTemplate>
                            <h5 class="fw-bold mb-3">1. Buscar paciente</h5>
                            <div class="row g-2 align-items-end mb-2">
                                <div class="col-md-8">
                                    <asp:Label runat="server" Text="DNI o nombre del paciente:" CssClass="form-label fw-semibold"></asp:Label>
                                    <asp:TextBox ID="txtBuscarPaciente" runat="server" CssClass="form-control"
                                        placeholder="Ej: 45265789 o Vicente Melina"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:Button ID="btnBuscarPaciente" runat="server" Text="Buscar" OnClick="btnBuscarPaciente_Click"
                                        CssClass="btn w-100" BackColor="LightGreen" BorderColor="LightGreen" />
                                </div>
                            </div>
                            <asp:GridView runat="server" ID="dgvPacientes" CssClass="table table-hover table-responsive" 
                                          AutoGenerateColumns="False" 
                                          DataKeyNames="IdPaciente, Dni, Nombre, Apellido, ObraSocial" 
                                          AutoGenerateSelectButton="True" 
                                          OnSelectedIndexChanged="dgvPacientes_SelectedIndexChanged">
                                <Columns>
                                    <asp:BoundField DataField="Dni" HeaderText="DNI" />
                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                                </Columns>
                            </asp:GridView>

                            <asp:Panel ID="pnlPaciente" runat="server" Visible="false" CssClass="alert alert-success mt-3">
                                <div class="row">
                                    <div class="col-md-10">
                                        <small class="text-muted">Id del Paciente:</small>
                                        <p class="fw-bold mb-0">
                                            <asp:Label ID="lblPacienteId" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <small class="text-muted">Nombre:</small>
                                        <p class="fw-bold mb-0">
                                            <asp:Label ID="lblPacienteNombre" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <small class="text-muted">Apellido:</small>
                                        <p class="fw-bold mb-0">
                                            <asp:Label ID="lblPacienteApellido" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <small class="text-muted">DNI:</small>
                                        <p class="fw-bold mb-0">
                                            <asp:Label ID="lblPacienteDNI" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <small class="text-muted">Obra social:</small>
                                        <p class="fw-bold mb-0">
                                            <asp:Label ID="lblPacienteOS" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:Panel ID="pnlPacienteNoEncontrado" runat="server" Visible="false" CssClass="alert alert-warning mt-3">
                                <p class="mb-1">No se encontró el paciente. ¿Querés registrarlo?</p>
                                <a href="Registrarse.aspx" class="btn btn-sm btn-outline-secondary">Registrar paciente</a>
                            </asp:Panel>

                            <hr class="my-4" />

                            <h5 class="fw-bold mb-3">2. Datos del turno</h5>

                            <asp:Panel ID="pnlDatosMedico" runat="server" CssClass="alert alert-success mt-3">
                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Especialidad:" CssClass="form-label fw-semibold"></asp:Label>
                                    <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged">
                                        <asp:ListItem Text="Seleccione una especialidad" Value="" />
                                    </asp:DropDownList>
                                </div>

                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Médico:" CssClass="form-label fw-semibold"></asp:Label>
                                    <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlMedico_SelectedIndexChanged">
                                        <asp:ListItem Text="Seleccione un médico" Value="" />
                                    </asp:DropDownList>
                                </div>                                
                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Fechas disponibles:" CssClass="form-label fw-semibold"></asp:Label>
                                    <asp:DropDownList ID="ddlFechasDisponibles" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlFechasDisponibles_SelectedIndexChanged">
                                        <asp:ListItem Text="Seleccione una fecha" Value="" />
                                    </asp:DropDownList>
                                </div>
                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Horario disponible:" CssClass="form-label fw-semibold"></asp:Label>
                                    <asp:DropDownList ID="ddlHorario" runat="server" CssClass="form-select" AutoPostBack="true">
                                        <asp:ListItem Text="Seleccione un horario" Value="" />
                                    </asp:DropDownList>
                                </div>
                                <div class="mb-4">
                                    <asp:Label runat="server" Text="Observaciones:" CssClass="form-label fw-semibold"></asp:Label>
                                    <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control"
                                        TextMode="MultiLine" Rows="3"
                                        placeholder="Motivo de la consulta..."></asp:TextBox>
                                </div>
                            </asp:Panel>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <asp:Label ID="lblExito" runat="server" CssClass="text-success fw-bold mb-3 d-block" Visible="false"></asp:Label>
                    <asp:Label ID="lblError" runat="server" CssClass="text-danger mb-3 d-block" Visible="false"></asp:Label>

                    <div class="d-flex gap-2">
                        <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar Turno"
                            CssClass="btn btn-lg flex-grow-1" BackColor="LightGreen" BorderColor="LightGreen" OnClick="btnConfirmar_Click" />
                        <a href="PanelRecepcionista.aspx" class="btn btn-lg btn-outline-secondary">Cancelar</a>
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
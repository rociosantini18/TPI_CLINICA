<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="GestionarTurnos.aspx.cs" Inherits="TPI.GestionarTurnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Gestión de Turnos</h1>
                <p class="lead text-muted mt-2">Turnos pendientes ordenados por médico.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">

        <div class="row g-3 mb-4 align-items-end">
            <div class="col-md-3">
                <asp:Label runat="server" Text="Médico:" CssClass="form-label fw-semibold" />
                <asp:DropDownList ID="ddlFiltroMedico" runat="server" CssClass="form-select" />
            </div>
            <div class="col-md-3">
                <asp:Label runat="server" Text="Especialidad:" CssClass="form-label fw-semibold" />
                <asp:DropDownList ID="ddlFiltroEspecialidad" runat="server" CssClass="form-select" />
            </div>
            <div class="col-md-2">
                <asp:Label runat="server" Text="Estado:" CssClass="form-label fw-semibold" />
                <asp:DropDownList ID="ddlFiltroEstado" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Todos los estados" Value="" />
                    <asp:ListItem Text="Nuevo" Value="Nuevo" />
                    <asp:ListItem Text="Cancelado" Value="Cancelado" />
                    <asp:ListItem Text="Atendido" Value="Atendido" />
                </asp:DropDownList>
            </div>
            <div class="col-md-3">
                <asp:Label runat="server" Text="Fecha:" CssClass="form-label fw-semibold"></asp:Label>
                <asp:TextBox ID="txtFiltroFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="col-md-auto">
                <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar"
                    OnClick="btnFiltrar_Click"
                    CssClass="btn btn-success" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                    OnClick="btnLimpiar_Click"
                    CssClass="btn btn-outline-secondary" />
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-success">
                    <tr>
                        <th>N° Turno</th>
                        <th>Paciente</th>
                        <th>Médico</th>
                        <th>Especialidad</th>
                        <th>Fecha</th>
                        <th>Horario</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptTurnos" runat="server" OnItemCommand="rptTurnos_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Numero") %></td>
                                <td><%# Eval("Paciente.Apellido") %>, <%# Eval("Paciente.Nombre") %></td>
                                <td>Dr. <%# Eval("Medico.Apellido") %></td>
                                <td><%# Eval("Especialidad.Nombre") %></td>
                                <td><%# ((DateTime)Eval("Fecha")).ToString("dd/MM/yyyy") %></td>
                                <td>
                                    <%# ((TimeSpan)Eval("HoraInicio")).ToString(@"hh\:mm") %> -
                                    <%# ((TimeSpan)Eval("HoraFin")).ToString(@"hh\:mm") %>
                                </td>
                                <td>
                                    <span class='<%# ObtenerCssBadge((string)Eval("Estado")) %>'>
                                        <%# Eval("Estado") %>
                                    </span>
                                </td>
                                <td>
                                    <asp:Button CommandName="Cancelar"
                                        CommandArgument='<%# Eval("Id") %>'
                                        runat="server" Text="Cancelar"
                                        CssClass="btn btn-sm btn-outline-danger"
                                        Visible='<%# (string)Eval("Estado") != "Cancelado" && (string)Eval("Estado") != "Atendido" %>' />
                                <asp:Button CommandName="CargarDiagnostico"
                                        CommandArgument='<%# Eval("Id") %>'
                                        runat="server" Text="Cargar Diagnóstico"
                                        CssClass="btn btn-sm btn-outline-primary"
                                        Visible='<%# (string)Eval("Estado") != "Cancelado" && (string)Eval("Estado") != "Atendido" %>' />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Panel ID="pnlSinResultados" runat="server"
                                Visible='<%# rptTurnos.Items.Count == 0 %>'>
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        No se encontraron turnos con los filtros aplicados.
                                    </td>
                                </tr>
                            </asp:Panel>
                        </FooterTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        <div class="text-end mt-3">
            <asp:Button ID="btnNuevoTurno" runat="server" Text="+ Nuevo Turno"
                CssClass="btn btn-lg btn-success"
                PostBackUrl="NuevoTurnoRecepcionista.aspx" />
            <a href="PanelRecepcionista.aspx" class="btn btn-lg btn-outline-secondary">Cancelar</a>
        </div>

    </div>
            <asp:Panel ID="pnlDiagnostico" runat="server" Visible="false" CssClass="card border-primary my-4">
            <div class="card-header bg-primary text-white">
                Cargar Diagnóstico - Turno N° <asp:Label ID="lblNumeroTurnoSeleccionado" runat="server" />
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Diagnóstico</label>
                    <asp:TextBox ID="txtDiagnostico" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                </div>
                <asp:Button ID="btnGuardarDiagnostico" runat="server" Text="Guardar"
                    CssClass="btn btn-primary" OnClick="btnGuardarDiagnostico_Click" />
                <asp:Button ID="btnCancelarDiagnostico" runat="server" Text="Cancelar"
                    CssClass="btn btn-outline-secondary" CausesValidation="false"
                    OnClick="btnCancelarDiagnostico_Click" />
            </div>
        </asp:Panel>
</asp:Content>
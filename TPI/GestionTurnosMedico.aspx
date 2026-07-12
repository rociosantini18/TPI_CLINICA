<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="GestionTurnosMedico.aspx.cs" Inherits="TPI.GestionTurnosMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Gestión de Turnos</h1>
                <p class="lead text-muted mt-2">Turnos pendientes.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">

        <div class="row g-3 mb-4 align-items-end">
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

        <asp:Label ID="lblWarningAtendido" runat="server" CssClass="alert alert-warning d-block mb-3 fw-bold" Visible="false"></asp:Label>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-success">
                    <tr>
                        <th>N° Turno</th>
                        <th>Paciente</th>
                        <th>Especialidad</th>
                        <th>Fecha</th>
                        <th>Horario</th>
                        <th>Observaciones previas</th>
                        <th>Diagnostico</th>
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
                                <td><%# Eval("Especialidad.Nombre") %></td>
                                <td><%# ((DateTime)Eval("Fecha")).ToString("dd/MM/yyyy") %></td>
                                <td>
                                    <%# ((TimeSpan)Eval("HoraInicio")).ToString(@"hh\:mm") %> -
                                    <%# ((TimeSpan)Eval("HoraFin")).ToString(@"hh\:mm") %>
                                </td>
                                <td><%# Eval("Observaciones") %></td>
                                <td><%# Eval("Diagnostico") %></td>
                                <td>
                                    <span class='<%# ObtenerCssBadge((string)Eval("Estado")) %>'>
                                        <%# Eval("Estado") %>
                                    </span>
                                </td>
                                <td>
                                    <asp:Button CommandName="CargarDiagnostico"
                                        CommandArgument='<%# Eval("Id") %>'
                                        runat="server" Text="Cargar Diagnóstico"
                                        CssClass="btn btn-sm btn-outline-primary"
                                        Visible='<%# (string)Eval("Estado") != "Cancelado" && (string)Eval("Estado") != "Nuevo" && (string)Eval("Estado") != "Reprogramado"  && (string)Eval("Diagnostico") == null  %>' />
                                    <asp:Button CommandName="EditarDiagnostico"
                                        CommandArgument='<%# Eval("Id") %>'
                                        runat="server" Text="Editar Diagnóstico"
                                        CssClass="btn btn-sm btn-outline-primary"
                                        Visible='<%# (string)Eval("Estado") != "Cancelado" && (string)Eval("Estado") != "Nuevo" && (string)Eval("Estado") != "Reprogramado" %>'  />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Panel ID="pnlSinResultados" runat="server"
                                Visible='<%# rptTurnos.Items.Count == 0 %>'>
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">No se encontraron turnos con los filtros aplicados.
                                    </td>
                                </tr>
                                s
                            </asp:Panel>
                        </FooterTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
    <asp:Panel ID="pnlDiagnostico" runat="server" Visible="false" CssClass="card border-primary my-4">
        <div class="card-header bg-primary text-white">
            Cargar Diagnóstico - Turno N°
            <asp:Label ID="lblNumeroTurnoSeleccionado" runat="server" />
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

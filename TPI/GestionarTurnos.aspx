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
                    <asp:ListItem Text="Reprogramado" Value="Reprogramado" />
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
                                    <asp:Button CommandName="Reprogramar"
                                        CommandArgument='<%# Eval("Id") %>'
                                        runat="server" Text="Reprogramar"
                                        CssClass="btn btn-sm btn-outline-warning"
                                        Visible='<%# (string)Eval("Estado") != "Cancelado" && (string)Eval("Estado") != "Atendido" %>' />
                                    <asp:Button CommandName="Cancelar"
                                        CommandArgument='<%# Eval("Id") %>'
                                        runat="server" Text="Cancelar"
                                        CssClass="btn btn-sm btn-outline-danger"
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
        </div>

    </div>

</asp:Content>
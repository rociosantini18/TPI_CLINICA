<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="MisTurnos.aspx.cs" Inherits="TPI.MisTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Mis Turnos</h1>
                <p class="lead text-muted mt-2">Acá podés ver todos tus turnos, pasados y futuros.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">

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
                            <th>Médico</th>
                            <th>Especialidad</th>
                            <th>Fecha</th>
                            <th>Horario</th>
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
                                    <td>Dr. <%# Eval("Medico.Apellido") %></td>
                                    <td><%# Eval("Especialidad.Nombre") %></td>
                                    <td><%# ((DateTime)Eval("Fecha")).ToString("dd/MM/yyyy") %></td>
                                    <td>
                                        <%# ((TimeSpan)Eval("HoraInicio")).ToString(@"hh\:mm") %> -
                            <%# ((TimeSpan)Eval("HoraFin")).ToString(@"hh\:mm") %>
                                    </td>
                                    <td><%# Eval("Diagnostico") %></td>
                                    <td>
                                        <span class='<%#ObtenerCssBadge((string)Eval("Estado")) %>'>
                                            <%# Eval("Estado") %>
                                        </span>
                                    </td>
                                    <td>
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
                                        <td colspan="8" class="text-center text-muted py-4">No se encontraron turnos con los filtros aplicados.
                                        </td>
                                    </tr>
                                </asp:Panel>
                            </FooterTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="text-end mt-3">
                <div class="d-flex justify-content-end gap-2 mt-3">
                <asp:Button ID="btnNuevoTurno" runat="server" Text="+ Tomar nuevo turno"
                    CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen"
                    PostBackUrl="~/SacarTurno.aspx" />
                                <asp:Button ID="btnVolver" runat="server" Text="Cancelar" 
                                    CssClass="btn btn-lg btn-outline-secondary" 
                                    OnClick="btnVolver_Click" />
            </div>

        </div>
</asp:Content>

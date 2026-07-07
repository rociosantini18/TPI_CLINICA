<%@Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="HorariosMedicos.aspx.cs" Inherits="TPI.HorariosMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <h1 class="display-4 fw-bold">Horarios de Médicos</h1>
        <p class="lead text-muted">Configurá los horarios disponibles por médico.</p>
    </div>

    <div class="container my-5">
        <div class="row g-4">

            <div class="col-md-4">
                <div class="card shadow-sm border-0 p-4">
                    <h5 class="fw-bold mb-3">Agregar Horario</h5>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Médico:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlMedico_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Día del turno:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlDiaTurno" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Hora inicio:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtHoraInicio" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInicio" runat="server" ControlToValidate="txtHoraInicio" ValidationGroup="vgAgregar" ErrorMessage="Completá este campo" CssClass="text-danger small d-block" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Hora fin:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtHoraFin" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFin" runat="server" ControlToValidate="txtHoraFin" ValidationGroup="vgAgregar" ErrorMessage="Completá este campo" CssClass="text-danger small d-block" Display="Dynamic" />

                        <asp:Label ID="lblMensaje" runat="server" Visible="false" CssClass="mb-2 d-block"></asp:Label>
                    </div>

                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar Horario"
                        CssClass="btn w-100 mb-2" BackColor="LightGreen" BorderColor="LightGreen"
                        ValidationGroup="vgAgregar" OnClick="btnAgregar_Click" />
                    <a href="PanelRecepcionista.aspx" class="btn btn-lg btn-outline-secondary w-100">Cancelar</a>
                    
                    <hr class="my-4" />
                    <asp:Button ID="btnAbrirPanelDias" runat="server" Text="⚙️ Modificar días del médico" CssClass="btn btn-outline-primary w-100 mb-3" OnClick="btnAbrirPanelDias_Click" CausesValidation="false" formnovalidate="true" />

                    <asp:Panel ID="pnlModificarDias" runat="server" Visible="false" CssClass="border rounded p-3 bg-light">
                        <h6 class="fw-bold mb-2">Días Predeterminados:</h6>
                        <asp:CheckBoxList ID="cblDiasRecepcionista" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="d-flex gap-2 flex-wrap mb-3">
                            <asp:ListItem Text="Dom" Value="0" />
                            <asp:ListItem Text="Lun" Value="1" />
                            <asp:ListItem Text="Mar" Value="2" />
                            <asp:ListItem Text="Mié" Value="3" />
                            <asp:ListItem Text="Jue" Value="4" />
                            <asp:ListItem Text="Vie" Value="5" />
                            <asp:ListItem Text="Sáb" Value="6" />
                        </asp:CheckBoxList>
                        <asp:Label ID="lblMensajeDias" runat="server" CssClass="d-block mb-2 small fw-bold"></asp:Label>
                        
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnGuardarDias" runat="server" Text="Guardar" CssClass="btn btn-sm btn-primary w-100" OnClick="btnGuardarDias_Click" CausesValidation="false" formnovalidate="true" />
                            <asp:Button ID="btnCancelarDias" runat="server" Text="Cerrar" CssClass="btn btn-sm btn-outline-secondary w-100" OnClick="btnCancelarDias_Click" CausesValidation="false" formnovalidate="true" />
                        </div>
                    </asp:Panel>

                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm border-0 p-4">
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0">Horarios del médico seleccionado</h5>
                        <asp:Label ID="lblDiaAtencionVista" runat="server" CssClass="badge bg-success fs-6 text-uppercase px-3 py-2" Text="" Visible="false"></asp:Label>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-success">
                                <tr>
                                    <th>Día</th>
                                    <th>Hora inicio</th>
                                    <th>Hora fin</th>
                                    <th>Eliminar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptHorarios" runat="server" OnItemCommand="rptHorarios_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="fw-semibold text-success"><%# TraducirDia((DayOfWeek)Eval("DiaSemana")) %></td>
                                            <td><%# ((TimeSpan)Eval("HoraInicio")).ToString(@"hh\:mm") %></td>
                                            <td><%# ((TimeSpan)Eval("HoraFin")).ToString(@"hh\:mm") %></td>
                                            <td>
                                                <asp:Button CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' runat="server" Text="Eliminar" CssClass="btn btn-sm btn-outline-danger" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
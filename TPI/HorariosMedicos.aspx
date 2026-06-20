<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="HorariosMedicos.aspx.cs" Inherits="TPI.HorariosMedicos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container-fluid text-center py-5" style="background-color:#f8fff8;">
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
                    <asp:Label runat="server" Text="Día:" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlDia" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Lunes" Value="1" />
                        <asp:ListItem Text="Martes" Value="2" />
                        <asp:ListItem Text="Miércoles" Value="3" />
                        <asp:ListItem Text="Jueves" Value="4" />
                        <asp:ListItem Text="Viernes" Value="5" />
                        <asp:ListItem Text="Sábado" Value="6" />
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <asp:Label runat="server" Text="Hora inicio:" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtHoraInicio" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:Label runat="server" Text="Hora fin:" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtHoraFin" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                </div>

                <asp:Label ID="lblMensaje" runat="server" Visible="false" CssClass="mb-2 d-block"></asp:Label>

                <asp:Button ID="btnAgregar" runat="server" Text="Agregar Horario"
                    CssClass="btn w-100" BackColor="LightGreen" BorderColor="LightGreen"
                    OnClick="btnAgregar_Click" />
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm border-0 p-4">
                <h5 class="fw-bold mb-3">Horarios del médico seleccionado</h5>
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
                                        <td><%# Eval("DiaSemana") %></td>
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
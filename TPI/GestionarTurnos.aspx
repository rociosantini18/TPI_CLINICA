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
                <asp:Label runat="server" Text="Médico:" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlFiltroMedico" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Todos los médicos" Value="" />
                </asp:DropDownList>
            </div>
            <div class="col-md-3">
                <asp:Label runat="server" Text="Especialidad:" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlFiltroEspecialidad" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Todas" Value="" />
                    <asp:ListItem Text="Nutrición" Value="1" />
                    <asp:ListItem Text="Psicología" Value="2" />
                    <asp:ListItem Text="Clínica Médica" Value="3" />
                    <asp:ListItem Text="Ginecología" Value="4" />
                    <asp:ListItem Text="Dermatología" Value="5" />
                    <asp:ListItem Text="Pediatría" Value="6" />
                </asp:DropDownList>
            </div>
            <div class="col-md-3">
                <asp:Label runat="server" Text="Estado:" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlFiltroEstado" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Todos" Value="" />
                    <asp:ListItem Text="Nuevo" Value="Nuevo" />
                    <asp:ListItem Text="Reprogramado" Value="Reprogramado" />
                    <asp:ListItem Text="Cancelado" Value="Cancelado" />
                    <asp:ListItem Text="No Asistió" Value="NoAsistio" />
                    <asp:ListItem Text="Cerrado" Value="Cerrado" />
                </asp:DropDownList>
            </div>
            <div class="col-md-3">
                <asp:Label runat="server" Text="Fecha:" CssClass="form-label fw-semibold"></asp:Label>
                <asp:TextBox ID="txtFiltroFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="col-md-auto">
                <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar"
                    CssClass="btn" BackColor="LightGreen" BorderColor="LightGreen" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                    CssClass="btn btn-outline-secondary ms-2" />
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
                    <tr>
                        <td>#0001</td>
                        <td>Vicente, Melina</td>
                        <td>Dr. García</td>
                        <td>Clínica Médica</td>
                        <td>10/06/2025</td>
                        <td>10:00 - 11:00</td>
                        <td><span class="badge text-bg-success">Nuevo</span></td>
                        <td>
                            <a href="#" class="btn btn-sm btn-outline-warning">Reprogramar</a>
                            <a href="#" class="btn btn-sm btn-outline-danger">Cancelar</a>
                        </td>
                    </tr>
                    <tr>
                        <td>#0002</td>
                        <td>Gomez, Juan</td>
                        <td>Dra. López</td>
                        <td>Dermatología</td>
                        <td>11/06/2025</td>
                        <td>15:00 - 16:00</td>
                        <td><span class="badge text-bg-warning text-dark">Reprogramado</span></td>
                        <td>
                            <a href="#" class="btn btn-sm btn-outline-warning">Reprogramar</a>
                            <a href="#" class="btn btn-sm btn-outline-danger">Cancelar</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="text-end mt-3">
            <asp:Button ID="btnNuevoTurno" runat="server" Text="+ Nuevo Turno"
                CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen"
                PostBackUrl="NuevoTurnoRecepcionista.aspx" />
        </div>

    </div>

</asp:Content>
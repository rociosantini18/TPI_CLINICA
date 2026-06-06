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

        <div class="row g-3 mb-4 align-items-end">
            <div class="col-md-4">
                <asp:Label runat="server" Text="Filtrar por estado:" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Todos" Value="" />
                    <asp:ListItem Text="Nuevo" Value="Nuevo" />
                    <asp:ListItem Text="Reprogramado" Value="Reprogramado" />
                    <asp:ListItem Text="Cancelado" Value="Cancelado" />
                    <asp:ListItem Text="No Asistió" Value="NoAsistio" />
                    <asp:ListItem Text="Cerrado" Value="Cerrado" />
                </asp:DropDownList>
            </div>
            <div class="col-md-auto">
                <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar"
                    CssClass="btn" BackColor="LightGreen" BorderColor="LightGreen" />
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-success">
                    <tr>
                        <th>N° Turno</th>
                        <th>Fecha</th>
                        <th>Horario</th>
                        <th>Especialidad</th>
                        <th>Médico</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#0001</td>
                        <td>10/06/2025</td>
                        <td>10:00 - 11:00</td>
                        <td>Psicología</td>
                        <td>Taylor Swift</td>
                        <td><span class="badge text-bg-success">Nuevo</span></td>
                        <td>
                            <a href="#" class="btn btn-sm btn-outline-warning">Reprogramar</a>
                            <a href="#" class="btn btn-sm btn-outline-danger">Cancelar</a>
                        </td>
                    </tr>
                    <tr>
                        <td>#0002</td>
                        <td>02/05/2025</td>
                        <td>15:00 - 16:00</td>
                        <td>Dermatología</td>
                        <td>Dra. López</td>
                        <td><span class="badge text-bg-secondary">Cerrado</span></td>
                        <td>
                            <a href="#" class="btn btn-sm btn-outline-warning disabled">Reprogramar</a>
                            <a href="#" class="btn btn-sm btn-outline-danger disabled">Cancelar</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="text-end mt-3">
            <asp:Button ID="btnNuevoTurno" runat="server" Text="+ Tomar nuevo turno"
                CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen"
                PostBackUrl="~/SacarTurno.aspx" />
        </div>

    </div>

</asp:Content>
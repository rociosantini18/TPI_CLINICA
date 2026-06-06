<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="SacarTurno.aspx.cs" Inherits="TPI.SacarTurno1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h1 class="display-4 fw-bold">Tomar Turno</h1>
                <p class="lead text-muted mt-2">Seleccioná la especialidad y el médico para reservar tu turno.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-5">

                    <h5 class="fw-bold mb-4 text-center">Datos del turno</h5>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Especialidad:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccione una especialidad" Value="" />
                            <asp:ListItem Text="Nutrición" Value="1" />
                            <asp:ListItem Text="Psicología" Value="2" />
                            <asp:ListItem Text="Clínica Médica" Value="3" />
                            <asp:ListItem Text="Ginecología" Value="4" />
                            <asp:ListItem Text="Dermatología" Value="5" />
                            <asp:ListItem Text="Pediatría" Value="6" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Médico:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccione un médico" Value="" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Fecha:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Horario disponible:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlHorario" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccione un horario" Value="" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" Text="Observaciones:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"
                            placeholder="Contanos brevemente el motivo de la consulta..."></asp:TextBox>
                    </div>

                    <div class="d-grid">
                        <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar Turno"
                            CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" />
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
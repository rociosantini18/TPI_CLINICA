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

                    <asp:UpdatePanel runat="server" ID="upTurnoPaciente">
                        <ContentTemplate>
                            <asp:Panel runat="server" ID="pnlDatosTurno">
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


                    <div class="d-grid">
                        <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar Turno"
                            CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" OnClick="btnConfirmar_Click" />
                                               <asp:Button ID="btnVolver" runat="server" Text="Cancelar" 
                                    CssClass="btn btn-lg btn-outline-secondary" 
                                    OnClick="btnVolver_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

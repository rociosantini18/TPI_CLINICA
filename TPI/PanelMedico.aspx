<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="PanelMedico.aspx.cs" Inherits="TPI.PanelMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="text-end mb-3">
                    <asp:Button ID="btnMisDatos" runat="server" Text="Mis Datos" OnClick="btnMisDatos_Click"
                        CssClass="btn btn-primary w-15 py-3 fs-5" />
                </div>
                <h1 class="display-4 fw-bold">Gestion Medica</h1>
                <p class="lead text-muted mt-2">
                    Bienvenida,
    <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
                </p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row g-4 justify-content-center">

            <div class="col-md-4">
                <div class="card border-0 shadow-sm text-center p-4 h-100">
                    <div class="mb-3" style="font-size: 3rem;"></div>
                    <h5 class="fw-bold">Gestionar Turnos</h5>
                    <p class="text-muted small">Ver y administrar los turnos pendientes.</p>
                    <asp:Button ID="btnGestionTurnos" runat="server" Text="Ver Turnos"
                        CssClass="btn mt-auto" BackColor="LightGreen" BorderColor="LightGreen" OnClick="btnGestionTurnos_Click"/>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm text-center p-4 h-100">
                    <div class="mb-3" style="font-size: 3rem;"></div>
                    <h5 class="fw-bold"> Mis Horarios</h5>
                    <p class="text-muted small">Configurar mis horarios disponibles.</p>
                    <asp:Button ID="btnHorarios" runat="server" Text="Gestionar Horarios"
                        CssClass="btn mt-auto" BackColor="LightGreen" BorderColor="LightGreen"
                        PostBackUrl="HorariosMedicos.aspx" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>

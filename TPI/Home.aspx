<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TPI.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Label ID="lblTitulo" CssClass="display-2 fw-bold" runat="server" Text="BIENVENIDO A PROMEDIC"></asp:Label>
                <p class="lead mt-3 fs-5 text-muted">Tu clínica médica de confianza. Gestioná tus turnos de forma rápida y sencilla.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row g-4 justify-content-center">
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0 text-center p-4">
                    <h5 class="fw-bold">Para pacientes</h5>
                    <h6 class="text-muted">Médicos Especializados</h6>
                    <p class="mt-2">Contamos con profesionales en múltiples especialidades para atender todas tus necesidades.</p>
                    <a href="Especialidades.aspx" class="d-inline-flex focus-ring py-1 px-2 text-decoration-none border rounded-2" style="--bs-focus-ring-x: 10px; --bs-focus-ring-y: 10px; --bs-focus-ring-blur: 4px">
                     Ver todas las especialidades</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0 text-center p-4">
                    <h5 class="fw-bold">Para pacientes</h5>
                    <h6 class="text-muted">Turnos Online</h6>
                    <p class="mt-2">Reservá tu turno desde cualquier lugar, en cualquier momento, de manera fácil y rápida.</p>
                    <a href="SacarTurno.aspx" class="d-inline-flex focus-ring py-1 px-2 text-decoration-none border rounded-2" style="--bs-focus-ring-x: 10px; --bs-focus-ring-y: 10px; --bs-focus-ring-blur: 4px">
                     Sacar turno online</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0 text-center p-4">
                    <h5 class="fw-bold">Para médicos</h5>
                    <h6 class="text-muted">Historial de Pacientes</h6>
                    <p class="mt-2">Accedé al historial médico completo de cada paciente de forma segura y organizada.</p>
                    <a href="InicioSesion.aspx" class="d-inline-flex focus-ring py-1 px-2 text-decoration-none border rounded-2" style="--bs-focus-ring-x: 10px; --bs-focus-ring-y: 10px; --bs-focus-ring-blur: 4px">
                     Inicia Sesion</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
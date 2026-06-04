<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="SobreNosotros.aspx.cs" Inherits="TPI.SobreNosotros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Label ID="lblTitulo" CssClass="display-2 fw-bold" runat="server" Text="SOBRE NOSOTROS"></asp:Label>
                <p class="lead mt-3 text-muted">Conocé quiénes somos y por qué elegimos la salud como vocación.</p>
            </div>
        </div>
    </div>


    <div class="container my-5">
        <div class="row align-items-center g-5">
            <div class="col-md-6">
                <h2 class="fw-bold mb-3">¿Quiénes somos?</h2>
                <p class="text-muted fs-5">PROMEDIC es un centro médico integral ubicado en Buenos Aires, Argentina. Desde 2010 brindamos atención de calidad con un equipo de profesionales comprometidos con la salud y el bienestar de nuestros pacientes.</p>
                <p class="text-muted fs-5">Contamos con varias especialidades y un sistema de turnos online para que puedas acceder a la atención que necesitás de forma rápida y sencilla.</p>
            </div>
            <div class="col-md-6 text-center">
                <img src="Imagenes/clinica medica.JPG" alt="ClinicaMedica" style="width: 600px; height: 500px; object-fit: cover;" class="shadow p-3 mb-5 bg-white rounded-4"  />
            </div>
        </div>
    </div>

    <hr class="container" />


    <div class="container my-5">
        <h2 class="fw-bold text-center mb-5">Nuestros valores</h2>
        <div class="row g-4 text-center">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <h5 class="fw-bold mt-3">Vocación</h5>
                    <p class="text-muted">Elegimos la salud porque nos importa el bienestar de las personas.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <h5 class="fw-bold mt-3">Compromiso</h5>
                    <p class="text-muted">Acompañamos a cada paciente con dedicación y responsabilidad.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <h5 class="fw-bold mt-3">Excelencia</h5>
                    <p class="text-muted">Nos actualizamos constantemente para ofrecer la mejor atención.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <h5 class="fw-bold mt-3">Bienestar</h5>
                    <p class="text-muted">Promovemos una vida saludable más allá de la consulta médica.</p>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
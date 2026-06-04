<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="Especialidades.aspx.cs" Inherits="TPI.Especialidades" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Label ID="lblTitulo" CssClass="display-2 fw-bold" runat="server" Text="NUESTRAS ESPECIALIDADES"></asp:Label>
                <p class="lead mt-3 text-muted">Contamos con profesionales en distintas áreas para cuidar tu salud integral.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row g-4">

         <div class="col-md-4">
             <div class="card h-100 shadow-sm border-0 text-center p-4">
                <img src="Imagenes/nutricionista.JPG" alt="Nutricionista" class="rounded-circle mx-auto mb-3"style="width: 120px; height: 120px; object-fit: cover;" />
                  <h5 class="fw-bold">Nutricion</h5>
                  <p class="text-muted">Asesoramiento en alimentación saludable, dietas y buena relacion con las comidas.</p>
                 </div>
            </div>

         <div class="col-md-4">
             <div class="card h-100 shadow-sm border-0 text-center p-4">
                <img src="Imagenes/Psicologa.png" alt="Psicologa" class="rounded-circle mx-auto mb-3"style="width: 120px; height: 120px; object-fit: cover;" />
                  <h5 class="fw-bold">Psicologia</h5>
                  <p class="text-muted">Atención de la salud mental, tratamiento de ansiedad, depresión y acompañamiento terapéutico.</p>
                 </div>
            </div>

         <div class="col-md-4">
             <div class="card h-100 shadow-sm border-0 text-center p-4">
                <img src="Imagenes/clinico medico.JPG" alt="MedicoClinico" class="rounded-circle mx-auto mb-3"style="width: 120px; height: 120px; object-fit: cover;" />
                  <h5 class="fw-bold">Medico clinico</h5>
                  <p class="text-muted">Diagnóstico y tratamiento de enfermedades generales, controles de salud y derivaciones a especialistas.</p>
                 </div>
            </div>

         <div class="col-md-4">
             <div class="card h-100 shadow-sm border-0 text-center p-4">
                <img src="Imagenes/ginecologa.JPG" alt="Ginecologa" class="rounded-circle mx-auto mb-3"style="width: 120px; height: 120px; object-fit: cover;" />
                  <h5 class="fw-bold">Ginecologia</h5>
                  <p class="text-muted">Salud reproductiva femenina, controles ginecológicos, embarazo y seguimiento hormonal.</p>
                 </div>
            </div>

         <div class="col-md-4">
             <div class="card h-100 shadow-sm border-0 text-center p-4">
                <img src="Imagenes/dermatologa.JPG" alt="Dermatologa" class="rounded-circle mx-auto mb-3"style="width: 120px; height: 120px; object-fit: cover;" />
                  <h5 class="fw-bold">Dermatologia</h5>
                  <p class="text-muted">Diagnóstico y tratamiento de enfermedades de la piel, cabello y uñas. Control de lunares y tratamientos estéticos.

</p>
                 </div>
            </div>

         <div class="col-md-4">
             <div class="card h-100 shadow-sm border-0 text-center p-4">
                <img src="Imagenes/pediatra.JPG" alt="Pediatra" class="rounded-circle mx-auto mb-3"style="width: 120px; height: 120px; object-fit: cover;" />
                  <h5 class="fw-bold">Pedriatria</h5>
                  <p class="text-muted">Atención médica integral para bebés, niños y adolescentes. Controles de crecimiento y vacunación.</p>
                 </div>
            </div>

        </div>
    </div>

</asp:Content>
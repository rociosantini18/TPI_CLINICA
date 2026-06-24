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
        <asp:Repeater ID="repEspecialidades" runat="server">
            <ItemTemplate>
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0 text-center p-4">
                        <img src='<%# Eval("imagenURL") %>' alt='<%# Eval("Especialidad.Nombre") %>'
                            class="rounded-circle mx-auto mb-3"
                            style="width: 120px; height: 120px; object-fit: cover;" />
                        <h5 class="fw-bold"><%# Eval("Especialidad.Nombre") %></h5>
                        <p class="text-muted"><%# Eval("Especialidad.Descripcion") %></p>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

</asp:Content>
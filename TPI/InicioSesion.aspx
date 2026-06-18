<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="InicioSesion.aspx.cs" Inherits="TPI.InicioSesion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"> </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
  <div style="width: 100%; max-width: 680px;">

    <div class="text-center mb-4">
      <div class="rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
           style="width:64px; height:64px; background-color:#d4edda;">
        <span style="font-size:28px; color:#28a745;">+</span>
      </div>
      <h1 class="fs-4 fw-500 mb-1">PROMEDIC</h1>
      <p class="text-muted" style="font-size:14px;">Sistema de gestión de turnos médicos</p>
    </div>

    <div class="row g-3">

      <div class="col-md-6">
        <div class="card border h-100 p-4">
          <h5 class="fw-semibold mb-1">Ya soy usuario</h5>
          <p class="text-muted small">Si ya tenés una cuenta en PROMEDIC, ingresá con tu usuario y contraseña.</p>

          <div class="mb-3">
            <asp:Label runat="server" Text="Usuario" CssClass="form-label small text-muted"></asp:Label>
            <asp:TextBox ID="txtbUser" runat="server" CssClass="form-control" placeholder="Ingresá tu usuario"></asp:TextBox>
          </div>
          <div class="mb-3">
            <asp:Label runat="server" Text="Contraseña" CssClass="form-label small text-muted"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingresá tu contraseña"></asp:TextBox>
          </div>

           <asp:Label ID="lblError" runat="server" Visible="false" CssClass="text-danger small"></asp:Label>
          <asp:Button ID="btnIngresar" runat="server" Text="Ingresar →"
            CssClass="btn w-100" BackColor="LightGreen" BorderColor="LightGreen" onClick="btnIngresar_Click"/>

        </div>
      </div>

      <div class="col-md-6">
        <div class="card border h-100 p-4">
          <h5 class="fw-semibold mb-1">Primera vez</h5>
          <p class="text-muted small">Si nunca generaste tu usuario en PROMEDIC, registrate para acceder al sistema.</p>

          <ul class="list-unstyled small text-muted bg-light rounded p-3 mb-3">
            <li> - Gestioná tus turnos online</li>
            <li> - Accedé a tu historial médico</li>
          </ul>

          <asp:Button ID="btnRegistrarse" runat="server" Text="Registrarse →"
            CssClass="btn btn-outline-secondary w-100 mt-auto" PostBackUrl="~/Registrarse.aspx" />
        </div>
      </div>

    </div>

    <p class="text-center text-muted mt-3" style="font-size:12px;">
      ¿Problemas para ingresar? Contactanos en promedic@gmail.com
    </p>

  </div>
</div>
</asp:Content>
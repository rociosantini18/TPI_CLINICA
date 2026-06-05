<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="SacarTurno.aspx.cs" Inherits="TPI.SacarTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Label ID="lblTitulo" CssClass="display-2 fw-bold" runat="server" Text="SACAR TURNO"></asp:Label>
                <p class="lead mt-3 text-muted">Completá el formulario con los datos del paciente que va a asistir al turno.</p>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-5">

                    <h4 class="fw-bold mb-4 text-center">Datos del turno</h4>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Nombre completo:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Melina Vicente"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="Ej: 45265789"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 11-1234-5678"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Ej: meli@gmail.com"></asp:TextBox>
                    </div>

                    <div class="form-check">
                      <input class="form-check-input" type="checkbox" value="" id="checkDefault">
                      <label class="form-check-label" for="checkDefault">
                        Marca esta opción si tenes obra social
                      </label>
                    </div>

                    <div class="mb-3 mt-2">
                        <asp:Label runat="server" Text="Especialidad:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccione una especialidad" Value="" />
                            <asp:ListItem Text="Nutricionista" Value="nutricionista" />
                            <asp:ListItem Text="Psicología" Value="psicologia" />
                            <asp:ListItem Text="Clínica Médica" Value="clinica" />
                            <asp:ListItem Text="Ginecología" Value="ginecologia" />
                            <asp:ListItem Text="Dermatología" Value="dermatologia" />
                            <asp:ListItem Text="Pediatría" Value="pediatria" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Fecha preferida:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" Text="Turno preferido:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlHorario" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccione un horario" Value="" />
                            <asp:ListItem Text="8 am" Value="mañana" />
                            <asp:ListItem Text="10 am" Value="mañana" />
                            <asp:ListItem Text="15 pm" Value="tarde" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" Text="Observaciones:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Contanos brevemente el motivo de la consulta..."></asp:TextBox>
                    </div>

                    <div class="d-grid">
                        <asp:Button ID="btnConfirmar" runat="server" CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" Text="Confirmar Turno" /> 
                    </div>
            </div>
        </div>
    </div>

</asp:Content>
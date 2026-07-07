<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="RegistrarMedico.aspx.cs" Inherits="TPI.RegistrarMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center py-5" style="background-color: #f8fff8;">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Label ID="lblTitulo" CssClass="display-2 fw-bold" runat="server" Text="REGISTRAR MEDICO "></asp:Label>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 p-5">

                    <h4 class="fw-bold mb-4 text-center">Datos personales</h4>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Nombre:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es obligatorio" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" Text="Apellido:" CssClass="form-label fw-semibold"></asp:Label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido es obligatorio" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="DNI:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDni" ErrorMessage="El dni es obligatorio" CssClass="text-danger small" Display="Dynamic"> </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDNI" ValidationExpression="^\d{7,8}$" ErrorMessage="El DNI debe tener 8 numeros, sin puntos ni espacios." CssClass="text-danger small" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Fecha de nacimiento:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:CustomValidator ID="cvFecha" runat="server" ControlToValidate="txtFechaNacimiento" ErrorMessage="La fecha de nacimiento no puede ser una fecha futura." CssClass="text-danger small" Display="Dynamic" ValidateEmptyText="true" OnServerValidate="cvFecha_ServerValidate" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Teléfono:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTelefono" ErrorMessage="El telefono es obligatorio." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono" ValidationExpression="^[\d\s\-\+]{7,15}$" ErrorMessage="El telefono solo puede contener numeros, guiones y espacios." CssClass="text-danger small" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Dirección:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDireccion" ErrorMessage="La dirección es obligatoria." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Email:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="El email es obligatorio." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="El formato del email no es válido." CssClass="text-danger small" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Especialidad:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Matricula:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMatricula" ErrorMessage="La matricula es obligatoria." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="Días de Atención:" CssClass="form-label fw-semibold" />
                        <div class="border rounded p-2 bg-light">
                            <asp:CheckBoxList ID="cblDias" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="d-flex gap-3 flex-wrap">
                                <asp:ListItem Text="Dom" Value="0" />
                                <asp:ListItem Text="Lun" Value="1" />
                                <asp:ListItem Text="Mar" Value="2" />
                                <asp:ListItem Text="Mié" Value="3" />
                                <asp:ListItem Text="Jue" Value="4" />
                                <asp:ListItem Text="Vie" Value="5" />
                                <asp:ListItem Text="Sáb" Value="6" />
                            </asp:CheckBoxList>
                        </div>
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" Text="URL Imagen:" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtImagenURL" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtImagenURL" ErrorMessage="La imagen es obligatoria." CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <asp:Label ID="lblError" runat="server" CssClass="text-danger mb-3 d-block" Visible="false"></asp:Label>

                    <div class="d-grid">
                        <asp:Button ID="btnRegistrarMedico" runat="server" CssClass="btn btn-lg" BackColor="LightGreen" BorderColor="LightGreen" Text="Agregar Medico" OnClick="btn_registrarMedico_click" />
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
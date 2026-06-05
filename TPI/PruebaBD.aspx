<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDefault.Master" AutoEventWireup="true" CodeBehind="PruebaBD.aspx.cs" Inherits="TPI.PruebaBD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="mb-3">
            <asp:Label ID="lblUser" runat="server" Text="Usuarios" CssClass="display-4 fw-bold"></asp:Label>
        </div>
        <div class="mb-4">
        </div>
            <asp:GridView runat="server" ID="dgvUsuarios" CssClass ="table"></asp:GridView>
</asp:Content>

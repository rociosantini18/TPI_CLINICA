using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;
using TPI.Negocio;

namespace TPI
{
    public partial class Registrarse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PacienteNegocio negocio = new PacienteNegocio();
                ddlObraSocial.DataSource = negocio.listarObrasSociales();
                ddlObraSocial.DataTextField = "Value";
                ddlObraSocial.DataValueField = "Key";
                ddlObraSocial.DataBind();
            }
        }

        protected void btn_registrarse_click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                Paciente pac = new Paciente();
                pac.Nombre = txtNombre.Text.Trim();
                pac.Apellido = txtApellido.Text.Trim();
                pac.Dni = txtDNI.Text.Trim();
                pac.FechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                pac.Telefono = txtTelefono.Text.Trim();
                pac.Direccion = txtDireccion.Text.Trim();
                pac.Email = txtEmail.Text.Trim();
                pac.IdObraSocial = int.Parse(ddlObraSocial.SelectedValue);

                pac.Perfil = new Perfil();
                pac.Perfil.NombreUsuario = txtUsuario.Text.Trim();
                pac.Perfil.Contraseña = txtPassword.Text.Trim();

                PacienteNegocio negocio = new PacienteNegocio();
                negocio.agregar(pac);

                lblExito.Text = "¡Cuenta creada con éxito! Ya podés iniciar sesión.";
                lblExito.CssClass = "alert alert-success fw-bold mb-4 d-block text-center fs-5";
                lblExito.Visible = true;
                lblError.Visible = false;

                pnlRegistro.Visible = false;
            }
            catch (Exception ex)
            {
                lblError.Text = "Error al registrarse: " + ex.Message;
                lblError.CssClass = "alert alert-danger fw-bold mb-4 d-block";
                lblError.Visible = true;
            }
        }

        protected void cvFecha_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrWhiteSpace(args.Value))
            {
                args.IsValid = false;
                return;
            }
            DateTime fechaIngresada;
            if (DateTime.TryParse(args.Value, out fechaIngresada))
            {
                args.IsValid = fechaIngresada < DateTime.Today;
            }
            else
            {
                args.IsValid = false;
            }
        }
    }
}
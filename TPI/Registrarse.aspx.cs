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

                ddlObraSocial.Items.Insert(0, new ListItem("-- Sin obra social --", "0"));
            }
        }

        protected void btn_registrarse_click(object sender, EventArgs a)
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

                int idObraSocial = int.Parse(ddlObraSocial.SelectedValue);
                pac.IdObraSocial = idObraSocial;

                pac.Perfil = new Perfil();
                pac.Perfil.NombreUsuario = txtEmail.Text.Trim();
                pac.Perfil.Contraseña = txtPassword.Text;
                pac.Perfil.Activo = true;
                pac.Perfil.Id = 2;

                PacienteNegocio negocio = new PacienteNegocio();
                negocio.agregar(pac); 

                lblError.Visible = true;
                lblError.CssClass = "text-success mb-3 d-block";
                lblError.Text = "¡Registro exitoso!";
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.CssClass = "text-danger mb-3 d-block";
                lblError.Text = "Error: " + ex.Message;
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
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
    public partial class MisDatos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol != "Cliente")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                PacienteNegocio negocio = new PacienteNegocio();
                Paciente paciente = negocio.RelacionPerfilPersona(id);

                txtDNI.Text = paciente.Dni;
                txtNombre.Text = paciente.Nombre;
                txtApellido.Text = paciente.Apellido;
                txtTelefono.Text = paciente.Telefono;
                txtFechaNacimiento.Text = paciente.FechaNacimiento.ToString("yyyy-MM-dd"); 
                ddlObraSocial.DataSource = negocio.listarObrasSociales();
                ddlObraSocial.DataTextField = "Value";
                ddlObraSocial.DataValueField = "Key";
                ddlObraSocial.DataBind();
                ddlObraSocial.SelectedValue = paciente.IdObraSocial.ToString();
                txtEmail.Text = paciente.Email;
                txtDireccion.Text = paciente.Direccion;

            }


        }
    }
}
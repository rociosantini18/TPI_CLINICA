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
    public partial class DatosEmpleado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol != "Recepcionista" && perfil.Rol != "Administrador")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                EmpleadoNegocio negocio = new EmpleadoNegocio();
                Empleado empleado = negocio.RelacionPerfilPersona(id);

                txtDNI.Text = empleado.Dni;
                txtNombre.Text = empleado.Nombre;
                txtApellido.Text = empleado.Apellido;
                txtTelefono.Text = empleado.Telefono;
                txtFechaNacimiento.Text = empleado.FechaNacimiento.ToString("yyyy-MM-dd");
                txtEmail.Text = empleado.Email;
                txtDireccion.Text = empleado.Direccion;

            }

        }
    }
}
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

            if (!IsPostBack)
            {
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {

                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"].ToString());

                    EmpleadoNegocio negocio = new EmpleadoNegocio();
                    Empleado empleado = new Empleado();
                    empleado = negocio.RelacionPerfilPersona(id);

                    if (empleado == null)
                    {
                        throw new Exception("No se encontró el empleado.");
                    }

                    empleado.Dni = txtDNI.Text;
                    empleado.Nombre = txtNombre.Text;
                    empleado.Apellido = txtApellido.Text;
                    empleado.Telefono = txtTelefono.Text;
                    empleado.FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text); ;
                    empleado.Email = txtEmail.Text;
                    empleado.Direccion = txtDireccion.Text;

                    negocio.modificar(empleado);

                    lblExito.Text = "¡Datos guardados con éxito!";
                    lblExito.Visible = true;
                    lblError.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.CssClass = "text-danger mb-3 d-block";
                lblError.Text = "Error: " + ex.Message;
                throw;
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol == "Recepcionista" && Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                Response.Redirect("~/PanelRecepcionista.aspx?id=" + id);
                return;
            }

            if (perfil.Rol == "Administrador" && Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                Response.Redirect("~/AdminGestionPacientes.aspx?id=" + id);
                return;
            }
        }
    }
}
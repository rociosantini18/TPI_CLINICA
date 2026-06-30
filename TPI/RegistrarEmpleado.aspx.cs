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
    public partial class RegistrarEmpleado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = "";
                lblError.Text = "";
            }
        }
        protected void ddlTipoEmpleado_SelectedIndexChanged(object sender, EventArgs e)
        {
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

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (Page.IsValid)
            {
                EmpleadoNegocio negocio = new EmpleadoNegocio();
                Empleado nuevo = new Empleado();

                try
                {
                    nuevo.Nombre = txtNombre.Text.Trim();
                    nuevo.Apellido = txtApellido.Text.Trim();
                    nuevo.Dni = txtDNI.Text.Trim();
                    nuevo.FechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                    nuevo.Telefono = txtTelefono.Text.Trim();
                    nuevo.Direccion = txtDireccion.Text.Trim();
                    nuevo.Email = txtEmail.Text.Trim();

                    nuevo.Perfil = new Perfil();
                    nuevo.Perfil.NombreUsuario = txtUsuario.Text.Trim();
                    nuevo.Perfil.Contraseña = txtContrasena.Text.Trim();

                    int idRol = 0;
                    if (ddlTipoEmpleado.SelectedValue == "Administrador")
                    {
                        idRol = 1;
                    }
                    else if (ddlTipoEmpleado.SelectedValue == "Recepcionista")
                    {
                        idRol = 3;
                    }

                    negocio.agregar(nuevo, idRol);

                    lblMensaje.Text = "Empleado registrado con éxito.";
                    lblError.Text = "";
                    LimpiarFormulario();
                }
                catch (Exception ex)
                {
                    lblError.Text = "Ocurrió un error al registrar el empleado: " + ex.Message;
                    lblMensaje.Text = "";
                }
            }
        }

        private void LimpiarFormulario()
        {
            ddlTipoEmpleado.SelectedIndex = 0;
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtDNI.Text = "";
            txtFechaNacimiento.Text = "";
            txtTelefono.Text = "";
            txtDireccion.Text = "";
            txtEmail.Text = "";
            txtUsuario.Text = "";
            txtContrasena.Text = "";
        }
    }
}
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
    public partial class AdminGestionAdministradores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarAdmins();
        }

        private void cargarAdmins()
        {
            EmpleadoNegocio negocio = new EmpleadoNegocio();
            dgvAdmins.DataSource = negocio.listarAdministradores();
            dgvAdmins.DataBind();
        }

        protected void dgvAdmins_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            EmpleadoNegocio negocio = new EmpleadoNegocio();

            if (e.CommandName == "Eliminar")
            {
                List<Empleado> admins = negocio.listarAdministradores();
                if (admins.Count <= 1)
                {
                    lblError.Text = " ERROR: No se puede eliminar el único administrador activo del sistema.";
                    return;
                }

                negocio.eliminar(id);
                lblError.Text = "";
                pnlEditarAdmin.Visible = false;
                cargarAdmins();
            }
            else if (e.CommandName == "Modificar")
            {
                List<Empleado> admins = negocio.listarAdministradores();
                Empleado emp = admins.Find(a => a.Id == id);

                if (emp != null)
                {
                    hfIdAdmin.Value = emp.Id.ToString();
                    txtEditDni.Text = emp.Dni;
                    txtEditNombre.Text = emp.Nombre;
                    txtEditApellido.Text = emp.Apellido;
                    txtEditEmail.Text = emp.Email;
                    txtEditTelefono.Text = emp.Telefono;
                    txtEditDireccion.Text = emp.Direccion;
                    txtEditFechaNac.Text = emp.FechaNacimiento.ToString("yyyy-MM-dd");
                    lblMensajeAdmin.Text = "";
                    lblError.Text = "";
                    pnlEditarAdmin.Visible = true;
                }
            }
        }

        protected void btnGuardarAdmin_Click(object sender, EventArgs e)
        {
            EmpleadoNegocio negocio = new EmpleadoNegocio();

            Empleado emp = new Empleado();
            emp.Id = int.Parse(hfIdAdmin.Value);
            emp.Dni = txtEditDni.Text.Trim();
            emp.Nombre = txtEditNombre.Text.Trim();
            emp.Apellido = txtEditApellido.Text.Trim();
            emp.Email = txtEditEmail.Text.Trim();
            emp.Telefono = txtEditTelefono.Text.Trim();
            emp.Direccion = txtEditDireccion.Text.Trim();
            emp.FechaNacimiento = DateTime.Parse(txtEditFechaNac.Text);

            negocio.modificar(emp);

            lblMensajeAdmin.Text = "Administrador modificado correctamente.";
            pnlEditarAdmin.Visible = true;
            cargarAdmins();
        }

        protected void btnCancelarAdmin_Click(object sender, EventArgs e)
        {
            pnlEditarAdmin.Visible = false;
            lblError.Text = "";
        }
    }
}
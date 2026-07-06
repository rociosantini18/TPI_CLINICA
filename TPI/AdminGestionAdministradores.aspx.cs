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

                hfIdEliminarAdmin.Value = id.ToString();
                pnlConfirmarEliminarAdmin.Visible = true;
                lblError.Text = "";
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
                    txtEditContraseña.Text = emp.Perfil.Contraseña;

                    lblMensajeAdmin.Text = "";
                    lblError.Text = "";
                    pnlEditarAdmin.Visible = true;
                }
            }
        }

        protected void btnConfirmarEliminarAdmin_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdEliminarAdmin.Value);
            EmpleadoNegocio negocio = new EmpleadoNegocio();

            negocio.eliminar(id);
            lblError.Text = "";
            pnlConfirmarEliminarAdmin.Visible = false;
            pnlEditarAdmin.Visible = false;
            cargarAdmins();
        }

        protected void btnCancelarEliminarAdmin_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminarAdmin.Visible = false;
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
            emp.Perfil = new Perfil { Contraseña = txtEditContraseña.Text.Trim() };


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

        protected void btnRecuperarAdmin_Click(object sender, EventArgs e)
        {
            pnlAdminInactivos.Visible = !pnlAdminInactivos.Visible;

            if (pnlAdminInactivos.Visible)
            {
                CargarAdministradoresInactivos();
            }
        }

        private void CargarAdministradoresInactivos()
        {
            EmpleadoNegocio negocio = new EmpleadoNegocio();
            dgvAdminInactivos.DataSource = negocio.listarInactivos(1);
            dgvAdminInactivos.DataBind();
        }

        protected void dgvAdminInactivos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ReactivarAdmin")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                EmpleadoNegocio negocio = new EmpleadoNegocio();
                negocio.reactivar(id);

                CargarAdministradoresInactivos();

                dgvAdmins.DataSource = negocio.listarAdministradores();
                dgvAdmins.DataBind();
            }
        }
    }
}
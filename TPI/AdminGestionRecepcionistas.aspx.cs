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
    public partial class AdminGestionRecepcionistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarRecepcionistas();
            }
        }

        private void cargarRecepcionistas()
        {
            EmpleadoNegocio negocio = new EmpleadoNegocio();
            List<Empleado> activas = negocio.listarRecepcionista().Where(r => r.Perfil.Activo).ToList();

            dgvRecepcionistas.DataSource = activas;
            dgvRecepcionistas.DataBind();
        }

        protected void dgvRecepcionistas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            EmpleadoNegocio negocio = new EmpleadoNegocio();

            if (e.CommandName == "Eliminar")
            {
                try
                {
                    negocio.eliminar(id);
                    lblError.Text = "";
                    pnlEditarRecepcionista.Visible = false;
                    cargarRecepcionistas();
                }
                catch (Exception ex)
                {
                    lblError.Text = "Ocurrió un error al eliminar: " + ex.Message;
                }
            }
            else if (e.CommandName == "Modificar")
            {
                List<Empleado> lista = negocio.listarRecepcionista();
                Empleado emp = lista.Find(r => r.Id == id);

                if (emp != null)
                {
                    hfIdRecepcionista.Value = emp.Id.ToString();
                    txtEditDni.Text = emp.Dni;
                    txtEditNombre.Text = emp.Nombre;
                    txtEditApellido.Text = emp.Apellido;
                    txtEditEmail.Text = emp.Email;
                    txtEditTelefono.Text = emp.Telefono;
                    txtEditDireccion.Text = emp.Direccion;
                    txtEditFechaNac.Text = emp.FechaNacimiento.ToString("yyyy-MM-dd");

                    lblMensajeRecep.Text = "";
                    lblError.Text = "";
                    pnlEditarRecepcionista.Visible = true;
                }
            }
        }

        protected void btnGuardarRecep_Click(object sender, EventArgs e)
        {
            EmpleadoNegocio negocio = new EmpleadoNegocio();
            Empleado emp = new Empleado();

            try
            {
                emp.Id = int.Parse(hfIdRecepcionista.Value);
                emp.Dni = txtEditDni.Text.Trim();
                emp.Nombre = txtEditNombre.Text.Trim();
                emp.Apellido = txtEditApellido.Text.Trim();
                emp.Email = txtEditEmail.Text.Trim();
                emp.Telefono = txtEditTelefono.Text.Trim();
                emp.Direccion = txtEditDireccion.Text.Trim();
                emp.FechaNacimiento = DateTime.Parse(txtEditFechaNac.Text);

                negocio.modificar(emp);

                lblMensajeRecep.Text = "Recepcionista modificada correctamente.";
                pnlEditarRecepcionista.Visible = true;
                lblError.Text = "";
                cargarRecepcionistas();
            }
            catch (Exception ex)
            {
                lblError.Text = "Ocurrió un error al guardar los cambios: " + ex.Message;
            }
        }

        protected void btnCancelarRecep_Click(object sender, EventArgs e)
        {
            pnlEditarRecepcionista.Visible = false;
            lblError.Text = "";
        }
    }
}
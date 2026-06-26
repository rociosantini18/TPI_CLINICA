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
    public partial class AdminGestionMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarMedicos();
        }
        private void cargarMedicos()
        {
            MedicoNegocio negocio = new MedicoNegocio();
            dgvMedicos.DataSource = negocio.listar();
            dgvMedicos.DataBind();
        }
        protected void btnMostrarFormEspecialidad_Click(object sender, EventArgs e)
        {
            pnlNuevaEspecialidad.Visible = true;
            lblMensajeEsp.Text = "";
        }

        protected void btnGuardarEsp_Click(object sender, EventArgs e)
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            Especialidad esp = new Especialidad();
            esp.Nombre = txtNombreEsp.Text.Trim();
            esp.Descripcion = string.IsNullOrWhiteSpace(txtDescripcionEsp.Text) ? null : txtDescripcionEsp.Text.Trim();

            negocio.agregar(esp);

            txtNombreEsp.Text = "";
            txtDescripcionEsp.Text = "";
            lblMensajeEsp.Text = "Especialidad guardada correctamente.";

            pnlNuevaEspecialidad.Visible = true;
        }

        protected void btnCancelarEsp_Click(object sender, EventArgs e)
        {
            txtNombreEsp.Text = "";
            txtDescripcionEsp.Text = "";
            lblMensajeEsp.Text = "";
            pnlNuevaEspecialidad.Visible = false;
        }
        protected void dgvMedicos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            MedicoNegocio negocio = new MedicoNegocio();

            if (e.CommandName == "Eliminar")
            {
                negocio.eliminar(id);
                cargarMedicos();
                pnlEditarMedico.Visible = false;
            }
            else if (e.CommandName == "Modificar")
            {
                Medico med = negocio.listar().FirstOrDefault(m => m.Id == id);
                if (med != null)
                {
                    hfIdMedico.Value = med.Id.ToString();
                    txtEditMedDni.Text = med.Dni;
                    txtEditMedNombre.Text = med.Nombre;
                    txtEditMedApellido.Text = med.Apellido;
                    txtEditMedEmail.Text = med.Email;
                    txtEditMedTelefono.Text = med.Telefono;
                    txtEditMedDireccion.Text = med.Direccion;
                    txtEditMedFechaNac.Text = med.FechaNacimiento.ToString("yyyy-MM-dd");
                    txtEditMatri.Text = med.Matricula;
                    lblMensajeMed.Text = "";
                    pnlEditarMedico.Visible = true;
                }
            }
        }

        protected void btnGuardarMed_Click(object sender, EventArgs e)
        {
            MedicoNegocio negocio = new MedicoNegocio();

            Medico med = new Medico();
            med.Id = int.Parse(hfIdMedico.Value);
            med.Dni = txtEditMedDni.Text.Trim();
            med.Nombre = txtEditMedNombre.Text.Trim();
            med.Apellido = txtEditMedApellido.Text.Trim();
            med.Email = txtEditMedEmail.Text.Trim();
            med.Telefono = txtEditMedTelefono.Text.Trim();
            med.Direccion = txtEditMedDireccion.Text.Trim();
            med.FechaNacimiento = DateTime.Parse(txtEditMedFechaNac.Text);
            med.Matricula = txtEditMatri.Text.Trim();

            negocio.modificar(med);

            lblMensajeMed.Text = "Médico modificado correctamente.";
            cargarMedicos();
        }
        protected void btnCancelarMed_Click(object sender, EventArgs e)
        {
            pnlEditarMedico.Visible = false;
            lblMensajeMed.Text = "";
        }
    }
}
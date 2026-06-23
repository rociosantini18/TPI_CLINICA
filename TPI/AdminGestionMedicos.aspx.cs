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
            esp.ImagenURL = string.IsNullOrWhiteSpace(txtImagenEsp.Text) ? null : txtImagenEsp.Text.Trim();

            negocio.agregar(esp);

            txtNombreEsp.Text = "";
            txtDescripcionEsp.Text = "";
            txtImagenEsp.Text = "";
            lblMensajeEsp.Text = "Especialidad guardada correctamente.";

            pnlNuevaEspecialidad.Visible = true;
        }

        protected void btnCancelarEsp_Click(object sender, EventArgs e)
        {
            txtNombreEsp.Text = "";
            txtDescripcionEsp.Text = "";
            txtImagenEsp.Text = "";
            lblMensajeEsp.Text = "";
            pnlNuevaEspecialidad.Visible = false;
        }
    }
}
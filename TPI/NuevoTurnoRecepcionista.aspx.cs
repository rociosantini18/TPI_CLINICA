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
    public partial class NuevoTurnoRecepcionista : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];
            if (perfil.Rol != "Recepcionista")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }
        }

        protected void btnBuscarPaciente_Click(object sender, EventArgs e)
        {
            PacienteNegocio negocio = new PacienteNegocio();
            dgvPacientes.DataSource = negocio.BuscarPaciente(txtBuscarPaciente.Text);
            dgvPacientes.DataBind();

        }

        protected void dgvPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = (int)dgvPacientes.SelectedDataKey.Value;

            PacienteNegocio negocio = new PacienteNegocio();
            Paciente paciente = negocio.BuscarPorId(id);

            lblPacienteDNI.Text = paciente.Dni;
            lblPacienteNombre.Text = paciente.Nombre;
            lblPacienteApellido.Text = paciente.Apellido;
            lblPacienteOS.Text = paciente.ObraSocial;

            pnlPaciente.Visible = true;
        }
    }
}
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

            if (!IsPostBack)
            {
                EspecialidadNegocio negocioEsp = new EspecialidadNegocio();

                ddlEspecialidad.DataSource = negocioEsp.listar();
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataValueField = "Id";
                ddlEspecialidad.DataBind();
            }

        }

        protected void btnBuscarPaciente_Click(object sender, EventArgs e)
        {
            PacienteNegocio negocio = new PacienteNegocio();
            dgvPacientes.DataSource = negocio.BuscarPaciente(txtBuscarPaciente.Text);
            dgvPacientes.DataBind();

            pnlPaciente.Visible = false;
            dgvPacientes.Visible = true;

        }

        protected void dgvPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = (int)dgvPacientes.SelectedDataKey.Value;

            PacienteNegocio negocio = new PacienteNegocio();
            Paciente paciente = negocio.BuscarPorId(id);

            lblPacienteId.Text = paciente.IdPaciente.ToString();
            lblPacienteDNI.Text = paciente.Dni;
            lblPacienteNombre.Text = paciente.Nombre;
            lblPacienteApellido.Text = paciente.Apellido;
            lblPacienteOS.Text = paciente.ObraSocial;

            pnlPaciente.Visible = true;
            dgvPacientes.Visible = false;
        }


        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            MedicoNegocio negocioMed = new MedicoNegocio();

            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);


            ddlMedico.DataSource = negocioMed.listarMedicosSegunEspecialidad(idEspecialidad);
            ddlMedico.DataTextField = "Nombre";
            ddlMedico.DataValueField = "Id";
            ddlMedico.DataBind();

            ddlMedico.Items.Insert(0, new ListItem(" Seleccione un medico", "0"));

        }
        protected void ddlFechasDisponibles_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlMedico_SelectedIndexChanged(object sender, EventArgs e)
        {

            HorarioMedicoNegocio negocioHor = new HorarioMedicoNegocio();

            int idMedico = int.Parse(ddlMedico.SelectedValue);

            if (ddlMedico.SelectedValue != "0")
            {
                ddlFechasDisponibles.DataSource = negocioHor.listarFechasDisponiblesPorMedico(idMedico);
                ddlFechasDisponibles.DataTextField = "Fecha";
                ddlFechasDisponibles.DataValueField = "Fecha";
                ddlFechasDisponibles.DataBind();

                foreach (ListItem item in ddlFechasDisponibles.Items)
                {
                    item.Text = DateTime.Parse(item.Text).ToString("dd/MM/yyyy");
                }

            }
            ddlFechasDisponibles.Items.Insert(0, new ListItem("Seleccione una fecha", "0"));
        }
    }
}
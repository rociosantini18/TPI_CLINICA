using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;
using TPI.Negocio;

namespace TPI
{
    public partial class SacarTurno1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol != "Cliente")
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

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            MedicoNegocio negocioMed = new MedicoNegocio();

            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);


            ddlMedico.DataSource = negocioMed.listarMedicosSegunEspecialidad(idEspecialidad);
            ddlMedico.DataTextField = "Nombre";
            ddlMedico.DataValueField = "Id";
            ddlMedico.DataBind();

            ddlMedico.Items.Insert(0, new ListItem(" Seleccione un medico", "0"));
            ddlFechasDisponibles.Items.Clear();
            ddlHorario.Items.Clear();
        }

        protected void ddlMedico_SelectedIndexChanged(object sender, EventArgs e)
        {
            HorarioMedicoNegocio negocioHor = new HorarioMedicoNegocio();

            if (ddlMedico.SelectedValue != "0")
            {
                int idMedico = int.Parse(ddlMedico.SelectedValue);
                ddlFechasDisponibles.DataSource = negocioHor.listarFechasDisponiblesPorMedico(idMedico);
                ddlFechasDisponibles.DataTextField = "Fecha";
                ddlFechasDisponibles.DataValueField = "Fecha";
                ddlFechasDisponibles.DataBind();

                foreach (ListItem item in ddlFechasDisponibles.Items)
                {
                    if (item.Value != "0")
                    {
                        item.Text = DateTime.Parse(item.Text).ToString("dd/MM/yyyy");
                    }
                }
            }
            else
            {
                ddlFechasDisponibles.Items.Clear();
                ddlHorario.Items.Clear();
            }
            ddlFechasDisponibles.Items.Insert(0, new ListItem("Seleccione una fecha", "0"));
        }

        protected void ddlFechasDisponibles_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFechasDisponibles.SelectedValue != "0" && ddlMedico.SelectedValue != "0")
            {
                HorarioMedicoNegocio negocioHor = new HorarioMedicoNegocio();
                int idMedico = int.Parse(ddlMedico.SelectedValue);
                DateTime fecha = DateTime.Parse(ddlFechasDisponibles.SelectedValue);

                ddlHorario.DataSource = negocioHor.listarHorariosDisponibles(idMedico, fecha);
                ddlHorario.DataBind();
            }
            else
            {
                ddlHorario.Items.Clear();
            }
            ddlHorario.Items.Insert(0, new ListItem("Seleccione un horario", "0"));
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            if (ddlMedico.SelectedValue == "0" ||
                ddlFechasDisponibles.SelectedValue == "0" ||
                ddlHorario.SelectedValue == "0")
            {
                lblError.Text = "Por favor, complete todos los campos obligatorios.";
                lblError.Visible = true;
                return;
            }

            try
            {
                TurnoNegocio negocio = new TurnoNegocio();
                Turno turno = new Turno();

                turno.Paciente = new Paciente();

                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"].ToString());
                    turno.Paciente.Id = id;
                }

                turno.Medico = new Medico();
                turno.Medico.Id = int.Parse(ddlMedico.SelectedValue);

                turno.Fecha = DateTime.Parse(ddlFechasDisponibles.SelectedValue);
                turno.HoraInicio = TimeSpan.Parse(ddlHorario.SelectedValue);

                turno.HoraFin = turno.HoraInicio.Add(TimeSpan.FromMinutes(30));

                turno.Numero = "T-" + Guid.NewGuid().ToString().Substring(0, 6).ToUpper();
                turno.Observaciones = txtObservaciones.Text;
                turno.Diagnostico = null;

                negocio.agregar(turno);

                lblExito.Text = "¡Turno guardado con éxito! Ya podes visualizarlo en la pestaña Mis Turnos";
                lblExito.Visible = true;
                lblError.Visible = false;

                btnConfirmar.Enabled = false;
            }
            catch (Exception ex)
            {
                lblError.Text = "Ocurrió un error al guardar el turno: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}
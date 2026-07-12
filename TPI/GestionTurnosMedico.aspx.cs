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
    public partial class GestionTurnosMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol != "Medico")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            if (!IsPostBack)
            {
                cargarFiltroEspecialidades();
                cargarTurnos();
            }

        }

        public string ObtenerCssBadge(string estado)
        {
            switch (estado)
            {
                case "Nuevo": return "badge text-bg-success";
                case "Reprogramado": return "badge text-bg-warning text-dark";
                case "Cancelado": return "badge text-bg-danger";
                case "Atendido": return "badge text-bg-secondary";
                default: return "badge text-bg-light text-dark";
            }
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            cargarTurnos();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            ddlFiltroEspecialidad.SelectedIndex = 0;
            ddlFiltroEstado.SelectedIndex = 0;
            txtFiltroFecha.Text = "";
            cargarTurnos();
        }

        private int IdTurnoSeleccionado
        {
            get { return ViewState["IdTurnoSeleccionado"] == null ? 0 : (int)ViewState["IdTurnoSeleccionado"]; }
            set { ViewState["IdTurnoSeleccionado"] = value; }
        }

        protected void rptTurnos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblWarningAtendido.Visible = false;
            TurnoNegocio negocio = new TurnoNegocio();
            int idTurno = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "CargarDiagnostico")
            {
                Turno turno = negocio.listar().FirstOrDefault(t => t.Id == idTurno);
                IdTurnoSeleccionado = idTurno;
                lblNumeroTurnoSeleccionado.Text = turno != null ? turno.Numero : idTurno.ToString();
                pnlDiagnostico.Visible = true;
            }
            else if (e.CommandName == "EditarDiagnostico")
            {
                Turno turno = negocio.listar().FirstOrDefault(t => t.Id == idTurno);
                IdTurnoSeleccionado = idTurno;
                lblNumeroTurnoSeleccionado.Text = turno != null ? turno.Numero : idTurno.ToString();
                txtDiagnostico.Text = turno.Diagnostico;
                pnlDiagnostico.Visible = true;
            }

            cargarTurnos();
        }

        private void cargarTurnos()
        {
            TurnoNegocio negocio = new TurnoNegocio();


            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                MedicoNegocio negocioMedico = new MedicoNegocio();
                Medico medico = negocioMedico.RelacionPerfilPersona(id);

                TurnoNegocio negocioTurnos = new TurnoNegocio();
                List<Turno> turnos = negocioTurnos.listarPorMedico(medico.IdMedico);

                if (!string.IsNullOrEmpty(ddlFiltroEspecialidad.SelectedValue))
                    turnos = turnos.Where(t => t.Especialidad.Id == int.Parse(ddlFiltroEspecialidad.SelectedValue)).ToList();

                if (!string.IsNullOrEmpty(ddlFiltroEstado.SelectedValue))
                    turnos = turnos.Where(t => t.Estado == ddlFiltroEstado.SelectedValue).ToList();

                if (!string.IsNullOrEmpty(txtFiltroFecha.Text))
                    turnos = turnos.Where(t => t.Fecha.Date == DateTime.Parse(txtFiltroFecha.Text).Date).ToList();

                rptTurnos.DataSource = turnos;
                rptTurnos.DataBind();
            }


        }

        protected void btnGuardarDiagnostico_Click(object sender, EventArgs e)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            negocio.cargarDiagnostico(IdTurnoSeleccionado, txtDiagnostico.Text);

            pnlDiagnostico.Visible = false;
            cargarTurnos();
        }

        protected void btnCancelarDiagnostico_Click(object sender, EventArgs e)
        {
            pnlDiagnostico.Visible = false;
        }

        private void cargarFiltroEspecialidades()
        {
            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                MedicoNegocio negocioMedico = new MedicoNegocio();
                Medico medico = negocioMedico.RelacionPerfilPersona(id);

                EspecialidadNegocio negocio = new EspecialidadNegocio();
                ddlFiltroEspecialidad.DataSource = negocio.listarEscpecialidadesPorMedico(medico.IdMedico);
                ddlFiltroEspecialidad.DataTextField = "Nombre";
                ddlFiltroEspecialidad.DataValueField = "Id";
                ddlFiltroEspecialidad.DataBind();
                ddlFiltroEspecialidad.Items.Insert(0, new ListItem("Todas las especialidades", ""));


            }

        }
    }
}

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
    public partial class GestionarTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null) { Response.Redirect("~/InicioSesion.aspx"); return; }
            Perfil perfil = (Perfil)Session["perfil"];
            if (perfil.Rol != "Recepcionista") { Response.Redirect("~/InicioSesion.aspx"); return; }

            if (!IsPostBack)
            {
                cargarFiltroMedicos();
                cargarFiltroEspecialidades();
                cargarTurnos();
            }
        }

        private void cargarFiltroMedicos()
        {
            MedicoNegocio negocio = new MedicoNegocio();
            ddlFiltroMedico.DataSource = negocio.listar();
            ddlFiltroMedico.DataTextField = "Apellido";
            ddlFiltroMedico.DataValueField = "Id";
            ddlFiltroMedico.DataBind();
            ddlFiltroMedico.Items.Insert(0, new ListItem("Todos los médicos", ""));
        }

        private void cargarFiltroEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            ddlFiltroEspecialidad.DataSource = negocio.listar();
            ddlFiltroEspecialidad.DataTextField = "Nombre";
            ddlFiltroEspecialidad.DataValueField = "Id";
            ddlFiltroEspecialidad.DataBind();
            ddlFiltroEspecialidad.Items.Insert(0, new ListItem("Todas las especialidades", ""));
        }

        private void cargarTurnos()
        {
            TurnoNegocio negocio = new TurnoNegocio();
            List<Turno> turnos = negocio.listar();

            if (!string.IsNullOrEmpty(ddlFiltroMedico.SelectedValue))
                turnos = turnos.Where(t => t.Medico.Id == int.Parse(ddlFiltroMedico.SelectedValue)).ToList();

            if (!string.IsNullOrEmpty(ddlFiltroEspecialidad.SelectedValue))
                turnos = turnos.Where(t => t.Especialidad.Id == int.Parse(ddlFiltroEspecialidad.SelectedValue)).ToList();

            if (!string.IsNullOrEmpty(ddlFiltroEstado.SelectedValue))
                turnos = turnos.Where(t => t.Estado == ddlFiltroEstado.SelectedValue).ToList();

            if (!string.IsNullOrEmpty(txtFiltroFecha.Text))
                turnos = turnos.Where(t => t.Fecha.Date == DateTime.Parse(txtFiltroFecha.Text).Date).ToList();

            rptTurnos.DataSource = turnos;
            rptTurnos.DataBind();
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
            ddlFiltroMedico.SelectedIndex = 0;
            ddlFiltroEspecialidad.SelectedIndex = 0;
            ddlFiltroEstado.SelectedIndex = 0;
            txtFiltroFecha.Text = "";
            cargarTurnos();
        }

        protected void rptTurnos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            int idTurno = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Cancelar")
                negocio.cancelar(idTurno);
            else if (e.CommandName == "Reprogramar")
                negocio.modificarEstado(idTurno, "Reprogramado");

            cargarTurnos();
        }
    }
}
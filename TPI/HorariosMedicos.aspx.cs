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
    public partial class HorariosMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null) { Response.Redirect("~/InicioSesion.aspx"); return; }
            Perfil perfil = (Perfil)Session["perfil"];
            if (perfil.Rol != "Recepcionista" && perfil.Rol != "Administrador")
            { Response.Redirect("~/InicioSesion.aspx"); return; }

            if (!IsPostBack)
                cargarMedicos();
        }

        private void cargarMedicos()
        {
            MedicoNegocio negocio = new MedicoNegocio();
            ddlMedico.DataSource = negocio.listar();
            ddlMedico.DataTextField = "Apellido";
            ddlMedico.DataValueField = "Id";
            ddlMedico.DataBind();
            ddlMedico.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione un médico", "0"));
        }
        protected string TraducirDia(DayOfWeek dia)
        {
            switch (dia)
            {
                case DayOfWeek.Sunday: return "Domingo";
                case DayOfWeek.Monday: return "Lunes";
                case DayOfWeek.Tuesday: return "Martes";
                case DayOfWeek.Wednesday: return "Miércoles";
                case DayOfWeek.Thursday: return "Jueves";
                case DayOfWeek.Friday: return "Viernes";
                case DayOfWeek.Saturday: return "Sábado";
                default: return "";
            }
        }
        private void cargarHorarios()
        {
            if (ddlMedico.SelectedValue == "0") return;

            HorarioMedicoNegocio negocio = new HorarioMedicoNegocio();
            Medico medico = negocio.obtenerConHorarios(int.Parse(ddlMedico.SelectedValue));

            rptHorarios.DataSource = medico.Horarios;
            rptHorarios.DataBind();
        }

        protected void ddlMedico_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMedico.SelectedValue == "0")
            {
                lblDiaAtencionVista.Visible = false;
                ddlDiaTurno.Items.Clear();
                return;
            }

            MedicoNegocio medNegocio = new MedicoNegocio();
            Medico medico = medNegocio.listar().FirstOrDefault(m => m.Id == int.Parse(ddlMedico.SelectedValue));

            if (medico != null)
            {
                ddlDiaTurno.Items.Clear();

                if (medico.DiasAtencion != null && medico.DiasAtencion.Count > 0)
                {
                    foreach (DayOfWeek dia in medico.DiasAtencion)
                    {
                        ddlDiaTurno.Items.Add(new ListItem(TraducirDia(dia), ((int)dia).ToString()));
                    }
                    var nombresDias = medico.DiasAtencion.Select(d => TraducirDia(d));
                    lblDiaAtencionVista.Text = "Días de atención: " + string.Join(", ", nombresDias);
                    lblDiaAtencionVista.Visible = true;
                }
                else
                {
                    lblDiaAtencionVista.Text = "Sin días asignados";
                    lblDiaAtencionVista.Visible = true;
                }
            }

            cargarHorarios();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (ddlMedico.SelectedValue == "0") return;
            try
            {
                TimeSpan horaInicio = TimeSpan.Parse(txtHoraInicio.Text);
                TimeSpan horaFin = TimeSpan.Parse(txtHoraFin.Text);

                if (horaInicio >= horaFin)
                {
                    lblMensaje.Visible = true;
                    lblMensaje.CssClass = "text-danger mb-2 d-block";
                    lblMensaje.Text = "La hora de fin debe ser posterior a la de inicio.";
                    return;
                }

                HorarioMedicoNegocio negocio = new HorarioMedicoNegocio();
                DayOfWeek diaSeleccionado = (DayOfWeek)int.Parse(ddlDiaTurno.SelectedValue);
                negocio.agregar(int.Parse(ddlMedico.SelectedValue), diaSeleccionado, horaInicio, horaFin);
                lblMensaje.Visible = true;
                lblMensaje.CssClass = "text-success mb-2 d-block";
                lblMensaje.Text = "Horario agregado correctamente.";
                cargarHorarios();

                txtHoraInicio.Text = "";
                txtHoraFin.Text = "";
            }
            catch (Exception ex)
            {
                lblMensaje.Visible = true;
                lblMensaje.CssClass = "text-danger mb-2 d-block";
                lblMensaje.Text = "Error: " + ex.Message;
            }
        }

        protected void rptHorarios_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                HorarioMedicoNegocio negocio = new HorarioMedicoNegocio();
                negocio.eliminar(int.Parse(e.CommandArgument.ToString()));
                cargarHorarios();
            }
        }
        protected void btnAbrirPanelDias_Click(object sender, EventArgs e)
        {
            if (ddlMedico.SelectedValue == "0") return;

            MedicoNegocio medNegocio = new MedicoNegocio();
            Medico medico = medNegocio.listar().FirstOrDefault(m => m.Id == int.Parse(ddlMedico.SelectedValue));

            if (medico != null)
            {
                cblDiasRecepcionista.ClearSelection();

                if (medico.DiasAtencion != null)
                {
                    foreach (DayOfWeek dia in medico.DiasAtencion)
                    {
                        ListItem item = cblDiasRecepcionista.Items.FindByValue(((int)dia).ToString());
                        if (item != null) item.Selected = true;
                    }
                }
                pnlModificarDias.Visible = true;
                lblMensajeDias.Text = "";
            }
        }

        protected void btnGuardarDias_Click(object sender, EventArgs e)
        {
            if (ddlMedico.SelectedValue == "0") return;

            try
            {
                List<DayOfWeek> nuevosDias = new List<DayOfWeek>();
                foreach (ListItem item in cblDiasRecepcionista.Items)
                {
                    if (item.Selected)
                    {
                        nuevosDias.Add((DayOfWeek)int.Parse(item.Value));
                    }
                }

                MedicoNegocio negocio = new MedicoNegocio();
                negocio.modificarDiasAtencion(int.Parse(ddlMedico.SelectedValue), nuevosDias);

                pnlModificarDias.Visible = false;

                ddlMedico_SelectedIndexChanged(null, null);

                lblMensaje.Visible = true;
                lblMensaje.CssClass = "text-success mb-2 d-block";
                lblMensaje.Text = "¡Días de atención del médico actualizados correctamente!";
            }
            catch (Exception ex)
            {
                lblMensajeDias.Text = "Error: " + ex.Message;
                lblMensajeDias.CssClass = "text-danger mb-2 d-block small fw-bold";
            }
        }
        protected void btnCancelarDias_Click(object sender, EventArgs e)
        {
            pnlModificarDias.Visible = false;
        }
    }
}
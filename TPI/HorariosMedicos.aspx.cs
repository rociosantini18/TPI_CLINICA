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
            txtFecha.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
            txtFecha.Attributes["max"] = DateTime.Now.AddYears(2).ToString("yyyy-MM-dd");
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
            cargarHorarios();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (ddlMedico.SelectedValue == "0") return;
            try
            {
                DateTime fecha = DateTime.Parse(txtFecha.Text);
                TimeSpan horaInicio = TimeSpan.Parse(txtHoraInicio.Text);
                TimeSpan horaFin = TimeSpan.Parse(txtHoraFin.Text);

                if (fecha.Date < DateTime.Today || fecha.Date > DateTime.Today.AddYears(1))
                {
                    lblMensaje.Visible = true;
                    lblMensaje.CssClass = "text-danger mb-2 d-block";
                    lblMensaje.Text = "La fecha debe ser a partir de hoy y dentro del próximo año.";
                    return;
                }
                if (horaInicio >= horaFin)
                {
                    lblMensaje.Visible = true;
                    lblMensaje.CssClass = "text-danger mb-2 d-block";
                    lblMensaje.Text = "La hora de fin debe ser posterior a la hora de inicio.";
                    return;
                }

                int idMedico = int.Parse(ddlMedico.SelectedValue);
                HorarioMedicoNegocio negocio = new HorarioMedicoNegocio();

                Medico medicoSeleccionado = negocio.obtenerConHorarios(idMedico);

                if (medicoSeleccionado != null && medicoSeleccionado.Horarios != null)
                {
                    foreach (var h in medicoSeleccionado.Horarios)
                    {
                        if (h.Fecha.Date == fecha.Date)
                        {
                            if (horaInicio < h.HoraFin && horaFin > h.HoraInicio)
                            {
                                lblMensaje.Text = "El médico ya tiene un horario registrado que se superpone con este.";
                                lblMensaje.CssClass = "text-danger mb-2 d-block";
                                lblMensaje.Visible = true;
                                return;
                            }
                        }
                    }
                }

                negocio.agregar(idMedico, fecha, horaInicio, horaFin);

                lblMensaje.Visible = true;
                lblMensaje.CssClass = "text-success mb-2 d-block";
                lblMensaje.Text = "Horario agregado correctamente.";
                cargarHorarios();

                txtFecha.Text = "";
                txtHoraInicio.Text = "";
                txtHoraFin.Text = "";
                ddlMedico.SelectedValue = "0";
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
    }
}
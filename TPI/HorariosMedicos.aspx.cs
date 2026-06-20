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
                DayOfWeek dia = (DayOfWeek)int.Parse(ddlDia.SelectedValue);

                HorarioMedicoNegocio negocio = new HorarioMedicoNegocio();
                negocio.agregar(int.Parse(ddlMedico.SelectedValue),dia,TimeSpan.Parse(txtHoraInicio.Text),TimeSpan.Parse(txtHoraFin.Text));
                lblMensaje.Visible = true;
                lblMensaje.CssClass = "text-success mb-2 d-block";
                lblMensaje.Text = "Horario agregado correctamente.";
                cargarHorarios();
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
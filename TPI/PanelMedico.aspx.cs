using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;

namespace TPI
{
    public partial class PanelMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];
            lblNombre.Text = perfil.NombreUsuario;

            if (perfil.Rol != "Medico")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }
        }

        protected void btnMisDatos_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());
                Response.Redirect("~/DatosMedico.aspx?id=" + id);
                return;
            }
        }

        protected void btnGestionTurnos_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());
                Response.Redirect("~/GestionTurnosMedico.aspx?id=" + id);
                return;
            }
        }
    }
}
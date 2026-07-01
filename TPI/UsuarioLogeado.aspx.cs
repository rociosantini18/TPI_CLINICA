using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;

namespace TPI
{
    public partial class UsuarioLogeado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];
            lblNombreUsuario.Text = perfil.NombreUsuario;
            if (perfil.Rol != "Cliente")
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
                Response.Redirect("~/MisDatos.aspx?id=" + id);
                return;
            }
        }

        protected void btnTomarTurno_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());
                Response.Redirect("~/SacarTurno.aspx?id=" + id);
                return;
            }
        }

        protected void btnMisTurnos_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());
                Response.Redirect("~/MisTurnos.aspx?id=" + id);
                return;
            }
        }
    }
}
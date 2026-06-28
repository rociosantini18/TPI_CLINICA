using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;

namespace TPI
{
    public partial class PanelRecepcionista : System.Web.UI.Page
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

            if (perfil.Rol != "Recepcionista")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }
                     
        }
    }
}
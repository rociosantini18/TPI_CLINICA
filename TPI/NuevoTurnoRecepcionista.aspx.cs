using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;

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
        }

        protected void btnBuscarPaciente_Click(object sender, EventArgs e)
        {

        }
    }
}
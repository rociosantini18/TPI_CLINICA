using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;

namespace TPI
{
    public partial class MasterDefault : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] != null)
            {
                Perfil perfil = (Perfil)Session["perfil"];

                btnLogout.Visible = true;
                btnLogin.Visible = false;
                lblUsuario.Visible = true;
            }
            else
            {
                btnLogout.Visible = false;
                btnLogin.Visible = true;
                lblUsuario.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/InicioSesion.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/InicioSesion.aspx");
        }
    }
}
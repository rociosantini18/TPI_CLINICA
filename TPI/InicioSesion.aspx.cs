using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Dominio;
using TPI.Negocio;

namespace TPI
{
    public partial class InicioSesion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            try
            {
                LoginNegocio negocio = new LoginNegocio();
                Perfil perfil = negocio.login(txtbUser.Text.Trim(), txtPassword.Text);

                if (perfil == null)
                {
                    lblError.Visible = true;
                    lblError.CssClass = "text-danger mb-3 d-block";
                    lblError.Text = "Usuario o contraseña incorrectos.";
                    return;
                }

                Session["perfil"] = perfil;

                switch (perfil.Rol)
                {
                    case "Cliente":
                        Response.Redirect("UsuarioLogeado.aspx?id=" + perfil.Id);
                        break;
                    case "Recepcionista":
                        Response.Redirect("PanelRecepcionista.aspx?id=" + perfil.Id);
                        break;
                    case "Administrador":
                        Response.Redirect("AdminGestionPacientes.aspx?id=" + perfil.Id);
                        break;
                    default:
                        lblError.Visible = true;
                        lblError.Text = "Rol no reconocido.";
                        break;
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.CssClass = "text-danger mb-3 d-block";
                lblError.Text = "Error: " + ex.Message;
            }
        }
    }
}
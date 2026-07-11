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
    public partial class DatosMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol != "Medico")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"].ToString());

                    EspecialidadNegocio negocioEsp = new EspecialidadNegocio();
                    MedicoNegocio negocio = new MedicoNegocio();
                    Medico medico = negocio.RelacionPerfilPersona(id);

                    if (medico != null)
                    {
                        txtDNI.Text = medico.Dni;
                        txtNombre.Text = medico.Nombre;
                        txtApellido.Text = medico.Apellido;
                        txtTelefono.Text = medico.Telefono;
                        txtFechaNacimiento.Text = medico.FechaNacimiento.ToString("yyyy-MM-dd");
                        txtMatricula.Text = medico.Matricula;

                        ddlEspecialidades.DataSource = negocioEsp.listar();
                        ddlEspecialidades.DataTextField = "Nombre";
                        ddlEspecialidades.DataValueField = "Id";
                        ddlEspecialidades.DataBind();
                        ddlEspecialidades.SelectedValue = medico.Especialidad.Id.ToString();
                        txtEmail.Text = medico.Email;
                        txtDireccion.Text = medico.Direccion;
                    }
                }
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol == "Medico" && Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                Response.Redirect("~/PanelMedico.aspx?id=" + id);
                return;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

        }
    }
}
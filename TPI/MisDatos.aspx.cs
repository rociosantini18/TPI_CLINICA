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
    public partial class MisDatos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["perfil"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil.Rol != "Cliente")
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"].ToString());

                    PacienteNegocio negocio = new PacienteNegocio();
                    Paciente paciente = negocio.RelacionPerfilPersona(id);

                    if (paciente != null)
                    {
                        txtDNI.Text = paciente.Dni;
                        txtNombre.Text = paciente.Nombre;
                        txtApellido.Text = paciente.Apellido;
                        txtTelefono.Text = paciente.Telefono;
                        txtFechaNacimiento.Text = paciente.FechaNacimiento.ToString("yyyy-MM-dd");

                        ddlObraSocial.DataSource = negocio.listarObrasSociales();
                        ddlObraSocial.DataTextField = "Value";
                        ddlObraSocial.DataValueField = "Key";
                        ddlObraSocial.DataBind();
                        ddlObraSocial.SelectedValue = paciente.IdObraSocial.ToString();

                        txtEmail.Text = paciente.Email;
                        txtDireccion.Text = paciente.Direccion;
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"].ToString());

                    PacienteNegocio negocio = new PacienteNegocio();
                    Paciente paciente = negocio.RelacionPerfilPersona(id);

                    if (paciente == null)
                    {
                        throw new Exception("No se encontró el paciente.");
                    }

                    paciente.Dni = txtDNI.Text;
                    paciente.Nombre = txtNombre.Text;
                    paciente.Apellido = txtApellido.Text;
                    paciente.Telefono = txtTelefono.Text;
                    paciente.FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text);
                    paciente.IdObraSocial = int.Parse(ddlObraSocial.SelectedValue);
                    paciente.Email = txtEmail.Text;
                    paciente.Direccion = txtDireccion.Text;

                    if (!string.IsNullOrEmpty(txtPassword.Text))
                    {
                        if (txtPassword.Text == txtPasswordConfirm.Text)
                        {
                            paciente.Perfil.Contraseña = txtPassword.Text;
                        }
                        else
                        {
                            lblError.Text = "Las contraseñas no coinciden.";
                            lblError.Visible = true;
                            lblExito.Visible = false;
                            return;
                        }
                    }

                    negocio.modificar(paciente);

                    lblExito.Text = "¡Datos actualizados con éxito!";
                    lblExito.CssClass = "alert alert-success fw-bold mb-3 d-block text-center fs-5";
                    lblExito.Visible = true;
                    lblError.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.CssClass = "text-danger mb-3 d-block";
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Perfil perfil = (Perfil)Session["perfil"];

            if (perfil != null)
            {
                Response.Redirect("UsuarioLogeado.aspx?id=" + perfil.Id);
            }
        }
    }
}
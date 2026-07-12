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
                        txtDireccion.Text = medico.Direccion;
                        txtEmail.Text = medico.Email;
                        txtURL.Text = medico.imagenURL;

                        txtPassword.Text = medico.Perfil.Contraseña;
                        txtUsuario.Text = medico.Perfil.NombreUsuario;

                        dgvEspecialidades.DataSource = negocioEsp.listarEscpecialidadesPorMedico(medico.IdMedico);
                        dgvEspecialidades.DataBind();

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
            try
            {

                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"].ToString());

                    MedicoNegocio negocio = new MedicoNegocio();
                    Medico medico = new Medico();
                    medico = negocio.RelacionPerfilPersona(id);

                    if (medico == null)
                    {
                        throw new Exception("No se encontró al medico.");
                    }

                    medico.Dni = txtDNI.Text;
                    medico.Nombre = txtNombre.Text;
                    medico.Apellido = txtApellido.Text;
                    medico.Telefono = txtTelefono.Text;
                    medico.FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text); ;
                    medico.Email = txtEmail.Text;
                    medico.Direccion = txtDireccion.Text;
                    medico.Matricula = txtMatricula.Text;
                    medico.imagenURL = txtURL.Text;
                    medico.Perfil.Contraseña = txtPassword.Text;
                    medico.Perfil.NombreUsuario = txtUsuario.Text;

                    negocio.modificar(medico);

                    lblExito.Text = "¡Datos guardados con éxito!";
                    lblExito.Visible = true;
                    lblError.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.CssClass = "text-danger mb-3 d-block";
                lblError.Text = "Error: " + ex.Message;
                throw;
            }
        }

        protected void dgvEspecialidades_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            int id = int.Parse(e.CommandArgument.ToString());
            MedicoNegocio negocio = new MedicoNegocio();

            if (e.CommandName == "EliminarEsp")
            {
                hfIdEliminarEsp.Value = id.ToString();
                pnlConfirmarEliminarEsp.Visible = true;
            }
        }

        protected void btnConfirmarEliminarEsp_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                MedicoNegocio negocioMed = new MedicoNegocio();
                Medico medico = negocioMed.RelacionPerfilPersona(id);

                int idEspecialidad = int.Parse(hfIdEliminarEsp.Value);
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                negocio.bajaEspecialidadMedico(idEspecialidad, medico.IdMedico);

                pnlConfirmarEliminarEsp.Visible = false;


                dgvEspecialidades.DataSource = negocio.listarEscpecialidadesPorMedico(medico.IdMedico);
                dgvEspecialidades.DataBind();
            }


        }

        protected void btnCancelarEliminarEsp_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminarEsp.Visible = false;
        }

        protected void btnAgregarEspecialidad_Click(object sender, EventArgs e)
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            pnlAgregarEspecialidad.Visible = true;
            ddlEspecialidadesDisponibles.DataSource = negocio.listar();
            ddlEspecialidadesDisponibles.DataTextField = "Nombre";
            ddlEspecialidadesDisponibles.DataValueField = "Id";
            ddlEspecialidadesDisponibles.DataBind();

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"].ToString());

                MedicoNegocio negocioMed = new MedicoNegocio();
                Medico medico = negocioMed.RelacionPerfilPersona(id);

                bool existe = false;

                foreach (Especialidad esp in negocio.listarEscpecialidadesPorMedico(medico.IdMedico))
                {
                    if (esp.Id == int.Parse(ddlEspecialidadesDisponibles.SelectedValue))
                    {
                        existe = true;
                        lblEspecialidadRepetida.Visible = true;
                        lblEspecialidadRepetida.Text = "El médico ya tiene esa especialidad.";
                    }
                }

                if (!existe)
                {
                    negocio.agregarEspecialidadMedico(int.Parse(ddlEspecialidadesDisponibles.SelectedValue), medico.IdMedico);

                    pnlAgregarEspecialidad.Visible = false;
                    dgvEspecialidades.DataSource = negocio.listarEscpecialidadesPorMedico(medico.IdMedico);
                    dgvEspecialidades.DataBind();

                }

            }

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            pnlAgregarEspecialidad.Visible = false;
        }
    }
}
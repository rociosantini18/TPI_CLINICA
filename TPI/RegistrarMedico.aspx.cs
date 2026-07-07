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
    public partial class RegistrarMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                ddlEspecialidad.DataSource = negocio.listar();
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataValueField = "Id";
                ddlEspecialidad.DataBind();
            }
        }

        protected void btn_registrarMedico_click(object sender, EventArgs a)
        {
            if (!Page.IsValid) return;

            try
            {
                Medico med = new Medico();
                med.Nombre = txtNombre.Text.Trim();
                med.Apellido = txtApellido.Text.Trim();
                med.Dni = txtDNI.Text.Trim();
                med.FechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                med.Telefono = txtTelefono.Text.Trim();
                med.Direccion = txtDireccion.Text.Trim();
                med.Email = txtEmail.Text.Trim();
                med.Especialidad.Id = int.Parse(ddlEspecialidad.SelectedValue);
                med.imagenURL = txtImagenURL.Text.Trim();
                med.Matricula = txtMatricula.Text.Trim();

                med.DiasAtencion = new List<DayOfWeek>();
                foreach (ListItem item in cblDias.Items)
                {
                    if (item.Selected)
                    {
                        med.DiasAtencion.Add((DayOfWeek)int.Parse(item.Value));
                    }
                }

                MedicoNegocio negocio = new MedicoNegocio();
                negocio.agregar(med);

                lblError.Visible = true;
                lblError.CssClass = "text-success mb-3 d-block";
                lblError.Text = "¡Registro exitoso!";
            }
            catch (Exception ex)
            {
                lblError.Visible = true;
                lblError.CssClass = "text-danger mb-3 d-block";
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void cvFecha_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrWhiteSpace(args.Value))
            {
                args.IsValid = false;
                return;
            }
            DateTime fechaIngresada;
            if (DateTime.TryParse(args.Value, out fechaIngresada))
            {
                args.IsValid = fechaIngresada < DateTime.Today;
            }
            else
            {
                args.IsValid = false;
            }
        }
    }
}
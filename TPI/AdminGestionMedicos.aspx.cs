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
    public partial class AdminGestionMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarMedicos();
                cargarEspecialidades();
                cargarDesplegableEspecialidades();
            }
        }
        private void cargarMedicos()
        {
            MedicoNegocio negocio = new MedicoNegocio();
            dgvMedicos.DataSource = negocio.listar();
            dgvMedicos.DataBind();
        }
        private void cargarDesplegableEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            ddlEditEspecialidad.DataSource = negocio.listar();
            ddlEditEspecialidad.DataTextField = "Nombre";
            ddlEditEspecialidad.DataValueField = "Id";
            ddlEditEspecialidad.DataBind();
        }
        private void cargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            dgvEspecialidades.DataSource = negocio.listar();
            dgvEspecialidades.DataBind();
        }
        protected void btnMostrarFormEspecialidad_Click(object sender, EventArgs e)
        {
            pnlNuevaEspecialidad.Visible = true;
            lblMensajeEsp.Text = "";
        }

        protected void btnMostrarListaEspecialidades_Click(object sender, EventArgs e)
        {
            pnlListaEspecialidades.Visible = !pnlListaEspecialidades.Visible;
            btnMostrarListaEspecialidades.Text = pnlListaEspecialidades.Visible
                ? "Ocultar Especialidades"
                : "Mostrar Especialidades";

            if (pnlListaEspecialidades.Visible)
                cargarEspecialidades();
        }

        protected void btnGuardarEsp_Click(object sender, EventArgs e)
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            string nombreEsp = txtNombreEsp.Text.Trim();

            if (negocio.listar().Any(x => x.Nombre.Equals(nombreEsp, StringComparison.OrdinalIgnoreCase)))
            {
                lblMensajeEsp.Text = "Error: Esta especialidad ya existe.";
                lblMensajeEsp.CssClass = "text-danger fw-semibold mt-3 d-block";
                return;
            }

            if (negocio.listarInactivas().Any(x => x.Nombre.Equals(nombreEsp, StringComparison.OrdinalIgnoreCase)))
            {
                lblMensajeEsp.Text = "Especialidad existente pero inactiva, actívela.";
                lblMensajeEsp.CssClass = "text-warning fw-semibold mt-3 d-block";
                return;
            }

            Especialidad esp = new Especialidad();
            esp.Nombre = nombreEsp;
            esp.Descripcion = string.IsNullOrWhiteSpace(txtDescripcionEsp.Text) ? null : txtDescripcionEsp.Text.Trim();

            negocio.agregar(esp);

            txtNombreEsp.Text = "";
            txtDescripcionEsp.Text = "";
            lblMensajeEsp.Text = "Especialidad guardada correctamente.";
            lblMensajeEsp.CssClass = "text-success fw-semibold mt-3 d-block";

            pnlNuevaEspecialidad.Visible = true;
            cargarEspecialidades();
        }

        protected void btnCancelarEsp_Click(object sender, EventArgs e)
        {
            txtNombreEsp.Text = "";
            txtDescripcionEsp.Text = "";
            lblMensajeEsp.Text = "";
            pnlNuevaEspecialidad.Visible = false;
        }
        protected void dgvMedicos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            MedicoNegocio negocio = new MedicoNegocio();

            if (e.CommandName == "Eliminar")
            {
                hfIdEliminarMed.Value = id.ToString();
                pnlConfirmarEliminarMed.Visible = true;
            }
            else if (e.CommandName == "Modificar")
            {
                Medico med = negocio.listar().FirstOrDefault(m => m.Id == id);
                if (med != null)
                {
                    hfIdMedico.Value = med.Id.ToString();
                    txtEditMedDni.Text = med.Dni;
                    txtEditMedNombre.Text = med.Nombre;
                    txtEditMedApellido.Text = med.Apellido;
                    txtEditMedEmail.Text = med.Email;
                    txtEditMedTelefono.Text = med.Telefono;
                    txtEditMedDireccion.Text = med.Direccion;
                    txtEditMedFechaNac.Text = med.FechaNacimiento.ToString("yyyy-MM-dd");
                    txtEditMatri.Text = med.Matricula;
                    txtEditFoto.Text = med.imagenURL;

                    cblEditDias.ClearSelection();
                    ddlEditEspecialidad.ClearSelection();
                    if (med.DiasAtencion != null)
                    {
                        foreach (DayOfWeek dia in med.DiasAtencion)
                        {
                            ListItem item = cblEditDias.Items.FindByValue(((int)dia).ToString());
                            if (item != null)
                            {
                                item.Selected = true;
                            }
                        }
                    }

                    if (med.Especialidad != null)
                    {
                        ddlEditEspecialidad.SelectedValue = med.Especialidad.Id.ToString();
                    }
                    lblMensajeMed.Text = "";
                    pnlEditarMedico.Visible = true;
                }
            }
        }

        protected void btnConfirmarEliminarMed_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdEliminarMed.Value);
            MedicoNegocio negocio = new MedicoNegocio();
            negocio.eliminar(id);

            pnlConfirmarEliminarMed.Visible = false;
            pnlEditarMedico.Visible = false;
            cargarMedicos();
        }

        protected void btnCancelarEliminarMed_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminarMed.Visible = false;
        }

        protected void btnGuardarMed_Click(object sender, EventArgs e)
        {
            MedicoNegocio negocio = new MedicoNegocio();

            Medico med = new Medico();
            med.Id = int.Parse(hfIdMedico.Value);
            med.Dni = txtEditMedDni.Text.Trim();
            med.Nombre = txtEditMedNombre.Text.Trim();
            med.Apellido = txtEditMedApellido.Text.Trim();
            med.Email = txtEditMedEmail.Text.Trim();
            med.Telefono = txtEditMedTelefono.Text.Trim();
            med.Direccion = txtEditMedDireccion.Text.Trim();
            med.FechaNacimiento = DateTime.Parse(txtEditMedFechaNac.Text);
            med.Matricula = txtEditMatri.Text.Trim();
            med.imagenURL = txtEditFoto.Text.Trim();
            med.DiasAtencion = new List<DayOfWeek>();
            foreach (ListItem item in cblEditDias.Items)
            {
                if (item.Selected)
                {
                    med.DiasAtencion.Add((DayOfWeek)int.Parse(item.Value));
                }
            }
            med.Especialidad = new Especialidad();
            med.Especialidad.Id = int.Parse(ddlEditEspecialidad.SelectedValue);

            negocio.modificar(med);

            lblMensajeMed.Text = "Médico modificado correctamente.";
            cargarMedicos();
        }
        protected void btnCancelarMed_Click(object sender, EventArgs e)
        {
            pnlEditarMedico.Visible = false;
            lblMensajeMed.Text = "";
        }

        protected void dgvEspecialidades_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            lblErrorGrillaEsp.Text = "";

            if (e.CommandName == "EliminarEsp")
            {
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                if (medicoNegocio.listar().Any(m => m.Especialidad.Id == id))
                {
                    lblErrorGrillaEsp.Text = "Error: No se puede eliminar la especialidad porque hay médicos asignados a ella.";
                    return;
                }

                hfIdEliminarEsp.Value = id.ToString();
                pnlConfirmarEliminarEsp.Visible = true;
            }
            else if (e.CommandName == "ModificarEsp")
            {
                Especialidad esp = negocio.listar().FirstOrDefault(x => x.Id == id);
                if (esp != null)
                {
                    hfIdEspecialidad.Value = esp.Id.ToString();
                    txtEditNombreEsp.Text = esp.Nombre;
                    txtEditDescripcionEsp.Text = esp.Descripcion;
                    lblMensajeEspEdit.Text = "";
                    pnlEditarEspecialidad.Visible = true;
                }
            }
        }

        protected void btnConfirmarEliminarEsp_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdEliminarEsp.Value);
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            negocio.eliminar(id);

            pnlConfirmarEliminarEsp.Visible = false;
            pnlEditarEspecialidad.Visible = false;
            cargarEspecialidades();
        }

        protected void btnCancelarEliminarEsp_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminarEsp.Visible = false;
        }

        protected void btnGuardarEspEdit_Click(object sender, EventArgs e)
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            int id = int.Parse(hfIdEspecialidad.Value);
            string nombreEsp = txtEditNombreEsp.Text.Trim();

            if (negocio.listar().Any(x => x.Nombre.Equals(nombreEsp, StringComparison.OrdinalIgnoreCase) && x.Id != id))
            {
                lblMensajeEspEdit.Text = "Error: Ya existe otra especialidad activa con ese nombre.";
                lblMensajeEspEdit.CssClass = "text-danger fw-semibold mt-3 d-block";
                return;
            }

            if (negocio.listarInactivas().Any(x => x.Nombre.Equals(nombreEsp, StringComparison.OrdinalIgnoreCase) && x.Id != id))
            {
                lblMensajeEspEdit.Text = "Especialidad existente pero inactiva, actívela.";
                lblMensajeEspEdit.CssClass = "text-warning fw-semibold mt-3 d-block";
                return;
            }
            Especialidad esp = new Especialidad();
            esp.Id = id;
            esp.Nombre = nombreEsp;
            esp.Descripcion = string.IsNullOrWhiteSpace(txtEditDescripcionEsp.Text) ? null : txtEditDescripcionEsp.Text.Trim();

            negocio.modificar(esp);

            lblMensajeEspEdit.Text = "Especialidad modificada correctamente.";
            lblMensajeEspEdit.CssClass = "text-success fw-semibold mt-3 d-block";
            cargarEspecialidades();
        }

        protected void btnCancelarEspEdit_Click(object sender, EventArgs e)
        {
            pnlEditarEspecialidad.Visible = false;
            lblMensajeEspEdit.Text = "";
        }
        protected void btnRecuperarMedicos_Click(object sender, EventArgs e)
        {
            pnlMedicosInactivos.Visible = !pnlMedicosInactivos.Visible;

            if (pnlMedicosInactivos.Visible)
            {
                CargarMedicosInactivos();
            }
        }

        private void CargarMedicosInactivos()
        {
            MedicoNegocio negocio = new MedicoNegocio();
            dgvMedicosInactivos.DataSource = negocio.listarInactivos();
            dgvMedicosInactivos.DataBind();
        }

        protected void dgvMedicosInactivos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ReactivarMed")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                MedicoNegocio negocio = new MedicoNegocio();
                negocio.reactivar(id);

                CargarMedicosInactivos();

                dgvMedicos.DataSource = negocio.listar();
                dgvMedicos.DataBind();
            }
        }
        protected void btnRecuperarEspecialidad_Click(object sender, EventArgs e)
        {
            pnlEspecialidadesInactivas.Visible = !pnlEspecialidadesInactivas.Visible;

            if (pnlEspecialidadesInactivas.Visible)
            {
                CargarEspecialidadesInactivas();
            }
        }

        private void CargarEspecialidadesInactivas()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            dgvEspecialidadesInactivas.DataSource = negocio.listarInactivas();
            dgvEspecialidadesInactivas.DataBind();
        }

        protected void dgvEspecialidadesInactivas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ReactivarEsp")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                negocio.reactivar(id);

                CargarEspecialidadesInactivas();

                dgvEspecialidades.DataSource = negocio.listar();
                dgvEspecialidades.DataBind();
            }
        }

    }
}
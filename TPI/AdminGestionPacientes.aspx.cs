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
    public partial class GestionAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarPacientes();
                cargarObrasSocialesGrid();
                cargarObrasSociales();
            }
        }

        private void cargarPacientes()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            dgvPacientes.DataSource = negocio.listar();
            dgvPacientes.DataBind();
        }

        private void cargarObrasSociales()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            ddlEditObraSocial.DataSource = negocio.listarObrasSociales();
            ddlEditObraSocial.DataTextField = "Value";
            ddlEditObraSocial.DataValueField = "Key";
            ddlEditObraSocial.DataBind();
        }

        private void cargarObrasSocialesGrid()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            dgvObrasSociales.DataSource = negocio.listarObrasSociales();
            dgvObrasSociales.DataBind();
        }
        protected void dgvPacientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            PacienteNegocio negocio = new PacienteNegocio();

            if (e.CommandName == "Eliminar")
            {
                hfIdEliminarPac.Value = id.ToString();
                pnlConfirmarEliminarPac.Visible = true;
            }
            else if (e.CommandName == "Modificar")
            {
                Paciente pac = negocio.listar().FirstOrDefault(p => p.Id == id);
                if (pac != null)
                {
                    hfIdPaciente.Value = pac.Id.ToString();
                    txtEditDni.Text = pac.Dni;
                    txtEditNombre.Text = pac.Nombre;
                    txtEditApellido.Text = pac.Apellido;
                    txtEditEmail.Text = pac.Email;
                    txtEditTelefono.Text = pac.Telefono;
                    txtEditDireccion.Text = pac.Direccion;
                    txtEditFechaNac.Text = pac.FechaNacimiento.ToString("yyyy-MM-dd");
                    lblMensajePac.Text = "";
                    txtEditContraseña.Text = pac.Perfil.Contraseña;
                    pnlEditarPaciente.Visible = true;
                    ddlEditObraSocial.ClearSelection();
                    ddlEditObraSocial.SelectedValue = pac.IdObraSocial.ToString();
                }
            }
        }

        protected void btnConfirmarEliminarPac_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdEliminarPac.Value);
            PacienteNegocio negocio = new PacienteNegocio();
            negocio.eliminar(id);

            pnlConfirmarEliminarPac.Visible = false;
            pnlEditarPaciente.Visible = false;
            cargarPacientes();
        }

        protected void btnCancelarEliminarPac_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminarPac.Visible = false;
        }

        protected void btnGuardarPac_Click(object sender, EventArgs e)
        {
            PacienteNegocio negocio = new PacienteNegocio();

            Paciente pac = new Paciente();
            pac.Id = int.Parse(hfIdPaciente.Value);
            pac.Dni = txtEditDni.Text.Trim();
            pac.Nombre = txtEditNombre.Text.Trim();
            pac.Apellido = txtEditApellido.Text.Trim();
            pac.Email = txtEditEmail.Text.Trim();
            pac.Telefono = txtEditTelefono.Text.Trim();
            pac.Direccion = txtEditDireccion.Text.Trim();
            pac.FechaNacimiento = DateTime.Parse(txtEditFechaNac.Text);
            pac.IdObraSocial = int.Parse(ddlEditObraSocial.SelectedValue);
            pac.Perfil = new Perfil { Contraseña = txtEditContraseña.Text.Trim() };

            negocio.modificar(pac);

            lblMensajePac.Text = "Paciente modificado correctamente.";
            cargarPacientes();
        }

        protected void btnCancelarPac_Click(object sender, EventArgs e)
        {
            pnlEditarPaciente.Visible = false;
            lblMensajePac.Text = "";
        }
        protected void btnAgregarObraSocial_Click(object sender, EventArgs e)
        {
            txtNombreObraSocial.Text = "";
            lblMensajeObraSocial.Text = "";
            pnlNuevaObraSocial.Visible = true;
        }

        protected void btnMostrarListaObrasSociales_Click(object sender, EventArgs e)
        {
            pnlListaObrasSociales.Visible = !pnlListaObrasSociales.Visible;
            btnMostrarListaObrasSociales.Text = pnlListaObrasSociales.Visible
                ? "Ocultar Obras Sociales"
                : "Mostrar Obras Sociales";

            if (pnlListaObrasSociales.Visible)
                cargarObrasSocialesGrid();
        }

        protected void btnGuardarObraSocial_Click(object sender, EventArgs e)
        {
            PacienteNegocio negocio = new PacienteNegocio();
            string nombreOS = txtNombreObraSocial.Text.Trim();

            if (negocio.listarObrasSociales().Values.Any(v => v.Equals(nombreOS, StringComparison.OrdinalIgnoreCase)))
            {
                lblMensajeObraSocial.Text = "Error: Esta obra social ya existe.";
                lblMensajeObraSocial.CssClass = "text-danger fw-semibold mt-3 d-block";
                return;
            }
            if (negocio.listarObrasSocialesInactivas().Values.Any(v => v.Equals(nombreOS, StringComparison.OrdinalIgnoreCase)))
            {
                lblMensajeObraSocial.Text = "Obra social existente pero inactiva, actívela.";
                lblMensajeObraSocial.CssClass = "text-warning fw-semibold mt-3 d-block";
                return;
            }

            negocio.agregarObraSocial(nombreOS);

            lblMensajeObraSocial.Text = "Obra social agregada correctamente.";
            lblMensajeObraSocial.CssClass = "text-success fw-semibold mt-3 d-block";
            txtNombreObraSocial.Text = "";

            cargarObrasSociales();
        }

        protected void btnCancelarObraSocial_Click(object sender, EventArgs e)
        {
            pnlNuevaObraSocial.Visible = false;
        }

        protected void dgvObrasSociales_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            PacienteNegocio negocio = new PacienteNegocio();

            lblErrorGrillaOS.Text = "";

            if (e.CommandName == "EliminarOS")
            {
                int idSinObraSocial = 6;

                if (id == idSinObraSocial)
                {
                    lblErrorGrillaOS.Text = "Error: No se puede eliminar la opción 'Sin Obra Social'.";
                    return;
                }

                hfIdEliminarOS.Value = id.ToString();
                pnlConfirmarEliminarOS.Visible = true;
            }
            else if (e.CommandName == "ModificarOS")
            {
                var obras = negocio.listarObrasSociales();
                if (obras.ContainsKey(id))
                {
                    hfIdObraSocial.Value = id.ToString();
                    txtEditNombreObraSocial.Text = obras[id];
                    lblMensajeObraSocialEdit.Text = "";
                    pnlEditarObraSocial.Visible = true;
                }
            }
        }

        protected void btnConfirmarEliminarOS_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfIdEliminarOS.Value);
            int idSinObraSocial = 6;
            PacienteNegocio negocio = new PacienteNegocio();

            negocio.eliminarObraSocial(id, idSinObraSocial);

            pnlConfirmarEliminarOS.Visible = false;
            pnlEditarObraSocial.Visible = false;
            cargarObrasSociales();
            cargarObrasSocialesGrid();
            cargarPacientes();
        }

        protected void btnCancelarEliminarOS_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminarOS.Visible = false;
        }

        protected void btnGuardarObraSocialEdit_Click(object sender, EventArgs e)
        {
            PacienteNegocio negocio = new PacienteNegocio();
            int id = int.Parse(hfIdObraSocial.Value);
            string nombreOS = txtEditNombreObraSocial.Text.Trim();
 
            var activas = negocio.listarObrasSociales();
            if (activas.Any(x => x.Value.Equals(nombreOS, StringComparison.OrdinalIgnoreCase) && x.Key != id))
            {
                lblMensajeObraSocialEdit.Text = "Error: Ya existe otra obra social activa con ese nombre.";
                lblMensajeObraSocialEdit.CssClass = "text-danger fw-semibold mt-3 d-block";
                return;
            }

            var inactivas = negocio.listarObrasSocialesInactivas();
            if (inactivas.Any(x => x.Value.Equals(nombreOS, StringComparison.OrdinalIgnoreCase) && x.Key != id))
            {
                lblMensajeObraSocialEdit.Text = "Obra social existente pero inactiva, actívela.";
                lblMensajeObraSocialEdit.CssClass = "text-warning fw-semibold mt-3 d-block";
                return;
            }

            negocio.modificarObraSocial(id, nombreOS);

            lblMensajeObraSocialEdit.Text = "Obra social modificada correctamente.";
            lblMensajeObraSocialEdit.CssClass = "text-success fw-semibold mt-3 d-block";

            cargarObrasSociales();
            cargarObrasSocialesGrid();
        }

        protected void btnCancelarObraSocialEdit_Click(object sender, EventArgs e)
        {
            pnlEditarObraSocial.Visible = false;
            lblMensajeObraSocialEdit.Text = "";
        }

        protected void btnRecuperarPacientes_Click(object sender, EventArgs e)
        {
            pnlPacientesInactivos.Visible = !pnlPacientesInactivos.Visible;

            if (pnlPacientesInactivos.Visible)
            {
                CargarPacientesInactivos();
            }
        }

        private void CargarPacientesInactivos()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            dgvPacientesInactivos.DataSource = negocio.listarInactivos();
            dgvPacientesInactivos.DataBind();
        }

        protected void dgvPacientesInactivos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Reactivar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                PacienteNegocio negocio = new PacienteNegocio();
                negocio.reactivar(id);

                CargarPacientesInactivos();

                dgvPacientes.DataSource = negocio.listar();
                dgvPacientes.DataBind();
            }
        }
        protected void btnRecuperarObraSocial_Click(object sender, EventArgs e)
        {
            pnlObrasSocialesInactivas.Visible = !pnlObrasSocialesInactivas.Visible;

            if (pnlObrasSocialesInactivas.Visible)
            {
                CargarObrasSocialesInactivas();
            }
        }

        private void CargarObrasSocialesInactivas()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            dgvObrasSocialesInactivas.DataSource = negocio.listarObrasSocialesInactivas();
            dgvObrasSocialesInactivas.DataBind();
        }

        protected void dgvObrasSocialesInactivas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ReactivarOS")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                PacienteNegocio negocio = new PacienteNegocio();
                negocio.reactivarObraSocial(id);

                CargarObrasSocialesInactivas();

                dgvObrasSociales.DataSource = negocio.listarObrasSociales();
                dgvObrasSociales.DataBind();
            }
        }
    }
}
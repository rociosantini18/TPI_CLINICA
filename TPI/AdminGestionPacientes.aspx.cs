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
                cargarPacientes();
            cargarObrasSociales();
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
        protected void dgvPacientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            PacienteNegocio negocio = new PacienteNegocio();

            if (e.CommandName == "Eliminar")
            {
                negocio.eliminar(id);
                cargarPacientes();
                pnlEditarPaciente.Visible = false;
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
                    ddlEditObraSocial.Items.FindByValue(pac.IdObraSocial.ToString()).Selected = true;
                    pnlEditarPaciente.Visible = true;
                }
            }
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
            pac.Perfil = new Perfil{Contraseña = txtEditContraseña.Text.Trim()};

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

        protected void btnGuardarObraSocial_Click(object sender, EventArgs e)
        {
            PacienteNegocio negocio = new PacienteNegocio();
            negocio.agregarObraSocial(txtNombreObraSocial.Text.Trim());

            lblMensajeObraSocial.Text = "Obra social agregada correctamente.";
            txtNombreObraSocial.Text = "";

            cargarObrasSociales();
        }

        protected void btnCancelarObraSocial_Click(object sender, EventArgs e)
        {
            pnlNuevaObraSocial.Visible = false;
        }
    }
}
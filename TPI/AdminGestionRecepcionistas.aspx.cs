using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Negocio;

namespace TPI
{
    public partial class AdminGestionRecepcionistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EmpleadoNegocio negocio = new EmpleadoNegocio();
            dgvRecepcionistas.DataSource = negocio.listarRecepcionista();
            dgvRecepcionistas.DataBind();
        }
    }
}
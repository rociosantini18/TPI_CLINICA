using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI.Negocio;

namespace TPI
{
    public partial class AdminGestionAdministradores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EmpleadoNegocio negocio = new EmpleadoNegocio();
            dgvAdmins.DataSource = negocio.listarAdministradores();
            dgvAdmins.DataBind();
        }
    }
}
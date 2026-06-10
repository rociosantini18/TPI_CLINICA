using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI
{
    public partial class Registrarse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.DataBind();
            }
        }

        protected void btn_registrarse_click(object sender, EventArgs a)
        {
          

            if (!Page.IsValid) return;

            lblError.Visible = true;
            lblError.CssClass = "text-success mb-3 d-block";
            lblError.Text = "Formulario valido! (sin logica de BD)";
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
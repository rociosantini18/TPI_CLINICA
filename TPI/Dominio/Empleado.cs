using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPI.Dominio
{
    public class Empleado : Persona
    {
        public Perfil Perfil { get; set; }
        public int Permisos {  get; set; }
    }
}
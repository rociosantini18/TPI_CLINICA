using System;
using System.Collections.Generic;

namespace TPI.Dominio
{
    public class Medico
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }

        public string Matricula { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }

        public List<Especialidad> Especialidades { get; set; }

        public TurnoTrabajo TurnoTrabajo { get; set; }

        public bool  Activo { get; set; }
    }
}
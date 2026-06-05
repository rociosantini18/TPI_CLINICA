using System;
using System.Collections.Generic;

namespace TPI.Dominio
{
    public class Medico : Usuario
    {

        public string Matricula { get; set; }

        public List<Especialidad> Especialidades { get; set; }

        public TurnoTrabajo TurnoTrabajo { get; set; }
    }
}
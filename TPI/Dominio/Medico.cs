using System;
using System.Collections.Generic;

namespace TPI.Dominio
{
    public class Medico : Persona
    {

        public string Matricula { get; set; }

        public List<Especialidad> Especialidades { get; set; }

    }
}
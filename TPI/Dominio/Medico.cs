using System;
using System.Collections.Generic;

namespace TPI.Dominio
{
    public class Medico : Persona
    {
        public int IdMedico { get; set; }
        public Perfil Perfil { get; set; }
        public string Matricula { get; set; }

        public Especialidad Especialidad { get; set; }
        public List<HorarioMedico> Horarios { get; set; }
        public List<DayOfWeek> DiasAtencion { get; set; }
        public string imagenURL { get; set;  }

        public Medico()
        {
            Especialidad = new Especialidad();
            Horarios = new List<HorarioMedico>();
            DiasAtencion = new List<DayOfWeek>();
        }

    }
}
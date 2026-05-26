using System;

namespace TPI.Dominio
{
    public class Turno
    {
        public int Id { get; set; }
        public string Numero { get; set; }

        public DateTime Fecha { get; set; }

        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }

        public string Observaciones { get; set; }

        public string Diagnostico  { get; set; }

        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; } Nullable

        public string Estado { get; set; }   //Nuevo, Reprogramado, Cancelado, No Asistió, Cerrado 

        public Paciente Paciente { get; set; }

        public Medico Medico { get; set; }

        public Especialidad Especialidad { get; set; }

    }
}
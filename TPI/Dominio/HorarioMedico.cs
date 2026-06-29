using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPI.Dominio
{
    public class HorarioMedico
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }
    }
}
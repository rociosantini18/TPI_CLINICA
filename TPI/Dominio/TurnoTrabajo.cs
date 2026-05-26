using System;

namespace TPI.Dominio
{
    public class TurnoTrabajo
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public TimeSpan HoraEntrada { get; set; }
        public TimeSpan HoraSalida { get; set; }
    }
}
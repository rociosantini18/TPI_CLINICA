using System;

namespace TPI.Dominio
{
    public class Paciente
    {

        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }

        public string Dni { get; set; }
        public DateTime FechaNacimiento { get; set; }

        public string Email { get; set; }

        public string Telefono { get; set; }

        public string Direccion { get; set; }

        public string ObraSocial { get; set; }

        public bool Activo { get; set; } //Para la baja logica
    }
}
using System;

namespace TPI.Dominio
{
    public class Usuario
    {
        public int Id { get; set; }
        public string Dni { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
        public string Contraseña { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public Perfil Perfil { get; set; }
        public bool Activo { get; set; }
    }
}
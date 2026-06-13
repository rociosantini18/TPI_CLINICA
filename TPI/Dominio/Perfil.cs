using System;

namespace TPI.Dominio
{
    public class Perfil
    {
        public int Id { get; set; }
        public string Rol { get; set; } // Administrador, recepcionista, pacientes 
        public string NombreUsuario { get; set; }
        public string Contraseña { get; set; }
        public bool Activo { get; set; }

    }
}


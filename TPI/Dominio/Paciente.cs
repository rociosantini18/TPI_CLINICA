using System;

namespace TPI.Dominio
{
    public class Paciente : Persona
    {
        public Perfil Perfil { get; set; }
        public string ObraSocial { get; set; }

    }
}
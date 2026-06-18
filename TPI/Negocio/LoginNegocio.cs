using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;
using TPI.Negocio;

namespace TPI.Negocio
{
    public class LoginNegocio
    {
        public Perfil login(string usuario, string contrasena)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT p.Id_Perfil, p.NombreUsuario, p.Contraseña, p.Activo, r.NombreRol
                    FROM Perfil p
                    INNER JOIN Rol r ON p.Id_Rol = r.Id_Rol
                    WHERE p.NombreUsuario = @usuario
                    AND p.Contraseña = @contrasena
                    AND p.Activo = 1");

                datos.setearParametro("@usuario", usuario);
                datos.setearParametro("@contrasena", contrasena);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Perfil perfil = new Perfil();
                    perfil.Id = (int)datos.Lector["Id_Perfil"];
                    perfil.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    perfil.Contraseña = (string)datos.Lector["Contraseña"];
                    perfil.Activo = (bool)datos.Lector["Activo"];
                    perfil.Rol = (string)datos.Lector["NombreRol"];
                    return perfil;
                }

                return null;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }
    }
}
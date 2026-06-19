using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;

namespace TPI.Negocio
{
    public class EmpleadoNegocio
    {
        public List<Empleado> listar()
        {
            List<Empleado> lista = new List<Empleado>();

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT e.Id_Empleado, per.Dni, per.Nombre, per.Apellido,
                           per.Email, per.Telefono, per.Direccion, per.FechaNacimiento,
                           pf.Id_Perfil, pf.NombreUsuario, pf.Contraseña, pf.Activo,
                           r.NombreRol
                    FROM Empleado e
                    INNER JOIN Persona per ON p.Id_Persona = per.Id_Persona
                    INNER JOIN Perfil pf ON p.Id_Perfil = pf.Id_Perfil
                    INNER JOIN Rol r ON pf.Id_Rol = r.Id_Rol");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Empleado aux = new Empleado();

                    aux.Id = (int)datos.Lector["Id_Empleado"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];

                    aux.Perfil = new Perfil();
                    aux.Perfil.Id = (int)datos.Lector["Id_Perfil"];
                    aux.Perfil.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    aux.Perfil.Contraseña = (string)datos.Lector["Contraseña"];
                    aux.Perfil.Activo = (bool)datos.Lector["Activo"];
                    aux.Perfil.Rol = (string)datos.Lector["NombreRol"];

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("DELETE FROM Empleado WHERE Id_Empleado = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }


        public void agregar(Empleado emp)
        {
            AccesoDatos datos = new AccesoDatos();
            int idPersona = 0;
            int idPerfil = 0;

            try
            {
                datos.setearConsulta(@"
                INSERT INTO Empleado (Dni, Nombre, Apellido, Email, Telefono, Direccion, FechaNacimiento)
                OUTPUT INSERTED.Id_Empleado
                VALUES (@dni, @nombre, @apellido, @email, @telefono, @direccion, @fechaNac)");

                datos.setearParametro("@dni", emp.Dni);
                datos.setearParametro("@nombre", emp.Nombre);
                datos.setearParametro("@apellido", emp.Apellido);
                datos.setearParametro("@email", emp.Email);
                datos.setearParametro("@telefono", emp.Telefono);
                datos.setearParametro("@direccion", emp.Direccion);
                datos.setearParametro("@fechaNac", emp.FechaNacimiento);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    idPersona = (int)datos.Lector[0];
                datos.CerrarConexion();

                datos = new AccesoDatos();
                datos.setearConsulta(@"
                INSERT INTO Perfil (Id_Rol, NombreUsuario, Contraseña, Activo)
                OUTPUT INSERTED.Id_Perfil
                VALUES (@idRol, @usuario, @contrasena, @activo)");

                datos.setearParametro("@idRol", 3);
                datos.setearParametro("@usuario", emp.Perfil.NombreUsuario);
                datos.setearParametro("@contrasena", emp.Perfil.Contraseña);
                datos.setearParametro("@activo", true);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    idPerfil = (int)datos.Lector[0];
                datos.CerrarConexion();

                datos = new AccesoDatos();
                datos.setearConsulta(@"
                INSERT INTO Empleado (Id_Persona, Id_Perfil)
                VALUES (@idPersona, @idPerfil)");

                datos.setearParametro("@idPersona", idPersona);
                datos.setearParametro("@idPerfil", idPerfil);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void modificar(Empleado emp)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    UPDATE Persona SET
                        Dni = @dni,
                        Nombre = @nombre,
                        Apellido = @apellido,
                        Email = @email,
                        Telefono = @telefono,
                        Direccion = @direccion,
                        FechaNacimiento= @fechaNac
                    WHERE Id_Persona = (
                        SELECT Id_Persona FROM Empleado WHERE Id_Empleado = @id
                    )");

                datos.setearParametro("@dni", emp.Dni);
                datos.setearParametro("@nombre", emp.Nombre);
                datos.setearParametro("@apellido", emp.Apellido);
                datos.setearParametro("@email", emp.Email);
                datos.setearParametro("@telefono", emp.Telefono);
                datos.setearParametro("@direccion", emp.Direccion);
                datos.setearParametro("@fechaNac", emp.FechaNacimiento);
                datos.setearParametro("@id", emp.Id);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}
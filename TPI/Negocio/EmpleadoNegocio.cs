using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;

namespace TPI.Negocio
{
    public class EmpleadoNegocio
    {
        public List<Empleado> listarEmpleados()
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
                    INNER JOIN Persona per ON e.Id_Persona = per.Id_Persona
                    INNER JOIN Perfil pf ON e.Id_Perfil = pf.Id_Perfil
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
                datos.setearConsulta(@"
            UPDATE Perfil SET Activo = 0
            WHERE Id_Perfil = (
                SELECT Id_Perfil FROM Empleado WHERE Id_Empleado = @id
            )");
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

        public void agregar(Empleado emp, int idRol)
        {
            AccesoDatos datos = new AccesoDatos();
            int idPersona = 0;
            int idPerfil = 0;
            try
            {
                datos.setearConsulta(@"
            INSERT INTO Persona (Dni, Nombre, Apellido, Email, Telefono, Direccion, FechaNacimiento)
            OUTPUT INSERTED.Id_Persona
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
                VALUES (@idRol, @usuario, @contrasena, 1)");
    
                datos.setearParametro("@idRol", idRol);
                datos.setearParametro("@usuario", emp.Perfil.NombreUsuario);
                datos.setearParametro("@contrasena", emp.Perfil.Contraseña);
                datos.ejecutarLectura();
                if (datos.Lector.Read()) idPerfil = (int)datos.Lector[0];
                datos.CerrarConexion();

                datos = new AccesoDatos();
                datos.setearConsulta("INSERT INTO Empleado (Id_Persona, Id_Perfil) VALUES (@idPersona, @idPerfil)");
                datos.setearParametro("@idPersona", idPersona);
                datos.setearParametro("@idPerfil", idPerfil);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
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
                    WHERE Id_Persona = @id");


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

        public List<Empleado> listarRecepcionista()
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
                    INNER JOIN Persona per ON e.Id_Persona = per.Id_Persona
                    INNER JOIN Perfil pf ON e.Id_Perfil = pf.Id_Perfil
                    INNER JOIN Rol r ON pf.Id_Rol = r.Id_Rol
                    WHERE r.Id_Rol = 2 AND pf.Activo = 1");

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



        public List<Empleado> listarAdministradores()
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
                    INNER JOIN Persona per ON e.Id_Persona = per.Id_Persona
                    INNER JOIN Perfil pf ON e.Id_Perfil = pf.Id_Perfil
                    INNER JOIN Rol r ON pf.Id_Rol = r.Id_Rol
                    WHERE pf.Activo = 1");

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

                    if (aux.Perfil.Rol == "Administrador")
                    {
                        lista.Add(aux);
                    }
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

        public Empleado RelacionPerfilPersona(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                select p.Id_Persona, p.Dni, p.Nombre, p.Apellido, p.Telefono, p.Email, p.Direccion, p.FechaNacimiento 
                        from Empleado emp
                        inner join Perfil perf on emp.Id_Perfil = perf.Id_Perfil 
                        inner join Persona p on emp.Id_Persona = p.Id_Persona
                    where perf.Id_Perfil = @id");

                datos.setearParametro("@id", id);

                datos.ejecutarLectura();

                Empleado e = null;

                if (datos.Lector.Read())
                {

                    e = new Empleado();

                    e.Id = (int)datos.Lector["Id_Persona"];
                    e.Dni = datos.Lector["Dni"].ToString();
                    e.Nombre = datos.Lector["Nombre"].ToString();
                    e.Apellido = datos.Lector["Apellido"].ToString();
                    e.Telefono = datos.Lector["Telefono"].ToString();
                    e.Email = datos.Lector["Email"].ToString();
                    e.Direccion = datos.Lector["Direccion"].ToString();
                    e.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                }

                return e;
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

        public List<Empleado> listarInactivos(int idRol)
        {
            List<Empleado> lista = new List<Empleado>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
            SELECT e.Id_Empleado, per.Dni, per.Nombre, per.Apellido, per.Email
            FROM Empleado e
            INNER JOIN Persona per ON e.Id_Persona = per.Id_Persona
            INNER JOIN Perfil pf ON e.Id_Perfil = pf.Id_Perfil
            WHERE pf.Id_Rol = @idRol AND pf.Activo = 0");
                datos.setearParametro("@idRol", idRol);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Empleado aux = new Empleado();
                    aux.Id = (int)datos.Lector["Id_Empleado"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Email = (string)datos.Lector["Email"];
                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void reactivar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
            UPDATE Perfil SET Activo = 1 
            WHERE Id_Perfil = (SELECT Id_Perfil FROM Empleado WHERE Id_Empleado = @id)");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

    }
}
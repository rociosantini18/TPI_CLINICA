using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using TPI.Dominio;
using TPI.Negocio;

namespace TPI.Negocio
{
    public class PacienteNegocio
    {

        public List<Paciente> listar()
        {
            List<Paciente> lista = new List<Paciente>();

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT p.Id_Paciente, per.Dni, per.Nombre, per.Apellido,
                           per.Email, per.Telefono, per.Direccion, per.FechaNacimiento,
                           os.Nombre_ObraSocial,
                           pf.Id_Perfil, pf.NombreUsuario, pf.Contraseña, pf.Activo,
                           r.NombreRol
                    FROM Paciente p
                    INNER JOIN Persona per ON p.Id_Persona = per.Id_Persona
                    LEFT JOIN ObraSocial os ON p.Id_ObraSocial = os.Id_ObraSocial
                    INNER JOIN Perfil pf ON p.Id_Perfil = pf.Id_Perfil
                    INNER JOIN Rol r ON pf.Id_Rol = r.Id_Rol
                     WHERE pf.Activo = 1");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Paciente aux = new Paciente();

                    aux.Id = (int)datos.Lector["Id_Paciente"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    aux.ObraSocial = datos.Lector["Nombre_ObraSocial"] as string;

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
                SELECT Id_Perfil FROM Paciente WHERE Id_Paciente = @id
            )");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }


        public void agregar(Paciente pac)
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

                datos.setearParametro("@dni", pac.Dni);
                datos.setearParametro("@nombre", pac.Nombre);
                datos.setearParametro("@apellido", pac.Apellido);
                datos.setearParametro("@email", pac.Email);
                datos.setearParametro("@telefono", pac.Telefono);
                datos.setearParametro("@direccion", pac.Direccion);
                datos.setearParametro("@fechaNac", pac.FechaNacimiento);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    idPersona = (int)datos.Lector[0];
                datos.CerrarConexion();

                datos = new AccesoDatos();
                datos.setearConsulta(@"
                INSERT INTO Perfil (Id_Rol, NombreUsuario, Contraseña, Activo)
                OUTPUT INSERTED.Id_Perfil
                VALUES (@idRol, @usuario, @contrasena, @activo)");

                datos.setearParametro("@idRol", 2);
                datos.setearParametro("@usuario", pac.Perfil.NombreUsuario);
                datos.setearParametro("@contrasena", pac.Perfil.Contraseña);
                datos.setearParametro("@activo", true);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    idPerfil = (int)datos.Lector[0];
                datos.CerrarConexion();

                datos = new AccesoDatos();
                datos.setearConsulta(@"
                INSERT INTO Paciente (Id_Persona, Id_ObraSocial, Id_Perfil)
                VALUES (@idPersona, @idOS, @idPerfil)");

                datos.setearParametro("@idPersona", idPersona);
                datos.setearParametro("@idOS", pac.IdObraSocial == 0 ? (object)DBNull.Value : pac.IdObraSocial);
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

        public void modificar(Paciente pac)
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
                        SELECT Id_Persona FROM Paciente WHERE Id_Paciente = @id
                    )");

                datos.setearParametro("@dni", pac.Dni);
                datos.setearParametro("@nombre", pac.Nombre);
                datos.setearParametro("@apellido", pac.Apellido);
                datos.setearParametro("@email", pac.Email);
                datos.setearParametro("@telefono", pac.Telefono);
                datos.setearParametro("@direccion", pac.Direccion);
                datos.setearParametro("@fechaNac", pac.FechaNacimiento);
                datos.setearParametro("@id", pac.Id);

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
        public int ObtenerIdPacientePorPerfil(int idPerfil)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT Id_Paciente FROM Paciente WHERE Id_Perfil = @idPerfil");
                datos.setearParametro("@idPerfil", idPerfil);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                    return (int)datos.Lector["Id_Paciente"];

                return 0;
            }
            finally { datos.CerrarConexion(); }
        }
        public Dictionary<int, string> listarObrasSociales()
        {
            Dictionary<int, string> obras = new Dictionary<int, string>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Id_ObraSocial, Nombre_ObraSocial FROM ObraSocial");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    obras.Add(
                        (int)datos.Lector["Id_ObraSocial"],
                        (string)datos.Lector["Nombre_ObraSocial"]
                    );
                }

                return obras;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public Paciente RelacionPerfilPersona(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                select p.Id_Persona, p.Dni, p.Nombre, p.Apellido, p.Telefono, p.Email, p.Direccion, p.FechaNacimiento, ob.Id_ObraSocial, ob.Nombre_ObraSocial 
                        from Paciente pac
                        inner join Perfil perf on pac.Id_Perfil = perf.Id_Perfil 
                        inner join Persona p on pac.Id_Persona = p.Id_Persona
                        inner join ObraSocial ob on pac.Id_ObraSocial = ob.Id_ObraSocial
                    where perf.Id_Perfil = @id");

                datos.setearParametro("@id", id);

                datos.ejecutarLectura();

                Paciente p = null;

                if (datos.Lector.Read())
                {

                    p = new Paciente();

                    p.Id = (int)datos.Lector["Id_Persona"];
                    p.Dni = datos.Lector["Dni"].ToString();
                    p.Nombre = datos.Lector["Nombre"].ToString();
                    p.Apellido = datos.Lector["Apellido"].ToString();
                    p.Telefono = datos.Lector["Telefono"].ToString();
                    p.Email = datos.Lector["Email"].ToString();
                    p.Direccion = datos.Lector["Direccion"].ToString();
                    p.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    p.ObraSocial = datos.Lector["Nombre_ObraSocial"].ToString();
                    p.IdObraSocial = (int)datos.Lector["Id_ObraSocial"];

                }

                return p;
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

        public List<Paciente> BuscarPaciente(string criterio)
        {
            List<Paciente> lista = new List<Paciente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                select p.Id_Persona, p.Dni, p.Nombre, p.Apellido, p.Telefono, p.Email
                    from Paciente pac
                    inner join Persona p ON pac.Id_Persona = p.Id_Persona
                    where 
                        p.Dni like @criterio
                        or p.Nombre like @criterio
                        or p.Apellido like @criterio");

                datos.setearParametro("@criterio", "%" + criterio + "%");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Paciente paciente = new Paciente();

                    paciente.Id = (int)datos.Lector["Id_Persona"];
                    paciente.Dni = datos.Lector["Dni"].ToString();
                    paciente.Nombre = datos.Lector["Nombre"].ToString();
                    paciente.Apellido = datos.Lector["Apellido"].ToString();
                    paciente.Telefono = datos.Lector["Telefono"].ToString();
                    paciente.Email = datos.Lector["Email"].ToString();

                    lista.Add(paciente);
                }

                return lista;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public Paciente BuscarPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    select pac.Id_Paciente, p.Id_Persona, p.Nombre, p.Apellido, p.DNI, ob.Id_ObraSocial, ob.Nombre_ObraSocial
                        from Paciente pac
                    inner join Persona p on pac.Id_Persona = p.Id_Persona
                    inner join ObraSocial ob on pac.Id_ObraSocial = ob.Id_ObraSocial
                    where p.Id_Persona = @id");

                datos.setearParametro("@id", id);

                datos.ejecutarLectura();

                Paciente p = null;

                if (datos.Lector.Read())
                {

                    p = new Paciente();
                    p.IdPaciente = (int)datos.Lector["Id_Paciente"];
                    p.Id = (int)datos.Lector["Id_Persona"];
                    p.Dni = datos.Lector["Dni"].ToString();
                    p.Nombre = datos.Lector["Nombre"].ToString();
                    p.Apellido = datos.Lector["Apellido"].ToString();
                    p.ObraSocial = datos.Lector["Nombre_ObraSocial"].ToString();
                    p.IdObraSocial = (int)datos.Lector["Id_ObraSocial"];

                }

                return p;

            }
            catch (Exception)
            {

                throw;
            }


        }

    }
}
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;

namespace TPI.Negocio
{
    public class MedicoNegocio
    {
        private List<DayOfWeek> listarDiasPorMedico(int idMedico)
        {
            List<DayOfWeek> dias = new List<DayOfWeek>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT DiaSemana FROM MedicoDiaAtencion WHERE Id_Medico = @id");
                datos.setearParametro("@id", idMedico);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    dias.Add((DayOfWeek)Convert.ToInt32(datos.Lector["DiaSemana"]));
                }
                return dias;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public List<Medico> listar()
        {
            List<Medico> lista = new List<Medico>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT m.Id_Medico, per.Dni, per.Nombre, per.Apellido,
                           per.Email, per.Telefono, per.Direccion, per.FechaNacimiento,
                           m.Matricula, m.Imagen_URL,
                           esp.Id_Especialidad, esp.Nombre_Especialidad, esp.Descripcion,
                            perf.Id_Perfil, perf.NombreUsuario, perf.Contraseña
                    FROM Medico m
                    INNER JOIN Persona per ON m.Id_Persona = per.Id_Persona
                    LEFT JOIN Especialidad esp ON m.Id_Especialidad = esp.Id_Especialidad
                    LEFT JOIN Perfil perf ON m.Id_Perfil = perf.Id_Perfil
                    WHERE m.Activo = 1");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();

                    aux.Id = (int)datos.Lector["Id_Medico"];
                    aux.DiasAtencion = listarDiasPorMedico(aux.Id);
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.imagenURL = datos.Lector["Imagen_URL"] != DBNull.Value ? (string)datos.Lector["Imagen_URL"] : "";
                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Id = datos.Lector["Id_Especialidad"] != DBNull.Value ? (int)datos.Lector["Id_Especialidad"] : 0;
                    aux.Especialidad.Nombre = datos.Lector["Nombre_Especialidad"] as string;
                    aux.Especialidad.Descripcion = datos.Lector["Descripcion"] as string;
                    aux.Perfil = new Perfil();
                    aux.Perfil.Id = (int)datos.Lector["Id_Perfil"];
                    aux.Perfil.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    aux.Perfil.Contraseña = (string)datos.Lector["Contraseña"];

                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Medico SET Activo = 0 WHERE Id_Medico = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void agregar(Medico med)
        {
            AccesoDatos datos = new AccesoDatos();
            int idPersona = 0;

            try
            {
                datos.setearConsulta(@"
                INSERT INTO Persona (Dni, Nombre, Apellido, Email, Telefono, Direccion, FechaNacimiento)
                OUTPUT INSERTED.Id_Persona
                VALUES (@dni, @nombre, @apellido, @email, @telefono, @direccion, @fechaNac)");

                datos.setearParametro("@dni", med.Dni);
                datos.setearParametro("@nombre", med.Nombre);
                datos.setearParametro("@apellido", med.Apellido);
                datos.setearParametro("@email", med.Email);
                datos.setearParametro("@telefono", med.Telefono);
                datos.setearParametro("@direccion", med.Direccion);
                datos.setearParametro("@fechaNac", med.FechaNacimiento);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    idPersona = (int)datos.Lector[0];
                datos.CerrarConexion();

                datos = new AccesoDatos();
                datos.setearConsulta(@"
                INSERT INTO Medico (Id_Persona, Matricula, Id_Especialidad, Imagen_URL)
                OUTPUT INSERTED.Id_Medico
                VALUES (@idPersona, @matricula, @idEspecialidad, @imgURL)");

                datos.setearParametro("@idPersona", idPersona);
                datos.setearParametro("@matricula", med.Matricula);
                datos.setearParametro("@idEspecialidad", med.Especialidad.Id);
                datos.setearParametro("@imgURL", med.imagenURL);

                datos.ejecutarLectura();
                int idMedicoNuevo = 0;
                if (datos.Lector.Read())
                    idMedicoNuevo = (int)datos.Lector[0];
                datos.CerrarConexion();

                if (idMedicoNuevo > 0 && med.DiasAtencion != null)
                {
                    modificarDiasAtencion(idMedicoNuevo, med.DiasAtencion);
                }
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void modificar(Medico med)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            UPDATE per SET
                per.Dni = @dni,per.Nombre = @nombre,per.Apellido = @apellido,
                per.Email = @email,per.Telefono = @telefono,per.Direccion = @direccion,
                per.FechaNacimiento = @fechaNac
            FROM Persona per
            INNER JOIN Medico m ON per.Id_Persona = m.Id_Persona
            WHERE m.Id_Medico = @id;

            UPDATE Medico SET
                Matricula = @matricula,Imagen_URL = @imagenUrl,Id_Especialidad = @idEspecialidad
            WHERE Id_Medico = @id

            UPDATE Perfil SET
                NombreUsuario = @nombreUsuario, Contraseña = @contraseña
            FROM Perfil perf
            INNER JOIN Medico m ON perf.Id_Perfil = m.Id_Perfil
            WHERE Id_Medico = @id"
                );

                datos.setearParametro("@dni", med.Dni);
                datos.setearParametro("@nombre", med.Nombre);
                datos.setearParametro("@apellido", med.Apellido);
                datos.setearParametro("@email", med.Email);
                datos.setearParametro("@telefono", med.Telefono);
                datos.setearParametro("@direccion", med.Direccion);
                datos.setearParametro("@fechaNac", med.FechaNacimiento);
                datos.setearParametro("@id", med.IdMedico);
                datos.setearParametro("@matricula", med.Matricula);
                datos.setearParametro("@imagenUrl", med.imagenURL);
                datos.setearParametro("@idEspecialidad", med.Especialidad.Id);
                datos.setearParametro("@nombreUsuario", med.Perfil.NombreUsuario);
                datos.setearParametro("@contraseña", med.Perfil.Contraseña);


                datos.ejecutarAccion();
                datos.CerrarConexion();

                if (med.DiasAtencion != null)
                {
                    modificarDiasAtencion(med.IdMedico, med.DiasAtencion);
                }
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }
        public void modificarDiasAtencion(int idMedico, List<DayOfWeek> nuevosDias)
        {
            AccesoDatos datosDelete = new AccesoDatos();
            try
            {
                datosDelete.setearConsulta("DELETE FROM MedicoDiaAtencion WHERE Id_Medico = @id");
                datosDelete.setearParametro("@id", idMedico);
                datosDelete.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datosDelete.CerrarConexion(); }

            if (nuevosDias == null) return;

            foreach (DayOfWeek dia in nuevosDias)
            {
                AccesoDatos datosInsert = new AccesoDatos();
                try
                {
                    datosInsert.setearConsulta("INSERT INTO MedicoDiaAtencion (Id_Medico, DiaSemana) VALUES (@id, @dia)");
                    datosInsert.setearParametro("@id", idMedico);
                    datosInsert.setearParametro("@dia", (int)dia);
                    datosInsert.ejecutarAccion();
                }
                catch (Exception ex) { throw ex; }
                finally { datosInsert.CerrarConexion(); }
            }
        }

        public List<Medico> listarMedicosSegunEspecialidad(int idEspecialidad)
        {
            AccesoDatos datos = new AccesoDatos();
            List<Medico> lista = new List<Medico>();

            try
            {
                datos.setearConsulta(@"
                
                select distinct m.Id_Medico, e.Id_Especialidad, p.Nombre + ' ' + p.Apellido as Nombre 
                    from Medico m 
                    inner join Persona p on m.Id_Persona = p.Id_Persona
                    inner join MedicoEspecialidad medEsp on m.Id_Medico = medEsp.Id_Medico
                    inner join Especialidad e on medEsp.Id_Especialidad = e.Id_Especialidad
                    where m.Activo = 1 AND e.Id_Especialidad = @id AND medEsp.Estado = 1");

                datos.setearParametro("@id", idEspecialidad);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id_Medico"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Id = (int)datos.Lector["Id_Especialidad"];
                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception) { throw; }
            finally { datos.CerrarConexion(); }
        }

        public List<Medico> listarInactivos()
        {
            List<Medico> lista = new List<Medico>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
            SELECT m.Id_Medico, per.Dni, per.Nombre, per.Apellido,
                   per.Email, per.Telefono, per.Direccion, per.FechaNacimiento,
                   m.Matricula, m.Imagen_URL, esp.Id_Especialidad,
                   esp.Nombre_Especialidad, esp.Descripcion
            FROM Medico m
            INNER JOIN Persona per ON m.Id_Persona = per.Id_Persona
            LEFT JOIN Especialidad esp ON m.Id_Especialidad = esp.Id_Especialidad
            WHERE m.Activo = 0");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id_Medico"];
                    aux.DiasAtencion = listarDiasPorMedico(aux.Id);
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Nombre = datos.Lector["Nombre_Especialidad"] as string;
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
                datos.setearConsulta("UPDATE Medico SET Activo = 1 WHERE Id_Medico = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public Medico RelacionPerfilPersona(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                select med.Id_Medico, med.Matricula, med.Imagen_URL, p.Id_Persona, p.Dni, p.Nombre, p.Apellido, p.Telefono, p.Email, p.Direccion, p.FechaNacimiento, perf.Contraseña, perf.NombreUsuario, esp.Nombre_Especialidad, esp.Id_Especialidad
                        from Medico med
                        inner join Perfil perf on med.Id_Perfil = perf.Id_Perfil 
                        inner join Persona p on med.Id_Persona = p.Id_Persona
                        left join Especialidad esp on med.Id_Especialidad = esp.Id_Especialidad
                    where perf.Id_Perfil = @id");

                datos.setearParametro("@id", id);
                datos.ejecutarLectura();

                Medico m = null;

                if (datos.Lector.Read())
                {
                    m = new Medico();
                    m.IdMedico = (int)datos.Lector["Id_Medico"];
                    m.Id = (int)datos.Lector["Id_Persona"];

                    m.Dni = datos.Lector["Dni"].ToString();
                    m.Nombre = datos.Lector["Nombre"].ToString();
                    m.Apellido = datos.Lector["Apellido"].ToString();
                    m.Telefono = datos.Lector["Telefono"].ToString();
                    m.Email = datos.Lector["Email"].ToString();
                    m.Direccion = datos.Lector["Direccion"].ToString();
                    m.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    m.imagenURL = datos.Lector["Imagen_URL"].ToString();
                    m.Matricula = (string)datos.Lector["Matricula"];
                    m.Especialidad.Nombre = datos.Lector["Nombre_Especialidad"].ToString();
                    m.Especialidad.Id = (int)datos.Lector["Id_Especialidad"];

                    m.Perfil = new Perfil();
                    m.Perfil.Contraseña = datos.Lector["Contraseña"].ToString();
                    m.Perfil.NombreUsuario = datos.Lector["NombreUsuario"].ToString();

                }

                return m;
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
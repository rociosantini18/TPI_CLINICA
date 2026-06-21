using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;

namespace TPI.Negocio
{
    public class MedicoNegocio
    {

        public List<Medico> listar()
        {
            List<Medico> lista = new List<Medico>();

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT m.Id_Medico, per.Dni, per.Nombre, per.Apellido,
                           per.Email, per.Telefono, per.Direccion, per.FechaNacimiento,
			               m.Matricula, m.Imagen_URL, esp.Id_Especialidad,
                           esp.Id_Especialidad, esp.Nombre_Especialidad, esp.Descripcion
                    FROM Medico m
                    INNER JOIN Persona per ON m.Id_Persona = per.Id_Persona
		            LEFT JOIN Especialidad esp ON m.Id_Especialidad = esp.Id_Especialidad");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();

                    aux.Id = (int)datos.Lector["Id_Medico"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Id = (int)datos.Lector["Id_Especialidad"];
                    aux.Especialidad.Nombre = datos.Lector["Nombre_Especialidad"] as string;
                    aux.Especialidad.Descripcion = datos.Lector["Descripcion"] as string;

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
                datos.setearConsulta("DELETE FROM Medico WHERE Id_Medico = @id");
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
                VALUES (@idPersona, @matricula, @idEspecialidad, @imgURL)");

                datos.setearParametro("@idPersona", idPersona);
                datos.setearParametro("@matricula", med.Matricula);
                datos.setearParametro("@idEspecialidad", med.Especialidad.Id);
                datos.setearParametro("@imgURL", med.imagenURL);


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

        public void modificar(Medico med)
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
                        SELECT Id_Persona FROM Paciente WHERE Id_Medico = @id)");

                datos.setearParametro("@dni", med.Dni);
                datos.setearParametro("@nombre", med.Nombre);
                datos.setearParametro("@apellido", med.Apellido);
                datos.setearParametro("@email", med.Email);
                datos.setearParametro("@telefono", med.Telefono);
                datos.setearParametro("@direccion", med.Direccion);
                datos.setearParametro("@fechaNac", med.FechaNacimiento);
                datos.setearParametro("@id", med.Id);

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
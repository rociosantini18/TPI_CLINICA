using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;

namespace TPI.Negocio
{
    public class EspecialidadNegocio
    {
        public List<Especialidad> listar()
        {
            List<Especialidad> lista = new List<Especialidad>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT Id_Especialidad, Nombre_Especialidad, Descripcion FROM Especialidad WHERE Activo = 1");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Especialidad esp = new Especialidad();
                    esp.Id = (int)datos.Lector["Id_Especialidad"];
                    esp.Nombre = (string)datos.Lector["Nombre_Especialidad"];
                    esp.Descripcion = datos.Lector["Descripcion"] as string;
                    lista.Add(esp);
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void agregar(Especialidad esp)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Especialidad (Nombre_Especialidad, Descripcion)
                    VALUES (@nombre, @descripcion)");
                datos.setearParametro("@nombre", esp.Nombre);
                datos.setearParametro("@descripcion", esp.Descripcion ?? (object)DBNull.Value);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void modificar(Especialidad esp)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    UPDATE Especialidad SET
                        Nombre_Especialidad = @nombre,
                        Descripcion = @descripcion
                    WHERE Id_Especialidad = @id");
                datos.setearParametro("@nombre", esp.Nombre);
                datos.setearParametro("@descripcion", esp.Descripcion ?? (object)DBNull.Value);
                datos.setearParametro("@id", esp.Id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Especialidad SET Activo = 0 WHERE Id_Especialidad = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public List<Medico> listarConMedicosActivos()
        {
            List<Medico> lista = new List<Medico>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    SELECT m.Id_Medico, m.Imagen_URL,
                           e.Id_Especialidad, e.Nombre_Especialidad, e.Descripcion
                    FROM Medico m
                    INNER JOIN Especialidad e ON m.Id_Especialidad = e.Id_Especialidad
                    WHERE m.Activo = 1 AND e.Activo = 1
                    AND m.Id_Medico = (
                        SELECT TOP 1 Id_Medico FROM Medico 
                        WHERE Id_Especialidad = e.Id_Especialidad AND Activo = 1
                    )");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Medico med = new Medico();
                    med.imagenURL = datos.Lector["Imagen_URL"] as string;
                    med.Especialidad = new Especialidad();
                    med.Especialidad.Id = (int)datos.Lector["Id_Especialidad"];
                    med.Especialidad.Nombre = (string)datos.Lector["Nombre_Especialidad"];
                    med.Especialidad.Descripcion = datos.Lector["Descripcion"] as string;
                    lista.Add(med);
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public List<Especialidad> listarInactivas()
        {
            List<Especialidad> lista = new List<Especialidad>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT Id_Especialidad, Nombre_Especialidad, Descripcion FROM Especialidad WHERE Activo = 0");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Especialidad esp = new Especialidad();
                    esp.Id = (int)datos.Lector["Id_Especialidad"];
                    esp.Nombre = (string)datos.Lector["Nombre_Especialidad"];
                    esp.Descripcion = datos.Lector["Descripcion"] as string;
                    lista.Add(esp);
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
                datos.setearConsulta("UPDATE Especialidad SET Activo = 1 WHERE Id_Especialidad = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }
    }
}
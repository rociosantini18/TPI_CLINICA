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
                datos.setearConsulta("SELECT Id_Especialidad, Nombre_Especialidad, Descripcion, Imagen_URL FROM Especialidad");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Especialidad esp = new Especialidad();
                    esp.Id = (int)datos.Lector["Id_Especialidad"];
                    esp.Nombre = (string)datos.Lector["Nombre_Especialidad"];
                    esp.Descripcion = datos.Lector["Descripcion"] as string;
                    if (!(datos.Lector["Imagen_URL"] is DBNull))
                        esp.ImagenURL = (string)datos.Lector["Imagen_URL"];
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
                    INSERT INTO Especialidad (Nombre_Especialidad, Descripcion, Imagen_URL)
                    VALUES (@nombre, @descripcion)");
                datos.setearParametro("@nombre", esp.Nombre);
                datos.setearParametro("@descripcion", esp.Descripcion ?? (object)DBNull.Value);
                datos.setearParametro("@imagenURL", esp.ImagenURL ?? (object)DBNull.Value);
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
                datos.setearConsulta("DELETE FROM Especialidad WHERE Id_Especialidad = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }
    }
}
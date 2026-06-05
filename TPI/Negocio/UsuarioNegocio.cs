using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using TPI.Dominio;
using TPI.Negocio;

namespace TPI.NewFolder1
{
    public class UsuarioNegocio
    {

        public List<Usuario> listar()
        {
            List<Usuario> lista = new List<Usuario>();

            AccesoDatos Datos = new AccesoDatos();

            try
            {
                Datos.setearConsulta(
                    "SELECT U.Id, U.Dni, U.Nombre, U.Apellido, U.Direccion, U.Email, U.Telefono, U.Contrasena, P.Nombre AS Perfil, U.Activo" +
                    " FROM Usuario U" +
                    " INNER JOIN Perfil P" +
                    " ON U.IdPerfil = P.Id" +
                    " ORDER BY U.Id;"

                    );
                Datos.ejecutarLectura();

                Usuario aux = null;
                int ultimoId = -1;

                while (Datos.Lector.Read())
                {
                    int Id = (int)Datos.Lector["Id"];

                    if (Id != ultimoId)
                    {
                        aux = new Usuario();
                        aux.Id = Datos.Lector.GetInt32(0);
                        aux.Dni = (String)Datos.Lector["Dni"];
                        aux.Nombre = (String)Datos.Lector["Nombre"];
                        aux.Apellido = (String)Datos.Lector["Apellido"];
                        aux.Email = (String)Datos.Lector["Email"];
                        aux.Telefono = (String)Datos.Lector["Telefono"];
                        aux.Direccion = (String)Datos.Lector["Direccion"];
                        aux.Contraseña = (String)Datos.Lector["Contrasena"];
                        aux.Activo = (bool)Datos.Lector["Activo"];

                        ultimoId = Id;
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
                Datos.CerrarConexion();
            }

        }



        public void eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM USUARIOS WHERE Id = @id");
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


        public void agregar(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "INSERT INTO USUARIOS (DNI, Nombre, Apellido, Email, Telefono, Direccion, Contraseña, FechaNacimiento, IdPerfil, Activo) " +
                    "OUTPUT INSERTED.Id VALUES (@dni, @nombre, @apellido, @email, @telefono, @direccion, @contraseña, @fechaNacimiento, @idPerfil, @Activo)"
                );
                datos.setearParametro("@dni", usuario.Dni);
                datos.setearParametro("@nombre", usuario.Nombre);
                datos.setearParametro("@apellido", usuario.Apellido);
                datos.setearParametro("@email", usuario.Email);
                datos.setearParametro("@telefono", usuario.Telefono);
                datos.setearParametro("@direccion", usuario.Direccion);
                datos.setearParametro("@contraseña", usuario.Contraseña);
                datos.setearParametro("@nacimiento", usuario.FechaNacimiento);
                datos.setearParametro("@idPerfil", usuario.Perfil.Id);
                datos.setearParametro("@activo", usuario.Activo);

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

        public void modificar(Usuario usuario)
        {

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE USUARIOS set Dni = @dni, Nombre = @nombre, Apellido = @apellido, Email = @email, Telefono = @telefono, Direccion = @direccion, Contraseña = @contraseña, Nacimiento = @nacimiento, IdPerfil = @idperfil, Activo = @activo Where Id =@id");
                datos.setearParametro("@dni", usuario.Dni);
                datos.setearParametro("@nombre", usuario.Nombre);
                datos.setearParametro("@apellido", usuario.Apellido);
                datos.setearParametro("@email", usuario.Email);
                datos.setearParametro("@telefono", usuario.Telefono);
                datos.setearParametro("@direccion", usuario.Direccion);
                datos.setearParametro("@contraseña", usuario.Contraseña);
                datos.setearParametro("@nacimiento", usuario.FechaNacimiento);
                datos.setearParametro("@idPerfil", usuario.Perfil.Id);
                datos.setearParametro("@activo", usuario.Activo);

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
class UserModel {
  var id;
  String user = '';
  String password = '';
  String cedula = '';

  UserModel(
    String id,
    String usuario,
    String contrasena,
    String cedula,
  ) {

    this.id = id;
    this.user = usuario;
    this.password = contrasena;
    this.cedula = cedula;
  }
}
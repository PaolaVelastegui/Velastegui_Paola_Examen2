class sellService {
  final String usuario = '';
  final DateTime fecha = DateTime.now();

  Map<dynamic, dynamic> sellToJson() =>
      <dynamic, dynamic>{'fecha': fecha.toString(), 'usuario': usuario};
}

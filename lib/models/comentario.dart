class Comentario {
  int? id;
  String itemTitulo;
  String titulo;
  String comentario;

  Comentario({this.id, required this.itemTitulo,required this.titulo, required this.comentario});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemTitulo': itemTitulo,
      'titulo': titulo,
      'comentario': comentario,
    };
  }
}
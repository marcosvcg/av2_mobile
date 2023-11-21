import 'package:cardapio/database/database_helper.dart';
import 'package:cardapio/models/comentario.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ComentarioRepository extends ChangeNotifier{
  late Database db;
  List<Comentario> _comentarios = [];

  List<Comentario> get comentarios => _comentarios;


  ComentarioRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getComentarios();
  }

  _getComentarios() async {
    db = await DatabaseHelper.instance.database;
    List comentariosQuery = await db.query('comentarios');
    _comentarios = comentariosQuery.cast();
  }

   insertComentario(Comentario comentario) async {
    db = await DatabaseHelper.instance.database;
    return db.insert('comentarios', comentario.toMap());
  }
}
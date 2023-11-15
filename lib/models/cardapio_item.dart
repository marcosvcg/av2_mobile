import 'package:flutter/material.dart';

class CardapioItem with ChangeNotifier {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemUrl;
  bool isFavorito;

CardapioItem({
  required this.id,
  required this.nome,
  required this.descricao,
  required this.preco,
  required this.imagemUrl,
  this.isFavorito = false,
});

void deixarFavorito() {
    isFavorito = !isFavorito;
    notifyListeners();
  }

  factory CardapioItem.fromJson(Map<String, dynamic> json) {
    return CardapioItem(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      preco: json['preco'],
      imagemUrl: json['imagemUrl'],
    );
  }
}
import 'package:cardapio/models/cardapio_item.dart';
import 'package:cardapio/utils/dados_em_memoria.dart';
import 'package:flutter/material.dart';

class CardapioList with ChangeNotifier {
  final List<CardapioItem> _items = dummyProducts;

  List<CardapioItem> get items => [..._items];
  List<CardapioItem> get favoriteItems => _items.where((item) => item.isFavorito).toList();

  void addProduct(CardapioItem item) {
    _items.add(item);
    notifyListeners();
  }
}
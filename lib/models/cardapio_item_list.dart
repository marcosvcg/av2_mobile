import 'package:cardapio/models/cardapio_item.dart';
import 'package:cardapio/service/api.dart';
import 'package:flutter/material.dart';

class CardapioList with ChangeNotifier {
  List<CardapioItem> _items = [];

  List<CardapioItem> get items => [..._items];
  List<CardapioItem> get favoriteItems => _items.where((item) => item.isFavorito).toList();

  void addProduct(CardapioItem item) {
    _items.add(item);
    notifyListeners();
  }

  Future<void> carregarItensDoJSON() async {
    try {
      _items = await API.getItensCardapio();
      notifyListeners();
    } catch (error) {
      debugPrint('Erro ao carregar itens do JSON: $error');
    }
  }
}
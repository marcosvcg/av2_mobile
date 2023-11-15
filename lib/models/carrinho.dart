import 'dart:math';
import 'package:cardapio/models/cardapio_item.dart';
import 'package:cardapio/models/carrinho_item.dart';
import 'package:flutter/material.dart';

class Carrinho with ChangeNotifier {
  Map<String, CarrinhoItem> _items = {};

  Map<String, CarrinhoItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) { 
      total += cartItem.preco * cartItem.quantidade;
    });
    return total;
  }

  void addItem(CardapioItem product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CarrinhoItem(
          id: existingItem.id,
          itemId: existingItem.itemId,
          nome: existingItem.nome,
          quantidade: existingItem.quantidade + 1,
          preco: existingItem.preco,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CarrinhoItem(
          id: Random().nextDouble().toString(),
          itemId: product.id,
          nome: product.nome,
          quantidade: 1,
          preco: product.preco,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

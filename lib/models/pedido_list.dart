import 'dart:math';
import 'package:cardapio/models/carrinho.dart';
import 'package:cardapio/models/pedido.dart';
import 'package:flutter/material.dart';


class PedidoList with ChangeNotifier {
  final List<Pedido> _items = [];

  List<Pedido> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Carrinho cart) {
    _items.insert(
      0,
      Pedido(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        itens: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

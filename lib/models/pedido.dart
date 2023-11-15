import 'package:cardapio/models/carrinho_item.dart';

class Pedido {
  final String id;
  final double total;
  final List<CarrinhoItem> itens;
  final DateTime date;

  Pedido({
    required this.id,
    required this.total,
    required this.itens,
    required this.date,
  });
}
import 'package:cardapio/models/carrinho.dart';
import 'package:cardapio/models/carrinho_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoItemWidget extends StatelessWidget {
  final CarrinhoItem carrinhoItem;

  const CarrinhoItemWidget({
    super.key,
    required this.carrinhoItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(carrinhoItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (_) {
        Provider.of<Carrinho>(context, listen: false).removeItem(carrinhoItem.itemId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text("${carrinhoItem.preco}"),
                ),
              ),
            ),
            title: Text(carrinhoItem.nome),
            subtitle: Text("Total: R\$ ${carrinhoItem.preco * carrinhoItem.quantidade}"),
            trailing: Text("${carrinhoItem.quantidade}x"),
          ),
        ),
      ),
    );
  }
}

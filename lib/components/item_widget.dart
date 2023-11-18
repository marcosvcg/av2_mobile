import 'package:cardapio/models/cardapio_item.dart';
import 'package:cardapio/models/carrinho.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardapioItemWidget extends StatelessWidget {
  const CardapioItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<CardapioItem>(context, listen: false);
    final carrinho = Provider.of<Carrinho>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<CardapioItem>(
            builder: (ctx, item, _) => IconButton(
              onPressed: () {
                item.deixarFavorito();
              },
              icon: Icon(
                  item.isFavorito ? Icons.favorite : Icons.favorite_border
                ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            item.nome,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              carrinho.addItem(item);
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            item.imagemUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.itemData,
              arguments: item,
            );
          },
        ),
      ),
    );
  }
}

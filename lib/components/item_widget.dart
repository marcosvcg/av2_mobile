import 'package:cardapio/models/cardapio_item.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardapioItemWidget extends StatelessWidget {
  const CardapioItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<CardapioItem>(
      context,
      listen: false,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<CardapioItem>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.deixarFavorito();
              },
              icon: Icon(
                  product.isFavorito ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.nome,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imagemUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.itemData,
              arguments: product,
            );
          },
        ),
      ),
    );
  }
}

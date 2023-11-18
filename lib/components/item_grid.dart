import 'package:cardapio/components/item_widget.dart';
import 'package:cardapio/models/cardapio_item.dart';
import 'package:cardapio/models/cardapio_item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemGrid extends StatelessWidget {
  final bool showFavoritesOnly;

  const ItemGrid(this.showFavoritesOnly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardapioList>(context);

    if (provider.items.isEmpty) {
      provider.carregarItensDoJSON();
    }

    final List<CardapioItem> loadedProducts =
        showFavoritesOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider<CardapioItem>.value(
        value: loadedProducts[index],
        child: CardapioItemWidget(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}

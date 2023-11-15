import 'package:cardapio/components/app_drawer.dart';
import 'package:cardapio/components/contador_de_itens.dart';
import 'package:cardapio/components/item_grid.dart';
import 'package:cardapio/models/carrinho.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favoritesOnly,
  allItems,
}

class CardapioScreen extends StatefulWidget {
  const CardapioScreen({super.key});

  @override
  State<CardapioScreen> createState() => _CardapioScreenState();
}

class _CardapioScreenState extends State<CardapioScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurante do Marcao'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favoritesOnly,
                child: Text('Mostrar Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.allItems,
                child: Text('Mostrar Tudo'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favoritesOnly) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
          ),
          Consumer<Carrinho>(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.carrinho);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            builder: (ctx, cart, child) => ItemCounter(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ItemGrid(_showFavoritesOnly),
      drawer: const AppDrawer(), 
    );
  }
}

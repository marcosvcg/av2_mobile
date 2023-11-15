import 'package:cardapio/components/app_drawer.dart';
import 'package:cardapio/components/carrinho_item_widget.dart';
import 'package:cardapio/models/carrinho.dart';
import 'package:cardapio/models/pedido_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoScreen extends StatelessWidget {
  const CarrinhoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Carrinho carrinho = Provider.of(context);
    final items = carrinho.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      "R\$${carrinho.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .headlineSmall
                            ?.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<PedidoList>(context, listen: false,).addOrder(carrinho);
                      carrinho.clear();
                    },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: const Text("PEDIR"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) => CarrinhoItemWidget(carrinhoItem: items[index]),
            ),
          ),
        ],
      ),
    );
  }
}

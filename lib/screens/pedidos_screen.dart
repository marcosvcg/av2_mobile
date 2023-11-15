import 'package:cardapio/components/app_drawer.dart';
import 'package:cardapio/components/pedido_widget.dart';
import 'package:cardapio/models/pedido_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidoScreen extends StatelessWidget {
  const PedidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PedidoList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Pedido'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, index) => PedidoWidget(pedido: orders.items[index]),
      ),
    );
  }
}

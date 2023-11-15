import 'package:cardapio/models/cardapio_item.dart';
import 'package:flutter/material.dart';

class ItemDataScreen extends StatelessWidget {
  const ItemDataScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CardapioItem item =
        ModalRoute.of(context)!.settings.arguments as CardapioItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.nome),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                item.imagemUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'R\$ ${item.preco}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                item.descricao,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

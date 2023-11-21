import 'package:cardapio/models/cardapio_item_list.dart';
import 'package:cardapio/models/carrinho.dart';
import 'package:cardapio/models/pedido_list.dart';
import 'package:cardapio/repositories/comentario_repository.dart';
import 'package:cardapio/screens/cardapio_screen.dart';
import 'package:cardapio/screens/carrinho_screen.dart';
import 'package:cardapio/screens/comentarios_do_item.dart';
import 'package:cardapio/screens/detalhes_do_item.dart';
import 'package:cardapio/screens/pedidos_screen.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const CardapioApp());
}

class CardapioApp extends StatelessWidget {
  const CardapioApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(
          create: (_) => ComentarioRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => CardapioList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Carrinho(),
        ),
        ChangeNotifierProvider(
          create: (_) => PedidoList(),
        ),
      ],
      child: MaterialApp(
        title: 'Cardapio Interativo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.blue.shade900,
            secondary: Colors.red,
          ),
        ),
        routes: {
          AppRoutes.home: (context) => const CardapioScreen(),
          AppRoutes.itemData: (context) => const ItemDataScreen(),
          AppRoutes.carrinho: (context) => const CarrinhoScreen(),
          AppRoutes.pedidos: (context) => const PedidoScreen(),
          AppRoutes.itemComentarios: (context) => const ComentarioItemScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

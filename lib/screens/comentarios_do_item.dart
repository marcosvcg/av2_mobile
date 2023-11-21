import 'package:cardapio/repositories/comentario_repository.dart';
import 'package:flutter/material.dart';
import 'package:cardapio/models/cardapio_item.dart';
import 'package:cardapio/models/comentario.dart';
import 'package:cardapio/database/database_helper.dart';
import 'package:provider/provider.dart';

class ComentarioItemScreen extends StatefulWidget {
  const ComentarioItemScreen({Key? key}) : super(key: key);

  @override
  ComentarioItemScreenState createState() => ComentarioItemScreenState();
}

class ComentarioItemScreenState extends State<ComentarioItemScreen> {
  final TextEditingController _comentarioController = TextEditingController();
  final TextEditingController _tituloController = TextEditingController();
  List<Comentario> _comentarios = [];
  late CardapioItem _item;


  @override
  void initState() {
    super.initState();
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _item = ModalRoute.of(context)!.settings.arguments as CardapioItem;
    _carregarComentarios(_item.nome);
  }
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título do Comentário',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _comentarioController,
                decoration: const InputDecoration(
                  labelText: 'Adicione um Comentário',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _salvarComentario(item.nome, context);
              },
              child: const Text('Salvar Comentário'),
            ),
            
            const SizedBox(height: 20),
            const Text(
              'Comentários Salvos:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildComentariosList(),
          ],
        ),
      ),
    );
  }

Widget _buildComentariosList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _comentarios.map((comentario) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8), 
              child: Text(
                comentario.titulo,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 8), 
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    comentario.comentario,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}





  void _salvarComentario(String itemTitulo, BuildContext context) async {
    final tituloTexto = _tituloController.text;
    final comentarioTexto = _comentarioController.text;
    final comentarioRepository = Provider.of<ComentarioRepository>(context, listen: false);
    if (tituloTexto.isNotEmpty && comentarioTexto.isNotEmpty) {
      final comentario = Comentario(
        itemTitulo: itemTitulo,
        titulo: tituloTexto,
        comentario: comentarioTexto,
      );
     
      
      comentarioRepository.insertComentario(comentario);

      _tituloController.clear();
      _comentarioController.clear();
      _carregarComentarios(itemTitulo);
    }
  }

  void _carregarComentarios(String itemTitulo) async {
    final dbHelper = DatabaseHelper.instance;
    final comentarios = await dbHelper.getComentarios(itemTitulo);
    
    setState(() {
      _comentarios = comentarios;
    });
  }
}

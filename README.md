# AVII
# Cardápio


## Instruções de instalação do Flutter:
<br/>

1º - Instalar o Flutter
https://docs.flutter.dev/get-started/install

2º - Extrair o arquivo e procurar por "flutter_console.bat"

3º - Executar o comando "flutter doctor"

4º - Executar o comando "flutter create seu_aplicativo", substituindo "seu_aplicativo" pelo nome que você desejar

![PASSO2](https://cdn.discordapp.com/attachments/1164355843140091905/1176579411638747226/passo-2.png?ex=656f61f7&is=655cecf7&hm=a6c32ea19b44180a156687c59d97b4fc2ee0513858df250f2a116215e6aa4ba4&)
<br/>
<br/>
![PASSO3](https://cdn.discordapp.com/attachments/1164355843140091905/1176579411953336392/passo-3.png?ex=656f61f7&is=655cecf7&hm=3adb23c4b3fc92a6c26a7a5b3d09063be9c95bc92af672a5a672b7ec2f634901&)
<br/>

 

## Desenvolvimento do Projeto

Começamos o projeto fazendo a modelagem da classe CardapioItem e seguimos implementando o resto.
<br/>

```dart
class CardapioItem with ChangeNotifier {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemUrl;
  bool isFavorito;

CardapioItem({
  required this.id,
  required this.nome,
  required this.descricao,
  required this.preco,
  required this.imagemUrl,
  this.isFavorito = false,
});

void deixarFavorito() {
    isFavorito = !isFavorito;
    notifyListeners();
  }

class Carrinho with ChangeNotifier {
  Map<String, CarrinhoItem> _items = {};

  Map<String, CarrinhoItem> get items {
    return {..._items};
  }

...
```

</br>

Com isso, seguimos para a lógica de filtrar os itens favoritos:

classe CardapioList: 

```dart
 List<CardapioItem> get favoriteItems => _items.where((item) => item.isFavorito).toList();
```

</br>

classe ItemGrid:

```dart
final List<CardapioItem> loadedProducts =
        showFavoritesOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider<CardapioItem>.value(
        value: loadedProducts[index],
        child: CardapioItemWidget(),
      )
```

</br>

A seguir, demos upload de um JSON em um repositório público no Github (https://github.com/marcosvcg/av2_mobile_jsons) e pegamos os dados via requisição HTTP.

```dart
Future<void> carregarItensDoJSON() async {
    try {
      _items = await API.getItensCardapio();
      notifyListeners();
    } catch (error) {
      debugPrint('Erro ao carregar itens do JSON: $error');
    }
  }
```

</br>

E por fim, fizemos a parte dos comentários via persistência local utilizando a biblioteca SQFLite (https://github.com/marcosvcg/av2_mobile_jsons):

```dart
Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        itemTitulo TEXT,
        titulo TEXT,
        comentario TEXT
      )
    ''');
  }

  Future<List<Comentario>> getComentarios(String itemTitulo) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'itemTitulo = ?',
      whereArgs: [itemTitulo],
    );
    return List.generate(maps.length, (i) {
      return Comentario(
        id: maps[i]['id'],
        itemTitulo: maps[i]['itemTitulo'],
        titulo: maps[i]['titulo'],
        comentario: maps[i]['comentario'],
      );
    });
  }
```



# Tela do aplicativo 

Tela Inicial
<br/>
![TelaInicial](https://cdn.discordapp.com/attachments/1164355843140091905/1176667412758790174/tela-inicial.png?ex=656fb3ec&is=655d3eec&hm=71fc62676d1c3769ec6f438368eeff8edc39caefd2cf0143a8d42175bd7d873d&)
<br/>
<br/>
Menu Opções
<br/>
![OpcoesMenu](https://cdn.discordapp.com/attachments/1164355843140091905/1176667413962555433/mostrar-favoritos-1.png?ex=656fb3ec&is=655d3eec&hm=e4f3f4d575a36e2d1864c26122dc8bf92796a5eaa0ac6b0aa7138920eceebe1f&)
<br/>
<br/>
Favoritos
<br/>
![Favoritos](https://cdn.discordapp.com/attachments/1164355843140091905/1176667414503624704/mostrar-favoritos-2.png?ex=656fb3ed&is=655d3eed&hm=06a28ca1cc3b495caea3f2f053fc2fcc9fbb8754a38782566b3ccc7ef816fb06&)
<br/>
<br/>
Tela do item escolhido
<br/>
![TelaItem](https://cdn.discordapp.com/attachments/1164355843140091905/1176667413211779102/tela-item.png?ex=656fb3ec&is=655d3eec&hm=6d589bccd4d101769a5ec0acb333607a6dec59176dea1c3105ef1426c23b663d&)
<br/>
<br/>
Tela do comentário
<br/>
![TelaComentario](https://cdn.discordapp.com/attachments/1164355843140091905/1176667412125450282/tela-comentarios-1.png?ex=656fb3ec&is=655d3eec&hm=16455283214bc416e977e6a20c0ff3b817d80f255a4f3d9e2f1ee1ffd8cc9d1d&)
<br/>
<br/>
Tela com comentários
<br/>
![TelaComentarios](https://cdn.discordapp.com/attachments/1164355843140091905/1176667412414861332/tela-comentarios-2.png?ex=656fb3ec&is=655d3eec&hm=6e60afbd76621295bbdf86f53d653a7b8a924897b59c7466121ccd7058eb7548&)
<br/>
<br/>
Tela do carrinho
<br/>
![TelaCarrinho](https://cdn.discordapp.com/attachments/1164355843140091905/1176667411886395413/tela-carrinho.png?ex=656fb3ec&is=655d3eec&hm=0b9e81a7171cd9b4962465761b1eae612c7d3db9cef87095b9dba92339e3a0ba&)
<br/>
<br/>
Tela do pedido
<br/>
![TelaPedido](https://cdn.discordapp.com/attachments/1164355843140091905/1176667413501202462/tela-pedidos.png?ex=656fb3ec&is=655d3eec&hm=a3b907774197e2b14f9e861c16a415a32991961007ec6f81ae512c6e856066fd&)
<br/>




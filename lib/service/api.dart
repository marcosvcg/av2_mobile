import 'dart:convert';

import 'package:cardapio/models/cardapio_item.dart';
import 'package:http/http.dart' as http;

const urlBase = "https://raw.githubusercontent.com/";

class API {
  static Future<List<CardapioItem>> getItensCardapio() async {
    var url = "${urlBase}marcosvcg/av2_mobile_jsons/main/itens_cardapio.json";
    final response = await http.get(Uri.parse(url));
    
    if(response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<CardapioItem> itensCardapio = jsonList.map((json) => CardapioItem.fromJson(json)).toList();
      return itensCardapio;
    } else {
      throw Exception('Falha ao carregar os dados.');
    }
  }
}
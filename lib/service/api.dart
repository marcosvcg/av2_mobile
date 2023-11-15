import 'package:http/http.dart' as http;

const urlBase = "https://raw.githubusercontent.com/";

class API {
  static Future getItensCardapio() async {
    var url = urlBase + "marcosvcg/av2_mobile_jsons/main/itens_cardapio.json";
    return await http.get(url);
  }
}
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

import '../utils/utils.dart';
import 'url.dart';

class PokemonService {
  final Client client;
  final String _url = Environment.getEnvironment();
  final int timeout = Environment.timeout();

  PokemonService(this.client);

  Future<http.Response> getPokemon(int pokemonId) async {
    final url = Uri.https(_url, '${PokemonURL.pokemonUrl}/$pokemonId');

    return await client.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
    }).timeout(Duration(seconds: timeout),
        onTimeout: () => http.Response('TIME OUT', 500));
  }
}

import 'package:get/get.dart';

import '../model/pokemon.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  var connectivity = false.obs;
  var pokemonId = 1.obs;
  var maxPokemonList = 15.obs;
  RxList<Pokemon> pokemonList = RxList<Pokemon>();

  void showLoader(bool loading) {
    this.loading.value = loading;
  }

  void showConnectivity(bool connectivity) {
    this.connectivity.value = connectivity;
  }

  void setId(int pokemonId) {
    this.pokemonId.value = pokemonId;
  }

  void addPokemonList(RxList<Pokemon> pokemonList) {
    this.pokemonList.addAll(pokemonList);
  }

  void setMaxPokemonList(int maxPokemonList) {
    this.maxPokemonList.value = maxPokemonList;
  }
}

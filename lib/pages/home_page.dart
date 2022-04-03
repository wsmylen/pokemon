import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/home_controller.dart';
import '../model/pokemon.dart';
import '../providers/pokemon_service.dart';
import '../utils/functions.dart';
import '../utils/utils.dart';
import '../widgets/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements BasePokemon {
  final HomeController homeController = Get.put(HomeController());
  final ScrollController scrollController = ScrollController();
  final int maxItem = 15;

  @override
  void initState() {
    super.initState();

    getPokemon(context, homeController);

    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        getPokemon(context, homeController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Stack(
              children: [
                _PokemonList(
                  homeController: homeController,
                  scrollController: scrollController,
                ),
                if (homeController.connectivity.value)
                  ErrorStateWidget(onPressed: () {
                    if (homeController.pokemonList.length > 1) {
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn);
                    }

                    getPokemon(context, homeController);
                  })
              ],
            )));
  }

  @override
  void getPokemon(BuildContext context, HomeController homeController) async {
    if (await Utils.connectivityResult()) {
      RxList<Pokemon> pokemonList = RxList<Pokemon>();

      homeController.showLoader(true);

      for (var i = homeController.pokemonId.value;
          i <= homeController.maxPokemonList.value;
          i++) {
        if (homeController.pokemonId.value <= 999) {
          homeController.showConnectivity(false);

          PokemonService pokemonService = PokemonService(http.Client());

          http.Response response =
              await pokemonService.getPokemon(homeController.pokemonId.value);

          if (response.statusCode == 200) {
            pokemonList.add(
                Pokemon.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));

            homeController.setId(homeController.pokemonId.value + 1);
          }
        }
      }

      homeController.showLoader(false);

      homeController
          .setMaxPokemonList(homeController.maxPokemonList.value + maxItem);
      homeController.addPokemonList(pokemonList);
    } else {
      homeController.showConnectivity(true);
    }
  }
}

class _PokemonList extends StatelessWidget {
  final HomeController homeController;
  final ScrollController scrollController;

  const _PokemonList(
      {Key? key, required this.homeController, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  physics: homeController.loading.value
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: homeController.pokemonList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == homeController.pokemonList.length) {
                      return SizedBox(
                        height: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (homeController.pokemonList.length > 1)
                              Icon(
                                Icons.arrow_downward,
                                color: UIColors.colorGrayText(),
                              ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            if (homeController.pokemonList.length > 1)
                              Text(HomeStrings.loadMore,
                                  style: TextStyle(
                                      color: UIColors.colorGrayText(),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500)),
                          ],
                        ),
                      );
                    } else {
                      return CardPokemonWidget(
                          name: homeController.pokemonList[index].name!,
                          number:
                              '#${Utils.padStart(homeController.pokemonList[index].id!)}',
                          image: homeController
                              .pokemonList[index].sprites!.frontDefault!);
                    }
                  }),
            )),
        Obx(() => homeController.loading.value
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 85.0,
                      height: 60.0,
                      child: ImageAssetWidget(
                        asset: UIAssets.loading,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(HomeStrings.loading,
                        style: TextStyle(
                            color: UIColors.colorGrayText(),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              )
            : Container())
      ],
    );
  }
}

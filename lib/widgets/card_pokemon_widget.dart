import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'widget.dart';

class CardPokemonWidget extends StatelessWidget {
  final String name;
  final String number;
  final String image;

  const CardPokemonWidget(
      {Key? key, required this.name, required this.number, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: SizedBox(
        height: 90,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: UIColors.colorBackground(),
          child: Stack(
            children: [
              const ImageAssetWidget(asset: UIAssets.ball, fit: BoxFit.contain),
              Container(
                alignment: const Alignment(0.9, 2.2),
                child: SizedBox(
                  width: 150,
                  height: 60,
                  child: Center(
                    child: Text(
                      number,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.25),
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 85,
                    height: 85,
                    child: FadeInImage(
                        placeholder: const AssetImage(UIAssets.loading),
                        image: NetworkImage(image),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const ImageAssetWidget(
                            asset: UIAssets.loading,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          );
                        },
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

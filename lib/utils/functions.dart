import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

abstract class BasePokemon {
  void getPokemon(BuildContext context, HomeController homeController);
}

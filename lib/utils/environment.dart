import 'package:flutter/foundation.dart';

class Environment {
  static int timeout() {
    return 60;
  }

  static String getEnvironment() {
    if (kReleaseMode) {
      return 'pokeapi.co';
    } else {
      return 'pokeapi.co';
    }
  }
}

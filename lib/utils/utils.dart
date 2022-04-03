import 'package:connectivity_plus/connectivity_plus.dart';

export 'package:pokemon/utils/environment.dart';
export 'package:pokemon/utils/home_strings.dart';
export 'package:pokemon/utils/ui_asset.dart';
export 'package:pokemon/utils/ui_colors.dart';

class Utils {
  static Future<bool> connectivityResult() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static String padStart(int number) {
    int length = number.toString().length;

    if (length == 1) {
      return '00$number';
    } else if (length == 2) {
      return '0$number';
    } else {
      return '$number';
    }
  }
}

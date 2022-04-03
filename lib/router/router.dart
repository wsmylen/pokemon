import 'package:get/get.dart';

import '../pages/home_page.dart';

final List<GetPage<dynamic>>? getPages = [
  GetPage(name: '/home', page: () => const HomePage())
];

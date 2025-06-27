import 'package:get/get.dart';
import 'package:memmoapp/pages/home_page.dart';
import 'package:memmoapp/pages/memo_page.dart';

class Routes {
  static String homePage = '/home_page';
  static String memoPage = '/memo_page';
}

final getPages = [
  GetPage(
    name: Routes.homePage,
    page: () => const HomePage(),
  ),
  GetPage(
    name: Routes.memoPage,
    page: () => const MemoPage(),
  ),
];

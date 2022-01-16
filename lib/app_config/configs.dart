import 'package:countriesdemo/pages/home/binding/home_binding.dart';
import 'package:countriesdemo/pages/home/ui/favorite_page.dart';
import 'package:countriesdemo/pages/home/ui/home_page.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/';
  static const favorite = '/favorite';
}

class Pages {
  static List<GetPage> allPages = [
    GetPage(name: Routes.home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
      name: Routes.favorite,
      page: () => FavoritePage(),
    ),
  ];
}

class API {
  static const countriesApi = 'https://api.first.org/data/v1/countries';
}

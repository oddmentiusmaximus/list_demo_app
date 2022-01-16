import 'package:countriesdemo/model/country_model.dart';
import 'package:countriesdemo/pages/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeRepository repository = HomeRepository();
  List<Country> countryList = <Country>[].obs;
  Set dbKey = {};
  bool isLoading = false;
  int pageLimit = 10;

  @override
  void onInit() {
    super.onInit();
    getCountries();
    getAllFavList();
    scrollController.addListener(pagination);
  }

  ScrollController scrollController = ScrollController();

  Future<void> pagination() async {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (pageLimit < countryList.length)) {
      isLoading = true;
      pageLimit += 10;
      Get.dialog(const SizedBox(
          height: 50,
          width: 50,
          child: Center(child: CircularProgressIndicator())));
      await Future.delayed(const Duration(seconds: 2));
      Get.back();

      update();
    }
    Get.log(pageLimit.toString());
  }

  getCountries() async {
    var res = await repository.getAllCountries();
    if (res.toString() != 'null') {
      res.data?.forEach((element) {
        countryList.add(element);
      });
    }
    update();
  }

  addToFav(Country country) async {
    await repository.addCountriesDb(country);
    getAllFavList();
  }

  deleteFromFav(key) async {
    await repository.deleteCountriesDb(key);
    getAllFavList();
  }

  getAllFavList() async {
    List res = await repository.getCountriesDb();
    dbKey.clear();
    for (var element in res) {
      dbKey.add(element['key']);
    }
    update();
    return res;
  }
}

import 'package:countriesdemo/app_config/configs.dart';
import 'package:countriesdemo/model/country_model.dart';
import 'package:countriesdemo/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Countries'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.favorite);
              },
              icon: const Icon(Icons.favorite_border_rounded))
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext context, ConnectivityResult value, Widget child) {
          final bool connected = value != ConnectivityResult.none;

          return connected
              ? child
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: Icon(
                        Icons.wifi_off,
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Please check your network connectivity")
                  ],
                );
        },
        child: GetBuilder<HomeController>(builder: (homeController) {
          return Column(
            children: [
              Expanded(
                  child: Visibility(
                visible: homeController.countryList.isNotEmpty,
                replacement: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: const Center(child: CircularProgressIndicator())),
                child: ListView.separated(
                  controller: homeController.scrollController,
                  itemCount: homeController.pageLimit,
                  itemBuilder: (BuildContext context, int index) {
                    Country element = homeController.countryList[index];
                    bool isFav = homeController.dbKey.contains(element.key);
                    return countryElement(element, isFav);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              )),
            ],
          );
        }),
      ),
    );
  }

  Widget countryElement(Country element, bool isFav) {
    String country = element.country ?? '';
    String region = element.region ?? '';
    String key = element.key ?? '';
    return ListTile(
      leading: Text(key),
      title: Text(country),
      subtitle: Text(region),
      trailing: IconButton(
          onPressed: () {
            if (!isFav) {
              homeController.addToFav(element);
            } else {
              homeController.deleteFromFav(element.key);
            }
          },
          icon: Icon(
            Icons.favorite,
            color: isFav ? Colors.red : null,
          )),
    );
  }
}

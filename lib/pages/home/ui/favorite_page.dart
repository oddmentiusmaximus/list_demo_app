import 'package:countriesdemo/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Countries'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: homeController.getAllFavList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List data = snapshot.data ?? [];
          return ListView.builder(
            itemCount: data.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return countryElement(data[index]['key'] ?? '',
                  data[index]['country'] ?? '', data[index]['region'] ?? '');
            },
          );
        },
      ),
    );
  }

  Widget countryElement(String key, String country, String region) {
    return Column(
      children: [
        ListTile(
          leading: Text(key),
          title: Text(country),
          subtitle: Text(region),
        ),
        const Divider()
      ],
    );
  }
}

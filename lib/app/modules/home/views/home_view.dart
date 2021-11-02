import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_locais_app/app/modules/home/controllers/home_controller.dart';
import 'package:meus_locais_app/app/modules/maps/views/maps_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google maps Markers'),
        //
        centerTitle: true,
      ),
      body: Center(child: MapsView()),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: (controller.initialPage == 0)
                      ? MaterialStateProperty.all<Color>(Colors.green.shade900)
                      : null,
                ),
                onPressed: () {
                  controller.changePage(0);
                },
                icon: const Icon(Icons.map_sharp),
                label: const Text('Regular Markers'),
              ),
            ),
            Obx(
              () => ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: (controller.initialPage == 1)
                      ? MaterialStateProperty.all<Color>(Colors.green.shade900)
                      : null,
                ),
                onPressed: () {
                  controller.changePage(1);
                },
                icon: const Icon(Icons.map_sharp),
                label: const Text('Custom Markers'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

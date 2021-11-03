// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:meus_locais_app/app/modules/maps/views/maps_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MapsView(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.pin_drop),
          onPressed: () async {
            await controller.addMarkerCurrentLocation();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Row(
          children: [
            IconButton(
              onPressed: () {
                controller.removeAllMarkers();
              },
              icon: Icon(
                Icons.delete,
                size: 40,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

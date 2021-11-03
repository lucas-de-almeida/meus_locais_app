// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:meus_locais_app/app/data/repository/home_repository.dart';
import 'package:meus_locais_app/app/modules/maps/controllers/maps_controller.dart';

class HomeController extends GetxController {
  MapsController mapsController = Get.find<MapsController>();
  final HomeRepoisotry repository;

  HomeController(this.repository);
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> addMarkerCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      mapsController.userLocation = position;
      mapsController
          .addNewPosition(LatLng(position.latitude, position.longitude));
    } on Exception catch (_) {}
  }

  void removeAllMarkers() async {
    bool? remove = await Get.defaultDialog(
      title: "Remove all markers",
      content: Text(
        "Are you sure you want to delete all markers?",
      ),
      confirm: OutlinedButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text("Yes!")),
      cancel: OutlinedButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text("No!")),
    );

    if (remove != false && remove != null) {
      mapsController.clearAllMarkers();
    }
  }
}

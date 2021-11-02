// ignore_for_file: unused_import, unnecessary_this

import 'package:get/get.dart';
import 'package:meus_locais_app/app/data/model/map_type.dart';
import 'package:meus_locais_app/app/modules/maps/controller.dart/maps_controller.dart';
import 'package:meus_locais_app/app/modules/home/controllers/home_controller.dart';

class HomeController extends GetxController {
  final _initialPage = 0.obs;
  final _mapController = Get.find<MapsController>();

  int get initialPage => this._initialPage.value;

  @override
  void onInit() {
    super.onInit();
    _mapController.setInitialPosition(-23.5649267, -46.6519566);

    ever(_initialPage, (_page) {
      if (_page == 0) {
        _mapController.getMarkers(type: MyMapTyes.regular);
      } else {
        _mapController.getMarkers(type: MyMapTyes.custom);
      }
    });
  }

  @override
  void onClose() {}
  changePage(int page) {
    _initialPage.value = page;
  }
}

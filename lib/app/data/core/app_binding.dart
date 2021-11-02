import 'package:get/get.dart';
import 'package:meus_locais_app/app/data/repository/maps_repository.dart';

import 'package:meus_locais_app/app/modules/maps/controller.dart/maps_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsRepository>(() => MapsRepository());
    Get.lazyPut<MapsController>(
        () => MapsController(Get.find<MapsRepository>()));
  }
}

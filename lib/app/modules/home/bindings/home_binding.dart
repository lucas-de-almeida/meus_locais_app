import 'package:get/get.dart';

import 'package:meus_locais_app/app/data/repository/home_repository.dart';
import 'package:meus_locais_app/app/modules/maps/bindings/maps_binding.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepoisotry());

    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<HomeRepoisotry>()),
    );
    MapsBinding().dependencies();
  }
}

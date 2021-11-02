import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meus_locais_app/app/modules/maps/controller/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Obx(
        () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: controller.initialPositionMap,
            zoom: 2,
          ),
          zoomControlsEnabled: true,
          markers: controller.markers,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          buildingsEnabled: false,
        ),
      ),
    );
  }
}

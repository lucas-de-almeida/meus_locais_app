import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meus_locais_app/app/core/loading_widget.dart';
import 'package:meus_locais_app/app/modules/maps/controllers/maps_controller.dart';

import 'package:meus_locais_app/app/modules/maps/views/components/new_location_controller.dart';
import 'package:validatorless/validatorless.dart';

class NewLocationPage extends GetView<NewLocationController> {
  final LatLng position;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lgnController = TextEditingController();
  String? dataVisita;
  DateTime dataBase = DateTime.now();

  final TextEditingController locationDescriptionController =
      TextEditingController();

  NewLocationPage(
    this.position, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    latController.text = '${position.latitude}';
    lgnController.text = '${position.longitude}';
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Insert your location",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Latitude:',
                      ),
                      controller: latController,
                      validator:
                          Validatorless.required('You must need add a value '),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: lgnController,
                      decoration: InputDecoration(
                        labelText: 'Longitude:',
                      ),
                      validator:
                          Validatorless.required('You must need add a value '),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: TextFormField(
                  controller: locationNameController,
                  decoration: InputDecoration(labelText: 'Location:'),
                  validator: Validatorless.required(
                      'You need at least name the location'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 20),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  // focusNode: _focus,
                  controller: locationDescriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      labelText: 'Description'),
                ),
              ),
              InkWell(
                onTap: () async {
                  String _source = await Get.defaultDialog(
                    title: "Choose your source",
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("Camera"),
                          onPressed: () {
                            Get.back(result: 'camera');
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.indigo),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.orange),
                          ),
                          child: Text("Gallery"),
                          onPressed: () {
                            Get.back(result: 'gallery');
                          },
                        ),
                      ],
                    ),
                  );
                  late PickedFile? _picked;
                  try {
                    Get.dialog(LoadingWidget());
                    if (_source == 'camera') {
                      _picked = (await ImagePicker().getImage(
                          source: ImageSource.camera,
                          preferredCameraDevice: CameraDevice.front));
                    } else {
                      _picked = (await ImagePicker()
                          .getImage(source: ImageSource.gallery));
                    }
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                  Get.close(0);
                  controller.previewFile = _picked;
                },
                child: Obx(() => (controller.imageByte != null)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Image.memory(
                          controller.imageByte!,
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 150,
                            color: Colors.grey.shade200,
                            child: Center(child: Text("TAP TO INSERT IMAGE"))),
                      )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool _saved = await controller.saveMarker(
                                  locationNameController.text,
                                  locationDescriptionController.text,
                                  double.tryParse(latController.text) ?? 0,
                                  double.tryParse(lgnController.text) ?? 0,
                                  dataVisita = DateFormat("dd/MM/yyyy")
                                      .format(dataBase));
                              print(latController.text);
                              print(lgnController.text);
                              if (_saved) {
                                Get.find<MapsController>().getMarkers();
                              }
                              Get.close(0);
                            }
                          },
                          child: Text("Save location")),
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back(result: false);
                          Get.delete<NewLocationController>();
                        },
                        child: Text("Cancel"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red.shade400),
                        ),
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

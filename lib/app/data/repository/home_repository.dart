// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meus_locais_app/app/core/consts.dart';

class HomeRepoisotry extends GetConnect {
  Future<List<Prediction>> findAddress(String endereco,
      {String language = 'en'}) async {
    final places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_KEY);
    var response = await places.autocomplete(endereco, language: language);
    return response.predictions;
  }

  Future<PlacesDetailsResponse> getGooglePlacesDetail(String placeId) async {
    final places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_KEY);
    return await places.getDetailsByPlaceId(placeId);
  }
}

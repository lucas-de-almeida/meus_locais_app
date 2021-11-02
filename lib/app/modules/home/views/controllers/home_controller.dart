// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

class HomeController extends GetxController {
  final _initialPage = 0.obs;
  int get initialPage => this._initialPage.value;

  changePage(int page) {
    _initialPage.value = page;
  }
}

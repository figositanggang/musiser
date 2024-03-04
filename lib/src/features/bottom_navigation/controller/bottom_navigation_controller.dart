import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final RxInt _index = 0.obs;
  int get index => _index.value;
  void setIndex(int value) {
    _index.value = value;
  }
}

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  final RxBool _secure = true.obs;
  bool get secure => _secure.value;
  void setSecure(bool value) {
    _secure.value = value;
  }
}

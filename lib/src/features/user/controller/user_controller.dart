import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:musiser/src/features/user/model/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel(
    id: "",
    email: "",
    username: "",
    fullName: "",
  ).obs;
  UserModel get user => _userModel.value;
  void setUserModel(UserModel value) {
    _userModel.value = value;
  }
}

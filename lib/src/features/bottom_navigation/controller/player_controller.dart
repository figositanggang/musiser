import 'package:get/get.dart';

class AudioPlayerController extends GetxController {
  final RxBool _isPlaying = false.obs;
  bool get isPlaying => _isPlaying.value;
  void setIsPlaying(bool value) {
    _isPlaying.value = value;
  }

  final RxBool _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;
  void setIsLoaded(bool value) {
    _isLoaded.value = value;
  }

  final RxDouble _seconds = 0.0.obs;
  double get seconds => _seconds.value;
  void setSeconds(double value) {
    _seconds.value = value;
  }

  final RxString _url = "".obs;
  String get url => _url.value;
  void setUrl(String value) {
    _url.value = value;
  }
}

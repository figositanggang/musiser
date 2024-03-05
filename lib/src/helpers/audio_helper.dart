import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  static final player = AudioPlayer();

  // ! Play
  static Future<bool> playAudio(String url) async {
    try {
      await player.setSourceUrl(url);

      await player.play(player.source!);

      return true;
    } catch (e) {
      return false;
    }
  }

  // ! Stop
  static Future<bool> stopAudio(String url) async {
    try {
      await player.stop();
      return true;
    } catch (e) {
      return false;
    }
  }

  // ! Resume or Pause
  static Future<String> resumeOrPause() async {
    if (player.state == PlayerState.playing) {
      await player.pause();

      return "pause";
    } else {
      await player.resume();

      return "resume";
    }
  }
}

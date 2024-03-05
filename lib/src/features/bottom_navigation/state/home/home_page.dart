import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ionicons/ionicons.dart';
import 'package:musiser/src/features/bottom_navigation/controller/player_controller.dart';
import 'package:musiser/src/features/user/controller/user_controller.dart';
import 'package:musiser/src/helpers/audio_helper.dart';
import 'package:musiser/src/utils/custom_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userGet = Get.put(UserController());
  final playerGet = Get.put(AudioPlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // @ App Bar
          SliverAppBar(
            snap: true,
            floating: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: const Text("Musiser"),
            actions: [
              InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1709580355~exp=1709580955~hmac=54d4f1e25e629519bb9b20806a02f63edf52f8d491fa0e47c8275b2eebe43502"),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(10, (index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        play();
                      },
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(.25),
                              BlendMode.darken,
                            ),
                            image: const NetworkImage(
                                "https://www.theweeknd.com/files/2023/06/THE-IDOL-SINGLE-PACK-COVER-EP-2-FINAL-EXPLICIT.jpg"),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      title:
                          const MyText("Starboy", fontWeight: FontWeight.w600),
                      subtitle: MyText(
                        "Unlinked",
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(.75),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            print("ISLOADED: ${playerGet.isLoaded}");
                          },
                          icon: const Icon(Ionicons.ellipsis_vertical)),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void play() async {
    bool isPlayed = await AudioHelper.playAudio(
        "https://drive.google.com/uc?export=download&id=1bSaWr1UBNx_m5dh1bibNyUdLscjt7XcJ");

    playerGet.setIsLoaded(isPlayed);
    playerGet.setIsPlaying(isPlayed);
    playerGet.setUrl(
        "https://drive.google.com/uc?export=download&id=1bSaWr1UBNx_m5dh1bibNyUdLscjt7XcJ");

    final _player = AudioHelper.player;
    Duration? duration = await _player.getDuration();

    if (duration != null) {
      _player.onPositionChanged.listen((event) {
        playerGet.setSeconds(event.inSeconds / duration.inSeconds);
      });
    }

    _player.onPlayerComplete.listen((event) {
      playerGet.setIsPlaying(false);
    });
  }
}


// Container(
//                           height: MediaQuery.sizeOf(context).height / 5,
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.primary,
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               colorFilter: ColorFilter.mode(
//                                 Colors.black.withOpacity(.25),
//                                 BlendMode.darken,
//                               ),
//                               image: const NetworkImage(
//                                   "https://www.theweeknd.com/files/2023/06/THE-IDOL-SINGLE-PACK-COVER-EP-2-FINAL-EXPLICIT.jpg"),
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               MyText("Unlinked", color: Colors.white),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   MyText("The Weeknd - Starboy",
//                                       color: Colors.white),
//                                   IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Ionicons.play_circle,
//                                       size: 30,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
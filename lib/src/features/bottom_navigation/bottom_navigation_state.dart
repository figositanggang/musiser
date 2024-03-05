import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:musiser/src/features/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:musiser/src/features/bottom_navigation/controller/player_controller.dart';
import 'package:musiser/src/features/bottom_navigation/state/bookmark/bookmark_page.dart';
import 'package:musiser/src/features/bottom_navigation/state/home/home_page.dart';
import 'package:musiser/src/features/bottom_navigation/state/search/search_page.dart';
import 'package:musiser/src/helpers/audio_helper.dart';
import 'package:musiser/src/helpers/auth_helper.dart';
import 'package:musiser/src/utils/custom_widgets.dart';

class BottomNavigationState extends StatefulWidget {
  const BottomNavigationState({super.key});

  @override
  State<BottomNavigationState> createState() => _BottomNavigationStateState();
}

class _BottomNavigationStateState extends State<BottomNavigationState> {
  final bottomGet = Get.put(BottomNavigationController());
  final playerGet = Get.put(AudioPlayerController());

  List<Widget> body = [
    const HomePage(),
    const SearchPage(),
    const BookmarkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => body[bottomGet.index]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // @ Playing song
          Obx(
            () {
              if (playerGet.isLoaded == false) {
                return const SizedBox.shrink();
              }

              return Container(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withAlpha(10)
                    .withBlue(100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {},
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
                          resumeOrPause();
                        },
                        icon: Obx(() {
                          if (!playerGet.isPlaying) {
                            return const Icon(Ionicons.play);
                          }

                          return const Icon(Ionicons.pause);
                        }),
                      ),
                    ),

                    // @ playing state
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(() {
                        return LinearProgressIndicator(
                          value: playerGet.seconds.toDouble(),
                          minHeight: 1,
                          borderRadius: BorderRadius.circular(10),
                        );
                      }),
                    ),
                  ],
                ),
              );
            },
          ),
          InkResponse(
            onTap: null,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withAlpha(10)
                    .withBlue(100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: () {
                    bottomGet.setIndex(0);
                  }, icon: Obx(() {
                    if (bottomGet.index == 0) {
                      return const Icon(Ionicons.home);
                    }
                    return const Icon(Ionicons.home_outline);
                  })),
                  IconButton(onPressed: () {
                    bottomGet.setIndex(1);
                  }, icon: Obx(() {
                    if (bottomGet.index == 1) {
                      return const Icon(Ionicons.search_sharp);
                    }

                    return const Icon(Ionicons.search_outline);
                  })),
                  IconButton(onPressed: () {
                    bottomGet.setIndex(2);
                  }, icon: Obx(() {
                    if (bottomGet.index == 2) {
                      return const Icon(Ionicons.bookmark);
                    }

                    return const Icon(Ionicons.bookmark_outline);
                  })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resumeOrPause() async {
    String res = await AudioHelper.resumeOrPause();

    if (res == "resume") {
      playerGet.setIsPlaying(true);
    } else {
      playerGet.setIsPlaying(false);
    }
  }
}

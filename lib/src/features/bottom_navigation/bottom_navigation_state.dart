import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:musiser/src/features/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:musiser/src/features/bottom_navigation/state/bookmark/bookmark_page.dart';
import 'package:musiser/src/features/bottom_navigation/state/home/home_page.dart';
import 'package:musiser/src/features/bottom_navigation/state/search/search_page.dart';

class BottomNavigationState extends StatefulWidget {
  const BottomNavigationState({super.key});

  @override
  State<BottomNavigationState> createState() => _BottomNavigationStateState();
}

class _BottomNavigationStateState extends State<BottomNavigationState> {
  final bottomGet = Get.put(BottomNavigationController());

  List<Widget> body = [
    HomePage(),
    SearchPage(),
    BookmarkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => body[bottomGet.index]),
      bottomNavigationBar: InkResponse(
        onTap: null,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .textTheme
                .bodyMedium!
                .color!
                .withAlpha(10)
                .withBlue(100),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {
                bottomGet.setIndex(0);
              }, icon: Obx(() {
                if (bottomGet.index == 0) {
                  return Icon(Ionicons.home);
                }
                return Icon(Ionicons.home_outline);
              })),
              IconButton(onPressed: () {
                bottomGet.setIndex(1);
              }, icon: Obx(() {
                if (bottomGet.index == 1) {
                  return Icon(Ionicons.search_sharp);
                }

                return Icon(Ionicons.search_outline);
              })),
              IconButton(onPressed: () {
                bottomGet.setIndex(2);
              }, icon: Obx(() {
                if (bottomGet.index == 2) {
                  return Icon(Ionicons.bookmark);
                }

                return Icon(Ionicons.bookmark_outline);
              })),
            ],
          ),
        ),
      ),
    );
  }
}

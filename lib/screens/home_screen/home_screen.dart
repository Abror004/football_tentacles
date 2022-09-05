import 'package:flutter/material.dart';
import 'package:football_tentacles/screens/home_screen/home_controller.dart';
import 'package:football_tentacles/screens/play_page/play_screen.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: ((controller) {
          return Scaffold(
            body: Center(
              child: MaterialButton(
                onPressed: () {
                  Get.offAll(const PlayPage());
                },
                height: 60,

                shape: CircleBorder(),
                color: Colors.blue,
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 30,),
              ),
            ),
          );
        }));
  }
}

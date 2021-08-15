import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/bindings/game_binding.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:game/game.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/", page: () => Game(), binding: GameBinding()), // here!
      ],
      initialRoute: "/",
    );
  }
}


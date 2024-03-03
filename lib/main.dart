import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:musiser/firebase_options.dart';
import 'package:musiser/src/features/auth/page/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Rubik",
        primaryColor: const Color.fromARGB(255, 2, 109, 164),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: const Color.fromARGB(255, 2, 109, 164),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: "Rubik",
        primaryColor: const Color.fromARGB(255, 2, 109, 164),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 2, 109, 164),
        ),
      ),
      home: const AuthStatePage(),
    );
  }
}

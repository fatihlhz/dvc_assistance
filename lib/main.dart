import 'package:dvc_assistance/firebase_options.dart';
import 'package:dvc_assistance/models/dragon_card_model.dart';
import 'package:dvc_assistance/models/dragon_model.dart';
import 'package:dvc_assistance/models/personality_model.dart';
import 'package:dvc_assistance/models/required_stat_model.dart';
import 'package:dvc_assistance/providers/dragon_card_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dvc_assistance/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();

  Hive.registerAdapter(DragonCardModelAdapter());
  Hive.registerAdapter(DragonModelAdapter());
  Hive.registerAdapter(PersonalityModelAdapter());
  Hive.registerAdapter(RequiredStatModelAdapter());

  await Hive.openBox<DragonCardModel>('dragonCard');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DragonCardProvider>(
      create: (context) => DragonCardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DVC Assistance',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'JetBrains Mono'),
        home: const HomePage(title: "DVC Assistance"),
      ),
    );
  }
}

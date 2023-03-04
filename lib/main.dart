import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_story_app/presentation/routes/routes.dart';
import 'package:my_story_app/utils/injectable.dart';
import 'presentation/routes/register_routes.dart';

void main() async {
  await DotEnv().load();
  Injectable.instance.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: registerRoutes,
      initialRoute: RouteName.storyList,
      debugShowCheckedModeBanner: kDebugMode,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

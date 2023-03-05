/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'routes/register_routes.dart';
import 'routes/routes.dart';

class MyStoryApplication extends StatelessWidget {
  const MyStoryApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: registerRoutes,
      initialRoute: RouteName.splashscreen,
      debugShowCheckedModeBanner: kDebugMode,
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: EasyLoading.init(),
    );
  }
}

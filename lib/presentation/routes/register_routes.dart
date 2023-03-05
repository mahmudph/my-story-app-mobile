/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:my_story_app/presentation/routes/routes.dart';
import 'package:my_story_app/presentation/ui/pages/home.dart';
import 'package:my_story_app/presentation/ui/pages/pages.dart';

Map<String, WidgetBuilder> registerRoutes = {
  RouteName.login: (_) => const LoginScreen(),
  RouteName.register: (_) => const RegisterScreen(),
  RouteName.home: (_) => const HomeScreen(),
  // RouteName.profile: (_) => const ProfileScreen(),
  // RouteName.storyList: (_) => const ListStoryScreen(),
  // RouteName.newStory: (_) => const CreateStoryScreen(),
  RouteName.showStory: (_) => const DetailStoryScreen(),
  RouteName.splashscreen: (_) => const Splashscreen(),
};

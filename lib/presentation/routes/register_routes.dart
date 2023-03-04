/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:my_story_app/presentation/routes/routes.dart';

Map<String, WidgetBuilder> registerRoutes = {
  RouteName.login: (_) => Container(),
  RouteName.register: (_) => Container(),
  RouteName.profile: (_) => Container(),
  RouteName.storyList: (_) => Container(),
  RouteName.newStory: (_) => Container(),
  RouteName.showStory: (_) => Container(),
};

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_story_app/utils/injectable.dart';
import 'presentation/application.dart';
import 'utils/loading_options.dart';

void main() async {
  await dotenv.load();
  Injectable.instance.register();
  configureLoadingOptions();
  runApp(const MyStoryApplication());
}

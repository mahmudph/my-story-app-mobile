/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart';
import 'package:my_story_app/presentation/ui/pages/pages.dart';
import 'package:my_story_app/utils/injectable.dart';

import 'bottom_menu_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentActive = 0;
  final List<IconData> bottomNavIcons = [
    Icons.home,
    Icons.create,
    Icons.person,
  ];

  Widget getWidgetByCurrentIndex() {
    Widget widget;
    switch (currentActive) {
      case 0:
        widget = const ListStoryScreen();
        break;
      case 1:
        widget = const CreateStoryScreen();
        break;
      case 2:
        widget = const ProfileScreen();
        break;
      default:
        widget = const ListStoryScreen();
    }

    return widget;
  }

  List<BottomNavigationBarItem> getBottomNavItems() {
    return bottomNavIcons
        .map((e) => BottomNavigationBarItem(icon: Icon(e), label: ""))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: getBottomNavItems(),
        currentIndex: currentActive,
        onTap: (index) => setState(() => currentActive = index),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ListStoryCubit>(
            create: (_) => Injectable.getIt<ListStoryCubit>(),
          ),
          BlocProvider<UserCubit>(
            create: (_) => Injectable.getIt<UserCubit>(),
          ),
          BlocProvider<ListCategoryCubit>(
            create: (_) => Injectable.getIt<ListCategoryCubit>(),
          ),
        ],
        child: BottomMenuUtil(
          currentActiveMenu: currentActive,
          setActiveMenu: (index) => setState(() => currentActive = index),
          child: getWidgetByCurrentIndex(),
        ),
      ),
    );
  }
}

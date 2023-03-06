/*
 * Created by mahmud on Mon Mar 06 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';

class BottomMenuUtil extends InheritedWidget {
  final int currentActiveMenu;
  final Function(int activeMenu) setActiveMenu;

  const BottomMenuUtil({
    Key? key,
    required this.currentActiveMenu,
    required this.setActiveMenu,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant BottomMenuUtil oldWidget) {
    return currentActiveMenu != oldWidget.currentActiveMenu;
  }

  static BottomMenuUtil of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BottomMenuUtil>()!;
  }
}

import 'dart:io' show Platform;
import 'dart:ui' show SingletonFlutterWindow;

import 'package:discover_morocco/business_logic/models/models/enums/contact_host.dart';
import 'package:discover_morocco/business_logic/models/models/enums/icon_class.dart';
import 'package:discover_morocco/business_logic/models/models/enums/screen_type.dart';
import 'package:flutter/material.dart'
    show BuildContext, IconData, MediaQueryData;
import 'package:flutter/widgets.dart'
    show BuildContext, IconData, MediaQueryData;

import 'map_extension.dart';
import 'string_extension.dart';
import 'uri_extension.dart';

extension IconClassExtension on IconClass {
  // NOTE:
  // iconClass!.iconData(xxx)
  // Class 'IconClass' has no instance method 'iconData'.
  //
  // USE:
  // (post.iconClass! as IconClass).iconData
  //
  // :|
  IconData iconData(int code) {
    switch (this) {
      // case IconClass.iconDataSolid:
      //   return IconDataSolid(code);
      // case IconClass.iconDataBrands:
      //   return IconDataBrands(code);
      // case IconClass.iconDataRegular:
      //   return IconDataRegular(code);
      case IconClass.materialIcon:
        return IconData(code, fontFamily: 'MaterialIcons');
      default:
        throw Exception();
    }
  }
}


extension ScreenSizeExtension on MediaQueryData {
  ScreenType getScreenType() {
    var screenType = ScreenType.extraLarge;
    if (size.width < 768) {
      screenType = ScreenType.small;
    } else if (size.width < 992) {
      screenType = ScreenType.medium;
    } else if (size.width < 1200) {
      screenType = ScreenType.large;
    }

    return screenType;
  }

  int getAppWidth() {
    switch (getScreenType()) {
      case ScreenType.small:
        return 300;
      case ScreenType.medium:
        return 400;
      case ScreenType.large:
        return 500;
      case ScreenType.extraLarge:
        return 600;
    }
  }
}

extension FlutterWindowExtension on SingletonFlutterWindow {
  ScreenType getScreenType() {
    var screenType = ScreenType.extraLarge;
    if (physicalSize.width < 768) {
      screenType = ScreenType.small;
    } else if (physicalSize.width < 992) {
      screenType = ScreenType.medium;
    } else if (physicalSize.width < 1200) {
      screenType = ScreenType.large;
    }

    return screenType;
  }

  double getAppWidth() {
    switch (getScreenType()) {
      case ScreenType.small:
        return 400;
      case ScreenType.medium:
        return 400;
      case ScreenType.large:
        return 500;
      case ScreenType.extraLarge:
        return 600;
    }
  }
}

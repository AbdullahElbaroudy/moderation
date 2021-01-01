import 'package:flutter/cupertino.dart';
import 'package:moderation_tool/enums/device_screen_type.dart';

class SizingInformation {
  final Orientation orientation;
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localeWidgetSize;

  SizingInformation(
      {this.orientation,
      this.deviceScreenType,
      this.screenSize,
      this.localeWidgetSize});

      @override
      String toString() {
    return 'Orientation:$orientation\nDeviceType:$deviceScreenType \nScreenSize:$screenSize\nLocaleWidgetSize:$localeWidgetSize';
  }
}

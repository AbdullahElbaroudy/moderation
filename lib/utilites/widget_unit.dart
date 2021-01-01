import 'package:flutter/material.dart';

class WidgetUnits {
  static final WidgetUnits _widgetUnits = WidgetUnits._internal();
  factory WidgetUnits() {
    return _widgetUnits;
  }
  WidgetUnits._internal();

  MediaQueryData _mediaQueryData;
  double _screenWidth;
  double _screenHeight;
  double _blockSizeHorizontal;
  double _blockSizeVertical;
  ///////////////////
  double _pixelRatio;
  double _statusBarHeight;
  double _bottomBarHeight;
  double _textScaleFactor;
  double _windowWidth;
  double _windowHeight;

  initWindow() {
    _pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    print("_pixelRatio = ${pixelRatio}");
    _windowWidth = WidgetsBinding.instance.window.physicalSize.width;
    print("_windowWidth ${windowWidth}");
    _windowHeight = WidgetsBinding.instance.window.physicalSize.height;
    print("_windowHeight =${windowHeight}");
    _statusBarHeight = WidgetsBinding.instance.window.padding.top;
    print("_statusBarHeight ${statusBarHeight}");
    _bottomBarHeight = WidgetsBinding.instance.window.padding.bottom;
    print("_bottomBarHeight =${bottomBarHeight}");
    _textScaleFactor = WidgetsBinding.instance.window.textScaleFactor;
    print("_textScaleFactor ${textScaleFactor}");
    _screenHeight = _windowHeight / _pixelRatio;
    print("_screenHeight ${screenHeight}");
    _screenWidth = _windowWidth / _pixelRatio;
    print("_screenWidth ${screenWidth}");
    _blockSizeHorizontal = _screenWidth / 100;
    print("blockSizeHorizontal ${blockSizeHorizontal}");
    _blockSizeVertical = _screenHeight / 100;
    print("blockSizeVertical ${blockSizeVertical}");
  }

  double get pixelRatio => _pixelRatio;
  double get windowWidth => _windowWidth;
  double get windowHeight => _windowHeight;
  double get statusBarHeight => _statusBarHeight;
  double get bottomBarHeight => _bottomBarHeight;
  double get textScaleFactor => _textScaleFactor;
  double get screenHeight => _screenHeight;
  double get screenWidth => _screenWidth;
  double get blockSizeHorizontal => _blockSizeHorizontal;
  double get blockSizeVertical => _blockSizeVertical;
}

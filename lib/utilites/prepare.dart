
import 'package:moderation_tool/utilites/widget_unit.dart';

class Prepare {

  Prepare._internal();
  static final Prepare _prepare = Prepare._internal();
  factory Prepare() => _prepare;

  WidgetUnits _widgetUnits = WidgetUnits();
  WidgetUnits get widgetUnits => _widgetUnits;

  String _lang;
  String get lang => _lang;
  double get checkLangDirection => lang == 'ar' ? -1 : 1;
  double get checkLangscalability => lang == 'ar' ? 0.9 : 1;

 
}

import 'dart:async';
import 'package:moderation_tool/contract/disposable.dart';

class CustomTextFieldBloc implements Disposable {
  bool visability;

  final StreamController<bool> _streamControllerPasswordVisability =
      StreamController<bool>();
  Stream<bool> get scPasswordVisabilityStream =>
      _streamControllerPasswordVisability.stream;
  Sink<bool> get scPasswordVisabilitySink =>
      _streamControllerPasswordVisability.sink;

  final StreamController<bool> _streamControllerChangePasswordVisability =StreamController<bool>();

  Stream<bool> get scChangePasswordVisabilityStream => _streamControllerChangePasswordVisability.stream;
  Sink<bool> get scChangePasswordVisabilitySink => _streamControllerChangePasswordVisability.sink;

  CustomTextFieldBloc() {
    visability = true;
    scPasswordVisabilitySink.add(visability);
    print("From bloc visibility = $visability");
    _streamControllerChangePasswordVisability.stream.listen(_changeVisability);
  }

  _changeVisability(bool visable) {
    visable
        ? scPasswordVisabilitySink.add(false)
        : scPasswordVisabilitySink.add(true);
  }

  @override
  dispose() {
    _streamControllerPasswordVisability.close();
    _streamControllerChangePasswordVisability.close();
  }

}

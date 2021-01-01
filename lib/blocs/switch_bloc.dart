
import 'dart:async';
import 'package:moderation_tool/contract/disposable.dart';

class SwitchBloc implements Disposable{
  bool _on = true;

  final StreamController<bool> _controller =
      StreamController<bool>();
  Stream<bool> get switchStream =>
      _controller.stream;
  Sink<bool> get switchSink =>
      _controller.sink;

  StreamSubscription subscription;
  final StreamController<bool> _changeSwitchController = StreamController<bool>.broadcast();

  Stream<bool> get changeSwitchStream => _changeSwitchController.stream;
  Sink<bool> get changeSwitchSink => _changeSwitchController.sink;

  SwitchBloc() {
    print("object");
    switchSink.add(true);
    subscription = changeSwitchStream.listen(_changeVisability) ;
  }

  _changeVisability(bool status) {
    status
        ? switchSink.add(false)
        : switchSink.add(true);
  }
  
  @override
  dispose() {
    subscription.cancel();
    _controller.close();
    _changeSwitchController.close();

  }
}
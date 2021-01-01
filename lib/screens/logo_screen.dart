import 'package:flutter/material.dart';
import 'package:moderation_tool/widgets/logo_clip.dart';
import 'package:moderation_tool/widgets/shark_clip.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomPaint(
        size: Size(x*0.5, y*0.5),
        painter: MySharkClip(),
      ),
    );
  }

  Transform es3fniLogo() {
    return Transform.translate(
      offset: Offset(0, 0),
      child: Transform.translate(
        offset: Offset(-780, -720),
        child: CustomPaint(
          size: Size(100, 100),
          isComplex: true,
          painter: MyPainter(),
        ),
      ),
    );
  }
}

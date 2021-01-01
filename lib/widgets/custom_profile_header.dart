
import 'package:flutter/material.dart';

class CustomProfileHeader extends StatefulWidget {
  double height,diameter;
  String image;
  Color backGroundColor;
  CustomProfileHeader({this.height,this.diameter,this.image,this.backGroundColor}){
    this.height=this.height??1;
    this.backGroundColor=this.backGroundColor??Colors.black;
    this.diameter=this.diameter??1;
    this.image= this.image??'';
  }
  @override
  _CustomProfileHeaderState createState() => _CustomProfileHeaderState();
}

class _CustomProfileHeaderState extends State<CustomProfileHeader> {



  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height * 0.3 * widget.height;
    double diffrence =
        headerHeight - (MediaQuery.of(context).size.height * 0.25 * widget.height);
    double diameter = MediaQuery.of(context).size.width * 0.3 * widget.diameter;
    double circulCenter = headerHeight - diffrence - (diameter / 2);
   
    return Stack(
      children: [
        Container(
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width * 1.05,
                headerHeight), //You can Replace this with your desired WIDTH and HEIGHT
            painter: RPSCustomPainter(widget.backGroundColor),
          ),
        ),

        Positioned(
          top: circulCenter,
          child: Container(
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(widget.image),
              ),
              border: Border.all(),
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width)),
            ),
          ),
        ),
      ],
    );
  }
}
class RPSCustomPainter extends CustomPainter {
  Color backGroundColor;
  RPSCustomPainter(this.backGroundColor);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = backGroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.50);
    path_0.lineTo(size.width, size.height * 0.76);
    path_0.quadraticBezierTo(
        size.width * 0.89, size.height * 1.00, size.width * 0.59, size.height);
    path_0.cubicTo(size.width * 0.31, size.height * 0.97, size.width * 0.30,
        size.height * 0.91, size.width * 0.23, size.height * 0.88);
    path_0.quadraticBezierTo(
        size.width * 0.16, size.height * 0.82, 0, size.height * 0.84);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.20);
    path_0.lineTo(size.width, size.height * 0.76);
    path_0.lineTo(size.width * 0.61, size.height);
    path_0.lineTo(size.width * 0.61, size.height);

    canvas.drawPath(path_0, paint_0);
   
     }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

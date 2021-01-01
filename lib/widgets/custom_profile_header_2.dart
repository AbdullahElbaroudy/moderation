import 'package:flutter/material.dart';

class CustomProfileHeader2 extends StatefulWidget {
  double height, diameter;
  DecorationImage image;
  DecorationImage coverImage;
  Color backGroundColor;
  CustomProfileHeader2(
      {this.height,
      this.diameter,
      this.image,
      this.backGroundColor,
      this.coverImage,
        }) {
    this.coverImage =this.coverImage ??this.image;
    this.height = this.height ?? 1;
    this.backGroundColor = this.backGroundColor ?? Colors.black;
    this.diameter = this.diameter ?? 1;
  }
  @override
  _CustomProfileHeader2State createState() => _CustomProfileHeader2State();
}

class _CustomProfileHeader2State extends State<CustomProfileHeader2> {
  @override
  Widget build(BuildContext context) {
    double headerHeight =
        MediaQuery.of(context).size.height * 0.3 * widget.height;
    double diffrence = headerHeight -
        (MediaQuery.of(context).size.height * 0.19 * widget.height);
    double diameter = MediaQuery.of(context).size.width * 0.3 * widget.diameter;
    double circulCenter = headerHeight - diffrence - (diameter / 2);
    return Stack(children: [
      ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: headerHeight,
          decoration: BoxDecoration(
              color: Colors.black,
              image: widget.coverImage),
        ),
        clipper: CustomClipPath(),
      ),
      Positioned(
        top: circulCenter,
        child: Container(
          height: diameter,
          width: diameter,
          decoration: BoxDecoration(
            color: Colors.white,
            image: widget.image,
            border: Border.all(),
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width)),
          ),
        ),
      ),
    ]);
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print("From custom clip width = ${size.width}  && height = ${size.height}");
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height -
            100); //(x,y -for point that curve will circul arround , x,y-for end point)
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomIntroHeader extends StatelessWidget {
  const CustomIntroHeader({
    Key key,
    @required this.w,
    @required this.h,
    @required this.t,
    @required this.word,
    @required this.baseColor,
    @required this.highlightColor,
  }) : super(key: key);

  final double w;
  final double h;
  final double t;
  final String word;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
      image: DecorationImage(
    fit: BoxFit.fill,
    image: AssetImage(
      'assets/images/backgroundfewnka.png',
    ),
            )),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
    Transform.translate(
      offset: Offset(0, 0),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/fewnkabs.png',
          ),
        )),
      ),
    ),
    Transform.translate(
      offset: Offset(
          w * t * 0.00001,
          -h *
              0.27), //Offset((w - w * ((h + w) * 0.0002)) / 2, w * 0.1),//Offset(w / 7.5, h * 0.05),
      child: Shimmer.fromColors(
        child: Text(
          word,
          style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * 50,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              shadows: [Shadow(blurRadius: 1, color: Colors.red)]),
        ),
        baseColor: baseColor,
        highlightColor: highlightColor,
      ),
    ),
            ],
          ),
        ],
      ),
    );
  }
}

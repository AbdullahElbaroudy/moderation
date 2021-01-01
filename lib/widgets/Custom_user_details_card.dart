import 'package:flutter/material.dart';
import 'package:moderation_tool/utilites/prepare.dart';
class UserDetailsCard extends StatefulWidget {
  Widget child;
  DecorationImage image;
  double height_Scale;
  UserDetailsCard({ this.height_Scale,this.child,this.image}) {
    this.height_Scale = this.height_Scale ?? 1.1;
    this.child=this.child??Container();
    //this.diameter_scale = this.diameter_scale ??0.5;
  }
  @override
  _UserDetailsCardState createState() => _UserDetailsCardState();
}

class _UserDetailsCardState extends State<UserDetailsCard> {
  Prepare _prepare;
  double cardHeight;
  double diffranceScale;
  double diameter;
  double circulCenter;
  @override
  void initState() {
    _prepare = Prepare();
    cardHeight = _prepare.widgetUnits.screenHeight *
        0.2 *
        widget.height_Scale /*
        widget.diameter_scale*/;
    diffranceScale =
        _prepare.widgetUnits.screenHeight * 0.02 /* widget.diameter_scale*/;
    diameter = (cardHeight + diffranceScale);
    circulCenter = ((cardHeight + diffranceScale) - diameter) / 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cardHeight=Localizations.localeOf(context).languageCode=='ar'?cardHeight+_prepare.widgetUnits.screenHeight*0.002:cardHeight;
    return Padding(
      padding: EdgeInsets.only(top: diffranceScale),
      child: Container(
        height: cardHeight + diffranceScale,
        child: Stack(
          children: [
            Padding(
              padding: Localizations.localeOf(context).languageCode=='ar'?EdgeInsets.only(right: diameter / 2):EdgeInsets.only(left: diameter / 2),
              child: Column(
                children: [
                  Expanded(
                     child: Card( 
                      elevation: 5,
                      child: Container(
                       
                        width: _prepare.widgetUnits.screenWidth,
                        child: Row(
                          children: [
                            SizedBox(width: diameter / 2,),
                            Expanded(
                                child: widget.child,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: circulCenter,
              child: Container(
                height: diameter,
                width: diameter,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: widget.image,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_prepare.widgetUnits.screenWidth),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

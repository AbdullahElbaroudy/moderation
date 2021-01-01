  import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      Path path = Path();
      // Path number 1
  
      //face
      paint.color = Color(0x2F3D9E).withOpacity(1);
      path = Path();
      path.lineTo(size.width * 9.35, size.height * 10.93);
      path.cubicTo(size.width * 9.28, size.height * 10.93, size.width * 9.21, size.height * 10.9, size.width * 9.16, size.height * 10.84);
      path.cubicTo(size.width * 9.12, size.height * 10.79, size.width * 9.09, size.height * 10.72, size.width * 9.08, size.height * 10.65);
      path.cubicTo(size.width * 9.08, size.height * 10.62, size.width * 9.09, size.height * 10.6, size.width * 9.1, size.height * 10.58);
      path.cubicTo(size.width * 9.13, size.height * 10.53, size.width * 9.17, size.height * 10.49, size.width * 9.23, size.height * 10.48);
      path.cubicTo(size.width * 9.24, size.height * 10.47, size.width * 9.25, size.height * 10.48, size.width * 9.25, size.height * 10.48);
      path.cubicTo(size.width * 9.26, size.height * 10.49, size.width * 9.26, size.height * 10.5, size.width * 9.25, size.height * 10.51);
      path.cubicTo(size.width * 9.25, size.height * 10.52, size.width * 9.24, size.height * 10.53, size.width * 9.23, size.height * 10.54);
      path.cubicTo(size.width * 9.23, size.height * 10.54, size.width * 9.23, size.height * 10.55, size.width * 9.23, size.height * 10.56);
      path.cubicTo(size.width * 9.24, size.height * 10.57, size.width * 9.24, size.height * 10.57, size.width * 9.25, size.height * 10.56);
      path.cubicTo(size.width * 9.3, size.height * 10.55, size.width * 9.34, size.height * 10.52, size.width * 9.38, size.height * 10.48);
      path.cubicTo(size.width * 9.42, size.height * 10.45, size.width * 9.46, size.height * 10.4, size.width * 9.49, size.height * 10.36);
      path.cubicTo(size.width * 9.5, size.height * 10.35, size.width * 9.5, size.height * 10.35, size.width * 9.51, size.height * 10.36);
      path.cubicTo(size.width * 9.55, size.height * 10.39, size.width * 9.58, size.height * 10.43, size.width * 9.61, size.height * 10.49);
      path.cubicTo(size.width * 9.65, size.height * 10.61, size.width * 9.63, size.height * 10.75, size.width * 9.55, size.height * 10.84);
      path.cubicTo(size.width * 9.5, size.height * 10.89, size.width * 9.45, size.height * 10.92, size.width * 9.39, size.height * 10.92);
      path.cubicTo(size.width * 9.38, size.height * 10.92, size.width * 9.37, size.height * 10.92, size.width * 9.35, size.height * 10.93);
      path.cubicTo(size.width * 9.35, size.height * 10.93, size.width * 9.35, size.height * 10.93, size.width * 9.35, size.height * 10.93);
      canvas.drawPath(path, paint);
  

      // Path number 2
  
      //cap
      paint.color = Color(0x2F3D9E).withOpacity(1);
      path = Path();
      path.lineTo(size.width * 9.64, size.height * 10.47);
      path.cubicTo(size.width * 9.58, size.height * 10.34, size.width * 9.49, size.height * 10.27, size.width * 9.36, size.height * 10.26);
      path.cubicTo(size.width * 9.23, size.height * 10.26, size.width * 9.13, size.height * 10.34, size.width * 9.07, size.height * 10.47);
      path.cubicTo(size.width * 9.06, size.height * 10.44, size.width * 9.05, size.height * 10.42, size.width * 9.04, size.height * 10.4);
      path.cubicTo(size.width * 9.03, size.height * 10.37, size.width * 9.02, size.height * 10.34, size.width * 9.01, size.height * 10.31);
      path.cubicTo(size.width * 9, size.height * 10.26, size.width * 9.01, size.height * 10.21, size.width * 9.05, size.height * 10.17);
      path.cubicTo(size.width * 9.08, size.height * 10.13, size.width * 9.13, size.height * 10.1, size.width * 9.17, size.height * 10.07);
      path.cubicTo(size.width * 9.22, size.height * 10.05, size.width * 9.26, size.height * 10.03, size.width * 9.31, size.height * 10.03);
      path.cubicTo(size.width * 9.36, size.height * 10.02, size.width * 9.41, size.height * 10.03, size.width * 9.46, size.height * 10.04);
      path.cubicTo(size.width * 9.54, size.height * 10.06, size.width * 9.61, size.height * 10.1, size.width * 9.66, size.height * 10.16);
      path.cubicTo(size.width * 9.71, size.height * 10.2, size.width * 9.72, size.height * 10.27, size.width * 9.7, size.height * 10.33);
      path.cubicTo(size.width * 9.68, size.height * 10.38, size.width * 9.67, size.height * 10.42, size.width * 9.65, size.height * 10.47);
      path.cubicTo(size.width * 9.65, size.height * 10.47, size.width * 9.65, size.height * 10.47, size.width * 9.64, size.height * 10.47);
      path.cubicTo(size.width * 9.64, size.height * 10.47, size.width * 9.64, size.height * 10.47, size.width * 9.64, size.height * 10.47);
      canvas.drawPath(path, paint);
      // Path number 3
      //heart
      paint.color = Color(0xF2494A).withOpacity(1);
      path = Path();
      path.lineTo(size.width * 9.22, size.height * 10.03);
      path.cubicTo(size.width * 9.22, size.height * 10.01, size.width * 9.23, size.height * 10, size.width * 9.24, size.height * 9.98);
      path.cubicTo(size.width * 9.28, size.height * 9.91, size.width * 9.34, size.height * 9.86, size.width * 9.41, size.height * 9.83);
      path.cubicTo(size.width * 9.45, size.height * 9.82, size.width * 9.49, size.height * 9.82, size.width * 9.53, size.height * 9.82);
      path.cubicTo(size.width * 9.6, size.height * 9.83, size.width * 9.65, size.height * 9.86, size.width * 9.7, size.height * 9.9);
      path.cubicTo(size.width * 9.71, size.height * 9.91, size.width * 9.71, size.height * 9.91, size.width * 9.71, size.height * 9.9);
      path.cubicTo(size.width * 9.76, size.height * 9.86, size.width * 9.81, size.height * 9.83, size.width * 9.87, size.height * 9.82);
      path.cubicTo(size.width * 9.89, size.height * 9.82, size.width * 9.92, size.height * 9.82, size.width * 9.94, size.height * 9.82);
      path.cubicTo(size.width * 9.97, size.height * 9.82, size.width * 10, size.height * 9.83, size.width * 10.03, size.height * 9.84);
      path.cubicTo(size.width * 10.12, size.height * 9.88, size.width * 10.19, size.height * 9.97, size.width * 10.21, size.height * 10.07);
      path.cubicTo(size.width * 10.22, size.height * 10.13, size.width * 10.22, size.height * 10.19, size.width * 10.21, size.height * 10.25);
      path.cubicTo(size.width * 10.19, size.height * 10.34, size.width * 10.15, size.height * 10.4, size.width * 10.1, size.height * 10.47);
      path.cubicTo(size.width * 10.03, size.height * 10.56, size.width * 9.95, size.height * 10.64, size.width * 9.86, size.height * 10.71);
      path.cubicTo(size.width * 9.82, size.height * 10.74, size.width * 9.77, size.height * 10.78, size.width * 9.73, size.height * 10.81);
      path.cubicTo(size.width * 9.72, size.height * 10.82, size.width * 9.7, size.height * 10.82, size.width * 9.69, size.height * 10.81);
      path.cubicTo(size.width * 9.67, size.height * 10.79, size.width * 9.65, size.height * 10.78, size.width * 9.63, size.height * 10.77);
      path.cubicTo(size.width * 9.62, size.height * 10.76, size.width * 9.62, size.height * 10.76, size.width * 9.62, size.height * 10.75);
      path.cubicTo(size.width * 9.63, size.height * 10.73, size.width * 9.64, size.height * 10.72, size.width * 9.64, size.height * 10.7);
      path.cubicTo(size.width * 9.64, size.height * 10.69, size.width * 9.64, size.height * 10.69, size.width * 9.65, size.height * 10.69);
      path.cubicTo(size.width * 9.67, size.height * 10.71, size.width * 9.68, size.height * 10.72, size.width * 9.7, size.height * 10.73);
      path.cubicTo(size.width * 9.7, size.height * 10.73, size.width * 9.71, size.height * 10.73, size.width * 9.72, size.height * 10.73);
      path.cubicTo(size.width * 9.79, size.height * 10.67, size.width * 9.86, size.height * 10.61, size.width * 9.93, size.height * 10.55);
      path.cubicTo(size.width * 9.98, size.height * 10.5, size.width * 10.03, size.height * 10.44, size.width * 10.07, size.height * 10.38);
      path.cubicTo(size.width * 10.11, size.height * 10.33, size.width * 10.14, size.height * 10.26, size.width * 10.15, size.height * 10.19);
      path.cubicTo(size.width * 10.16, size.height * 10.08, size.width * 10.13, size.height * 10, size.width * 10.05, size.height * 9.94);
      path.cubicTo(size.width * 10, size.height * 9.9, size.width * 9.95, size.height * 9.89, size.width * 9.89, size.height * 9.89);
      path.cubicTo(size.width * 9.83, size.height * 9.9, size.width * 9.78, size.height * 9.93, size.width * 9.74, size.height * 9.98);
      path.cubicTo(size.width * 9.72, size.height * 10.01, size.width * 9.7, size.height * 10.01, size.width * 9.68, size.height * 9.98);
      path.cubicTo(size.width * 9.63, size.height * 9.93, size.width * 9.57, size.height * 9.9, size.width * 9.51, size.height * 9.89);
      path.cubicTo(size.width * 9.44, size.height * 9.89, size.width * 9.38, size.height * 9.92, size.width * 9.33, size.height * 9.97);
      path.cubicTo(size.width * 9.32, size.height * 9.98, size.width * 9.32, size.height * 9.99, size.width * 9.31, size.height * 10);
      path.cubicTo(size.width * 9.31, size.height * 10.01, size.width * 9.3, size.height * 10.01, size.width * 9.3, size.height * 10.01);
      path.cubicTo(size.width * 9.27, size.height * 10.01, size.width * 9.25, size.height * 10.02, size.width * 9.22, size.height * 10.03);
      path.cubicTo(size.width * 9.22, size.height * 10.03, size.width * 9.22, size.height * 10.03, size.width * 9.22, size.height * 10.03);
      canvas.drawPath(path, paint);
  
      
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }
  }

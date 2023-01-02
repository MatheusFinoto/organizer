import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // path.lineTo(0, size.height);
    // path.arcToPoint(Offset(size.width, size.height),radius: Radius.elliptical(30, 10));
    // path.lineTo(size.width, 0);

    path.lineTo(0.0, size.height - 100);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class OtherClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height - 20);
    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class BoxShadowPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // here are my custom shapes
    // path.moveTo(size.width, size.height * 0.14);
    // path.lineTo(size.width, size.height * 1.0);
    // path.lineTo(size.width - (size.width  *0.99) , size.height);
    path.lineTo(0.0, size.height - 100);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    canvas.drawShadow(path, Colors.black, 3.0, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BoxShadowPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // here are my custom shapes
    // path.moveTo(size.width, size.height * 0.14);
    // path.lineTo(size.width, size.height * 1.0);
    // path.lineTo(size.width - (size.width  *0.99) , size.height);
    path.lineTo(0.0, size.height - 20);
    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();

    canvas.drawShadow(path, Colors.black, 3.0, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

///////////////////////////////////////////////////////////////////////////////
class BottonShapeClipperGreen extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // path.lineTo(0, size.height);
    // path.arcToPoint(Offset(size.width, size.height),radius: Radius.elliptical(30, 10));
    // path.lineTo(size.width, 0);

    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 100.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class BottonShapeClipperGold extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // path.lineTo(0, size.height);
    // path.arcToPoint(Offset(size.width, size.height),radius: Radius.elliptical(30, 10));
    // path.lineTo(size.width, 0);

    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 100.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

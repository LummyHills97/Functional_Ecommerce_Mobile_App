import 'package:flutter/material.dart';

/// Custom painter for creating curved edges
class TCurvedEdgesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white // This will be overridden by the ClipPath
      ..style = PaintingStyle.fill;

    var path = Path();
    
    // Start from top-left
    path.lineTo(0, size.height - 20);
    
    // Create curved bottom edge
    var firstCurveStart = Offset(0, size.height - 20);
    var firstCurveEnd = Offset(30, size.height - 20);
    path.quadraticBezierTo(
      firstCurveStart.dx,
      firstCurveStart.dy - 20,
      firstCurveEnd.dx,
      firstCurveEnd.dy,
    );
    
    var secondCurveStart = Offset(0, size.height - 20);
    var secondCurveEnd = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      secondCurveEnd.dx,
      secondCurveEnd.dy,
    );
    
    var thirdCurveStart = Offset(size.width - 30, size.height - 20);
    var thirdCurveEnd = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      thirdCurveStart.dx + 20,
      thirdCurveStart.dy - 20,
      thirdCurveEnd.dx,
      thirdCurveEnd.dy,
    );
    
    // Complete the path
    path.lineTo(size.width, 0);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/// Alternative simpler curved edge painter
class TSimpleCurvedEdgesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var path = Path();
    
    // Create a simple curved bottom edge
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2, 
      size.height, 
      size.width, 
      size.height - 20
    );
    path.lineTo(size.width, 0);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/// Widget that applies curved edges to its child
class TCustomCurvedEdgeWidget extends StatelessWidget {
  const TCustomCurvedEdgeWidget({
    super.key,
    required this.child,
    this.useSimpleCurve = true,
  });

  final Widget child;
  final bool useSimpleCurve;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: useSimpleCurve ? TSimpleCurvedEdgesClipper() : TCurvedEdgesClipper(),
      child: child,
    );
  }
}

/// Custom clipper for curved edges
class TCurvedEdgesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    
    // Start from top-left
    path.lineTo(0, size.height - 20);
    
    // Create curved bottom edge with multiple curves for a wavy effect
    var firstCurveStart = Offset(0, size.height - 20);
    var firstCurveEnd = Offset(30, size.height - 20);
    path.quadraticBezierTo(
      firstCurveStart.dx,
      firstCurveStart.dy - 20,
      firstCurveEnd.dx,
      firstCurveEnd.dy,
    );
    
    var secondCurveStart = Offset(0, size.height - 20);
    var secondCurveEnd = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      secondCurveEnd.dx,
      secondCurveEnd.dy,
    );
    
    var thirdCurveStart = Offset(size.width - 30, size.height - 20);
    var thirdCurveEnd = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      thirdCurveStart.dx + 20,
      thirdCurveStart.dy - 20,
      thirdCurveEnd.dx,
      thirdCurveEnd.dy,
    );
    
    // Complete the path
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

/// Simpler curved edges clipper
class TSimpleCurvedEdgesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    
    // Start from top-left corner
    path.lineTo(0, size.height - 20);
    
    // Create a simple curved bottom edge
    path.quadraticBezierTo(
      size.width / 2, 
      size.height, 
      size.width, 
      size.height - 20
    );
    
    // Go to top-right and close
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
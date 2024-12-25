import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_drawing/path_drawing.dart';

class SvgClipper extends CustomClipper<Path> {
  final String svgPathData;
  SvgClipper(this.svgPathData);
  @override
  Path getClip(Size size) {
    // Parse the SVG path data
    Path path = parseSvgPathData(svgPathData);

    // Get the bounding box of the path
    final Rect pathBounds = path.getBounds();

    // Create a scaling matrix to fit the path within the container size
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(size.width / pathBounds.width, size.height / pathBounds.height);

    // Apply the scaling transformation to the path
    path = path.transform(matrix4.storage);

    // Center the path within the container
    final Rect newBounds = path.getBounds();
    final double dx = (size.width - newBounds.width) / 2 - newBounds.left;
    final double dy = (size.height - newBounds.height) / 2 - newBounds.top;
    path = path.shift(Offset(dx, dy));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}




class SvgClipperWithShadow extends StatelessWidget {
  final List<BoxShadow> shadows;
  final String clipperPathString;
  final Widget child;


  const SvgClipperWithShadow({super.key, 
    required this.shadows,
    required this.clipperPathString,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    CustomClipper<Path> customClipper= SvgClipper(clipperPathString);
    return ClipShadowPath(shadows: shadows, clipper: customClipper, child: child);
  }
}

class ClipShadowPath extends StatelessWidget {
  final List<BoxShadow> shadows;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    Key? key,
    required this.shadows,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadows: shadows,
      ),
      child: ClipPath(child: child, clipper: clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final List<BoxShadow> shadows;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadows, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    shadows.forEach((shadow) {
          var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
     });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
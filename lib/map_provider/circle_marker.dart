

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getDotMarker() async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, 55, 55));

  const size = Size(40, 40);

  final customMarker = CircleMarker();
  customMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(
    size.width.toInt(),
    size.height.toInt(),
  );
  final byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );

  final bytes = byteData!.buffer.asUint8List();
  return BitmapDescriptor.fromBytes(bytes);
}

class CircleMarker extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    final Paint paint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, paint);

    paint.color = Colors.orange;
    canvas.drawCircle(center, radius * 0.6, paint); // Adjust radius for the inner circle
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint if the drawing hasn't changed
  }
}

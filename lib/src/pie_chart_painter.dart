import 'dart:math' show sin, cos;

import 'package:flutter/material.dart';
import 'package:outline_pie_chart/outline_pie_chart.dart';

class PieChartPainter extends CustomPainter {
  final List<PieData> data;
  final double? strokeWidth;
  final double gap;
  double animationValue;
  final bool isRTL;

  PieChartPainter({
    required this.data,
    this.strokeWidth,
    this.animationValue = 1,
    this.gap = 4.0,
    this.isRTL = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final adjustedData = adjustPercentages(data);
    
    // Start from 270 degrees (bottom) instead of -90 (top)
    double startAngle = isRTL ? 0.0 : 270.0;

    for (int i = 0; i < adjustedData.length; i++) {
      final item = adjustedData[i];
      
      // Calculate the full sweep angle for this segment (without animation)
      final fullSweepAngle = item.percentage * 360.0;
      
      // Apply animation to the sweep angle
      final animatedSweepAngle = fullSweepAngle * animationValue;
      
      // Only draw if the animated sweep angle is greater than 0
      if (animatedSweepAngle > 0) {
        // Calculate gap distribution - half gap at start, half at end
        final halfGap = gap / 2;
        
        // Adjust start angle to account for half gap at the beginning
        final adjustedStartAngle = startAngle + halfGap;
        
        // Adjust sweep angle to account for gaps on both sides
        final adjustedSweepAngle = animatedSweepAngle - gap;
        
        // Only draw if the adjusted sweep angle is positive
        if (adjustedSweepAngle > 0) {
          _drawSegmentWithEffects(canvas, size, item, adjustedStartAngle, adjustedSweepAngle);
        }
      }

      // Move to next segment start position (including full gap)
      startAngle += animatedSweepAngle;
    }
  }

  /// Draws a segment with all enhanced effects (shadow, gradient, radius)
  void _drawSegmentWithEffects(
    Canvas canvas,
    Size size,
    PieData item,
    double startAngle,
    double sweepAngle,
  ) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final effectiveStrokeWidth = strokeWidth ?? 20.0;

    // Draw shadows first (if any)
    if (item.boxShadows != null && item.boxShadows!.isNotEmpty) {
      _drawShadows(canvas, rect, item.boxShadows!, startAngle, sweepAngle,
          effectiveStrokeWidth);
    }

    // Create the main paint object
    Paint paint = Paint()..style = PaintingStyle.stroke;

    // Apply gradient if available, otherwise use solid color
    if (item.gradient != null) {
      paint = _createGradientPaint(item.gradient!, rect, effectiveStrokeWidth);
    } else {
      paint.color = item.color;
    }

    paint.strokeWidth = effectiveStrokeWidth;

    // Apply border radius if specified
    if (item.borderRadius != null && item.borderRadius! > 0) {
      paint.strokeCap = StrokeCap.round;
    }

    // Draw the main arc
    canvas.drawArc(
      rect,
      radians(startAngle),
      radians(sweepAngle),
      false,
      paint,
    );
  }

  /// Creates a paint object with gradient shader
  Paint _createGradientPaint(Gradient gradient, Rect rect, double strokeWidth) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Create shader based on gradient type
    if (gradient is LinearGradient) {
      paint.shader = gradient.createShader(rect);
    } else if (gradient is RadialGradient) {
      paint.shader = gradient.createShader(rect);
    } else if (gradient is SweepGradient) {
      paint.shader = gradient.createShader(rect);
    }

    return paint;
  }

  /// Draws box shadows for a segment - FIXED to follow arc properly
  void _drawShadows(
    Canvas canvas,
    Rect rect,
    List<BoxShadow> shadows,
    double startAngle,
    double sweepAngle,
    double strokeWidth,
  ) {
    for (final shadow in shadows) {
      final shadowPaint = Paint()
        ..color = shadow.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius);

      // Calculate shadow offset in polar coordinates to follow the arc
      final center = rect.center;
      final radius = rect.width / 2;
      
      // Calculate the angle for the middle of the segment
      final middleAngle = startAngle + sweepAngle / 2;
      final middleAngleRad = radians(middleAngle);
      
      // Convert cartesian offset to polar coordinates that follow the arc
      final offsetX = shadow.offset.dx * cos(middleAngleRad);
      final offsetY = shadow.offset.dy * sin(middleAngleRad);
      
      // Apply the offset to the rectangle
      final shadowRect = rect.shift(Offset(offsetX, offsetY));

      canvas.drawArc(
        shadowRect,
        radians(startAngle),
        radians(sweepAngle),
        false,
        shadowPaint,
      );
    }
  }

  /// Converts degrees to radians for use in drawing arcs.
  double radians(double degrees) {
    return degrees * (3.1415926535897932 / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is PieChartPainter) {
      return oldDelegate.data != data ||
          oldDelegate.strokeWidth != strokeWidth ||
          oldDelegate.gap != gap ||
          oldDelegate.animationValue != animationValue ||
          oldDelegate.isRTL != isRTL;
    }
    return true;
  }
}
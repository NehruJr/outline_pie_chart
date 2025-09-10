import 'package:flutter/material.dart';
import 'package:outline_pie_chart/outline_pie_chart.dart';

/// ## [PieChartPainter] Class Documentation
///
/// A custom painter for drawing a segmented, animated pie chart with enhanced features.
///
/// The `PieChartPainter` class is responsible for rendering pie chart segments
/// based on the provided data, with optional animation, gap spacing, RTL support,
/// gradients, box shadows, and border radius.
///
/// ### Parameters:
///
/// - **data** (`List<PieData>`):
///   A list of `PieData` objects representing each segment of the pie chart.
///   Each `PieData` contains a `percentage`, `color`, optional `gradient`,
///   `boxShadows`, and `borderRadius`.
///
/// - **strokeWidth** (`double?`):
///   The thickness of the pie chart segments. If null, defaults to 20.0 pixels.
///
/// - **gap** (`double`):
///   The gap (in degrees) between segments in the pie chart. Default is 4.0 degrees.
///
/// - **animationValue** (`double`):
///   A value between 0 and 1 that controls the animation progress. Default is 1,
///   meaning the chart is fully rendered. Can be animated to create drawing effects.
///
/// - **isRTL** (`bool`):
///   If true, the pie chart is drawn from right to left (suitable for RTL languages like Persian).
///   Default is false.
///
/// ### Enhanced Features:
///
/// - **Gradient Support**: Each segment can have a gradient overlay using the `gradient` property.
/// - **Box Shadow**: Segments can have shadow effects using the `boxShadows` property.
/// - **Border Radius**: Segments can have rounded corners using the `borderRadius` property.
///
/// ### Methods:
///
/// - **paint** (`Canvas canvas, Size size`):
///   Draws the pie chart on the provided canvas, using the specified size. The method calculates
///   the start angle and sweep angle for each segment, taking into account RTL support, animation progress,
///   gradients, shadows, and border radius.
///
/// - **_drawSegmentWithEffects**:
///   Helper method to draw a segment with all enhanced effects (shadow, gradient, radius).
///
/// - **_createGradientPaint**:
///   Creates a paint object with gradient shader for a segment.
///
/// - **_drawShadows**:
///   Draws box shadows for a segment.
///
/// - **radians** (`double degrees`):
///   Converts degrees to radians for use in drawing arcs.
///
/// - **shouldRepaint** (`CustomPainter oldDelegate`):
///   Returns true if any data has changed to trigger a repaint.
///
class PieChartPainter extends CustomPainter {
  /// A list of `PieData` objects representing each segment of the pie chart.
  final List<PieData> data;

  /// The thickness of the pie chart segments. Defaults to 20.0 pixels if not specified.
  final double? strokeWidth;

  /// The gap (in degrees) between segments in the pie chart. Default is 4.0 degrees.
  final double gap;

  /// Controls the animation progress (0 to 1). Default is 1 (fully rendered).
  double animationValue;

  /// If true, the pie chart is drawn from right to left for RTL languages. Default is false.
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
    double startAngle = isRTL ? 90.0 : -90.0;

    for (var item in adjustedData) {
      final sweepAngle = (item.percentage * 360 * animationValue) - gap;

      if (sweepAngle > 0) {
        _drawSegmentWithEffects(canvas, size, item, startAngle, sweepAngle);
      }

      startAngle += sweepAngle + gap;
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
    if (item.boxShadows != null) {
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

  /// Draws box shadows for a segment
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

      // Offset the shadow
      final shadowRect = rect.shift(shadow.offset);

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

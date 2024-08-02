import 'package:flutter/material.dart';
import 'package:outline_pie_chart/src/pie_data_model.dart';

/// ## [PieChartPainter] Class Documentation
///
/// A custom painter for drawing a segmented, animated pie chart.
///
/// The `PieChartPainter` class is responsible for rendering pie chart segments
/// based on the provided data, with optional animation, gap spacing, and RTL support.
///
/// ### Parameters:
///
/// - **data** (`List<PieData>`):
///   A list of `PieData` objects representing each segment of the pie chart.
///   Each `PieData` contains a `percentage` and a `color`.
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
/// ### Methods:
///
/// - **paint** (`Canvas canvas, Size size`):
///   Draws the pie chart on the provided canvas, using the specified size. The method calculates
///   the start angle and sweep angle for each segment, taking into account RTL support and animation progress.
///
/// - **radians** (`double degrees`):
///   Converts degrees to radians for use in drawing arcs.
///
/// - **shouldRepaint** (`CustomPainter oldDelegate`):
///   Returns false to indicate that the painter does not need to repaint unless
///   the data or configuration changes.
///
/// ### Example:
/// ```dart
/// CustomPaint(
///   size: Size(200, 200),
///   painter: PieChartPainter(
///     data: [
///       PieData(percentage: 0.5, color: Colors.blue),
///       PieData(percentage: 0.3, color: Colors.red),
///       PieData(percentage: 0.2, color: Colors.green),
///     ],
///     strokeWidth: 15.0,
///     animationValue: 1.0,
///     gap: 4.0,
///     isRTL: false,
///   ),
/// );
/// ```
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
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 20.0;

    double startAngle = isRTL ? 90.0 : -90.0;

    for (var item in data) {
      final sweepAngle = (item.percentage * 360 * animationValue) - gap;
      paint.color = item.color;

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        radians(startAngle),
        radians(sweepAngle),
        false,
        paint,
      );

      startAngle += sweepAngle + gap;
    }
  }

  /// Converts degrees to radians for use in drawing arcs.
  double radians(double degrees) {
    return degrees * (3.1415926535897932 / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

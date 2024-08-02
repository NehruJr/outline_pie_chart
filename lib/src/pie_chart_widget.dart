import 'package:flutter/material.dart';

import '../outline_pie_chart.dart';

/// ## [PieChartWidget] Widget Documentation
///
/// A customizable pie chart widget with optional animation.
///
/// The `PieChartWidget` displays a pie chart with adjustable diameter, stroke width, animation options,
/// and supports RTL languages. You can customize the chart's appearance and behavior through
/// various parameters, including animation duration, segment gap, and more.
///
/// ### Parameters:
///
/// - **data** (`List<PieData>`):
///   A list of `PieData` objects representing the segments of the pie chart.
///   Each `PieData` includes a `percentage` and a `color` for the segment.
///
/// - **diameter** (`double`):
///   The diameter of the pie chart. Defaults to 220 pixels.
///
/// - **strokeWidth** (`double`):
///   The thickness of the pie chart's segments. Defaults to 20 pixels.
///
/// - **enableAnimation** (`bool`):
///   If true, enables the drawing animation of the pie chart. Defaults to true.
///
/// - **animationDuration** (`Duration?`):
///   Duration of the animation. If not specified, defaults to 1 second.
///
/// - **gap** (`double?`):
///   The gap between segments in degrees. If not specified, defaults to one-fourth of the `strokeWidth`.
///   The gap cannot exceed half of the `strokeWidth`.
///
/// - **child** (`Widget?`):
///   An optional widget to display in the center of the pie chart.
///
/// - **isRTL** (`bool?`):
///   If true, the pie chart is drawn from right to left. Defaults to false.
///
/// ### Example:
/// ```dart
/// PieChartWidget(
///   data: [
///     PieData(percentage: 0.4, color: Colors.blue),
///     PieData(percentage: 0.3, color: Colors.red),
///     PieData(percentage: 0.3, color: Colors.green),
///   ],
///   diameter: 250,
///   strokeWidth: 25,
///   enableAnimation: true,
///   animationDuration: Duration(seconds: 2),
///   gap: 6,
///   child: Text('Center Widget'),
///   isRTL: false,
/// );
/// ```
/// In this example, the `PieChartWidget` is configured with 40% blue, 30% red, and 30% green segments.
/// It features a diameter of 250 pixels, a stroke width of 25 pixels, a 2-second animation,
/// a 6-degree gap between segments, and a central widget displaying text.
///
/// ### Usage:
/// Import the package and use `PieChartWidget` to integrate a customizable pie chart into your Flutter application.
class PieChartWidget extends StatefulWidget {
  /// Creates a [PieChartWidget] with the specified parameters.
  const PieChartWidget({
    required this.data,
    this.diameter = 220,
    this.strokeWidth = 20,
    this.enableAnimation = true,
    this.animationDuration,
    this.gap,
    this.child,
    this.isRTL,
    super.key,
  });

  /// A list of `PieData` objects representing the segments of the pie chart.
  final List<PieData> data;

  /// The diameter of the pie chart. Defaults to 220 pixels.
  final double diameter;

  /// The thickness of the pie chart segments. Defaults to 20 pixels.
  final double strokeWidth;

  /// Whether to enable animation for drawing the pie chart. Defaults to true.
  final bool enableAnimation;

  /// Duration of the animation. Defaults to 1 second if not specified.
  final Duration? animationDuration;

  /// The gap between segments in degrees. Defaults to one-fourth of the stroke width.
  final double? gap;

  /// An optional widget to display in the center of the pie chart.
  final Widget? child;

  /// If true, draws the pie chart from right to left. Defaults to false.
  final bool? isRTL;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double _gap = 4;
  late List<PieData> adjustedData;

  @override
  void initState() {
    super.initState();
    if (widget.gap == null) {
      _gap = widget.strokeWidth / 4;
    } else {
      _gap = (widget.gap! > widget.strokeWidth / 2) ? widget.strokeWidth / 2 : widget.gap!;
    }

    adjustedData = adjustPercentages(widget.data);

    if (widget.enableAnimation) {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration ?? const Duration(seconds: 1),
      );

      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
      )..addListener(() {
          setState(() {});
        });

      _animationController!.forward();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 28),
      alignment: Alignment.center,
      child: CustomPaint(
        key: GlobalKey(),
        size: Size(widget.diameter - _gap, widget.diameter - _gap),
        foregroundPainter: PieChartPainter(
          data: adjustedData,
          strokeWidth: widget.strokeWidth,
          animationValue: _animation?.value ?? 1,
          gap: _gap,
          isRTL: widget.isRTL ?? false,
        ),
        child: Container(
          width: widget.diameter - _gap,
          height: widget.diameter - _gap,
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}

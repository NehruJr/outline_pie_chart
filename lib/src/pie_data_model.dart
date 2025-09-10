import 'package:flutter/material.dart';

/// ## [PieData] Class Documentation
///
/// A class representing a segment of a pie chart.
///
/// The `PieData` class encapsulates the information for a single segment of a pie chart,
/// including the segment's percentage of the whole pie and its color.
///
/// ### Fields:
///
/// - **percentage** (`double`):
///   The percentage of the pie chart represented by this segment. Must be a value between 0.0 and 1.0.
///
/// - **color** (`Color`):
///   The color of the segment. Used to visually differentiate the segment from others.
///
/// ### Example:
/// ```dart
/// PieData segment = PieData(
///   percentage: 0.25, // Represents 25% of the pie chart
///   color: Colors.blue, // Color of the segment
/// );
/// ```
/// In this example, the `PieData` instance represents a segment that covers 25% of the pie chart with a blue color.
class PieData {
  /// The percentage of the pie chart represented by this segment.
  /// Must be a value between 0.0 and 1.0.
  final double percentage;

  /// The color of the segment.
  /// Used to visually differentiate this segment from others in the pie chart.
  /// This color is used when no gradient is specified.
  final Color color;

  /// Optional gradient to apply to the segment.
  /// If provided, this takes precedence over the solid color.
  /// Supports LinearGradient, RadialGradient, and SweepGradient.
  final Gradient? gradient;

  /// Optional list of box shadows to apply to the segment.
  /// Each shadow can have different offset, blur radius, and color.
  final List<BoxShadow>? boxShadows;

  /// Optional border radius for rounded segment ends.
  /// If specified and greater than 0, the segment will have rounded caps.
  final double? borderRadius;

  /// Creates a `PieData` instance with the given percentage and visual properties.
  /// 
  /// Example with gradient:
  /// ```dart
  /// PieData(
  ///   percentage: 0.3,
  ///   color: Colors.blue,
  ///   gradient: LinearGradient(
  ///     colors: [Colors.blue, Colors.lightBlue],
  ///   ),
  ///   boxShadows: [
  ///     BoxShadow(
  ///       color: Colors.black26,
  ///       blurRadius: 4.0,
  ///       offset: Offset(2, 2),
  ///     ),
  ///   ],
  ///   borderRadius: 5.0,
  /// )
  /// ```
  PieData({
    required this.percentage,
    required this.color,
    this.gradient,
    this.boxShadows,
    this.borderRadius,
  });

  /// Creates a copy of this PieData with optionally overridden properties
  PieData copyWith({
    double? percentage,
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? boxShadows,
    double? borderRadius,
  }) {
    return PieData(
      percentage: percentage ?? this.percentage,
      color: color ?? this.color,
      gradient: gradient ?? this.gradient,
      boxShadows: boxShadows ?? this.boxShadows,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PieData &&
        other.percentage == percentage &&
        other.color == color &&
        other.gradient == gradient &&
        other.boxShadows == boxShadows &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return percentage.hashCode ^
        color.hashCode ^
        gradient.hashCode ^
        boxShadows.hashCode ^
        borderRadius.hashCode;
  }
}
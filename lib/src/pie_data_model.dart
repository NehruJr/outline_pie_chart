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
  final Color color;

  /// Creates a `PieData` instance with the given percentage and color.
  PieData({
    required this.percentage,
    required this.color,
  });
}

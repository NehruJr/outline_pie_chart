import '../outline_pie_chart.dart';

/// ## [adjustPercentages] Function Documentation
///
/// Adjusts the percentages of the pie chart segments to ensure their total does not exceed 100%.
///
/// This function takes a list of `PieData` objects and calculates the total percentage.
/// If the total percentage exceeds 100% (1.0), it normalizes the percentages
/// so that their sum equals exactly 100%. Each `PieData` object's percentage is scaled
/// down proportionally to fit within the 100% limit.
///
/// ### Parameters:
/// - `data` (`List<PieData>`): A list of `PieData` objects, each representing a segment
///   of the pie chart with a percentage and a color.
///
/// ### Returns:
/// - A new list of `PieData` objects with adjusted percentages if necessary.
///   If the total percentage was less than or equal to 100%, the original list is returned.
///
/// ### Example:
/// ```dart
/// List<PieData> data = [
///   PieData(percentage: 0.6, color: Colors.blue),
///   PieData(percentage: 0.5, color: Colors.red),
/// ];
///
/// List<PieData> adjustedData = adjustPercentages(data);
/// ```
/// In this example, the total percentage is 1.1 (110%). The function will
/// scale down the percentages so that they sum to 1.0 (100%).
///
List<PieData> adjustPercentages(List<PieData> data) {
  double totalPercentage = data.fold(0.0, (sum, item) => sum + item.percentage);
  if (totalPercentage > 1.0) {
    return data
        .map((item) => PieData(
              percentage: item.percentage / totalPercentage,
              color: item.color,
            ))
        .toList();
  }
  return data;
}

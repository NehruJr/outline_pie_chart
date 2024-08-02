<img alt="Flutter" src="https://img.shields.io/badge/Flutter-075898?style=flat-squar&logo=flutter&logoColor=white"/>

<p align="center">
  <img src="https://github.com/shervin-h/outline_pie_chart/blob/main/assets/demo.gif?raw=true" height="600">
</p>

# Outline Pie Chart

**Outline Pie Chart** is a Flutter package for creating beautiful, customizable, and animated pie charts. It supports segment gaps, RTL (right-to-left) languages, and provides various customization options to make your data visualization visually engaging and informative.

![Example Pie Chart](https://via.placeholder.com/600x400.png?text=Pie+Chart+Example)

### Where is it used?

- In applications that visualize performance metrics
- For displaying budget allocations and financial data
- In health and fitness apps to show progress
- In educational apps to illustrate progress or achievements
- In e-commerce apps to show category distributions

📊 📈 📉 🏅

## Features

- **Customizable Segments**: Define segment percentages and colors to represent your data.
- **Animated Drawing**: Optionally animate the pie chart drawing process for a dynamic presentation.
- **Segment Gaps**: Adjust the gap between segments to enhance chart clarity.
- **RTL Support**: Draw charts from right to left for RTL languages like Persian.
- **Center Widget**: Add a widget in the center of the pie chart for additional context or information.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  outline_pie_chart: ^0.0.1
```

Then run:

```
flutter pub get
```

## Usage

Import it

```dart
import 'package:outline_pie_chart/outline_pie_chart.dart';
```

Now in your flutter code, you can use:

The PieChartWidget to integrate a customizable pie chart into your Flutter application:

data (List<PieData>): List of PieData objects defining the pie chart segments.
diameter (double): Diameter of the pie chart. Defaults to 220.
strokeWidth (double): Thickness of the pie chart segments. Defaults to 20.
enableAnimation (bool): If true, enables drawing animation. Defaults to true.
animationDuration (Duration?): Duration of the animation. Defaults to 1 second.
gap (double?): Gap between segments in degrees. Defaults to one-fourth of the strokeWidth.
child (Widget?): Optional widget to display in the center.
isRTL (bool?): If true, draws the pie chart from right-to-left. Defaults to false.



<p align="center">
    <img alt="screenshot1" src="https://github.com/shervin-h/outline_pie_chart/blob/main/assets/Screenshot2.png?raw=true" height="400">
</p>

```dart
PieChartWidget(
  data: [
    PieData(percentage: 0.64, color: const Color(0xFFF0B800)),
    PieData(percentage: 0.36, color: const Color(0xFF5536BF)),
  ],
  diameter: 300,
  enableAnimation: true,
  animationDuration: const Duration(seconds: 2),
  strokeWidth: 40,
  gap: 4,
  isRTL: false,
  child: const Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text(
      'Total Asset Value',
      style: TextStyle(
        fontFamily: '',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF757575),
      ),
    ),
    SizedBox(height: 8),
    Text(
      '2,798,625',
      style: TextStyle(
        fontFamily: '',
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Color(0xFF1C1C1E),
     ),
   ),
   Text(
     '\$',
     style: TextStyle(
        fontFamily: '',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1C1C1E),
      ),
     ),
   ],
  ),
);
```

### by Shervin Hassanzadeh

Contact me at
<br>

  <a href="https://www.linkedin.com/in/shervin-hassanzadeh/">
    <img alt="linkedin" src="https://img.shields.io/badge/linkedin-0077B5.svg?style=flat-squar&logo=linkedin&logoColor=white"/>
  </a>
  <a href="mailto:shervin.hz07@gmail.com">
    <img alt="Email" src="https://img.shields.io/badge/Email-D14836?style=flat-squar&logo=gmail&logoColor=white"/>
  </a>
  <a href="https://t.me/shervin_hz07">
    <img alt="telegram" src="https://img.shields.io/badge/Telegram-2B9FD1?style=flat-squar&logo=telegram&logoColor=white" />
  </a>
  <a href="https://github.com/shervin-h">
    <img alt="github" src="https://img.shields.io/badge/github-121011.svg?style=flat-squar&logo=github&logoColor=white"/>
  </a>
  <a href="https://stackoverflow.com/users/13066224/shervin">
    <img alt="stackoverflow" src="https://img.shields.io/badge/Stackoverflow-ef8236?style=flat-squar&logo=stackoverflow&logoColor=white" />
  </a>

<br>
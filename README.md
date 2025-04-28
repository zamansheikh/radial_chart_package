# Radial Chart Package

A reusable, interactive radial chart widget for Flutter. Supports dynamic thickness, animated selection, and custom labels.

## 📸 Preview
<img src="https://github.com/zamansheikh/radial_chart_package/blob/main/repo_files/demo.png?raw=true" width="40%" />

## 🚀 Features

- Dynamic segment thickness based on percentage
- Animated segment selection
- Optional labels
- Configurable center radius, gap, and outer size

## 🛠 Usage

```dart
RadialPerformanceChart(
  radius: 150,
  segments: [
    SegmentData(percentage: 72, color: Colors.blue, label: "72%"),
    SegmentData(percentage: 100, color: Colors.amber, label: "100%"),
    // ...
  ],
)
```
- `radius`: The radius of the chart.
- `segments`: A list of `SegmentData` objects, each representing a segment of the chart.
- `percentage`: The percentage of the segment (0-100).
- `label`: The label for the segment (optional).
- `gapPercentage`: The gap between segments (0-0.20).
- `centerCircleRadius`: The radius of the center circle (0-1).
- `backgroundColor`: The background color of the chart.
- `segmentHeight`: The height of the segments.

```dart
 RadialPerformanceChart(
    backgroundColor: Colors.black,
    centerCircleRadius: 0.30,
    gapPercentage: 0.005,
    segmentHeight: 1.5,
    radius: 150,
    segments: [
      SegmentData(percentage: 72, color: Colors.blue, label: "blue"),
      SegmentData(percentage: 100, color: Colors.amber, label: "amber"),
      SegmentData(percentage: 65, color: Colors.red, label: "red"),
      SegmentData(percentage: 50, color: Colors.green, label: "green"),
      // Add more segments as needed
    ],
  ),
```

## 📦 Installation
Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  radial_chart_package: latest
```

Then, run `flutter pub get` to install the package.

## 🔗 GitHub Repository
Find the source code and contribute to the project here: [Radial Chart Package Repository](https://github.com/zamansheikh/radial_chart_package)

## 🤝 Contributing

Contributions are welcome! If you'd like to improve this package, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them with clear messages.
4. Push your branch to your forked repository.
5. Open a pull request to the main branch of this repository.

Please ensure your code follows the existing style and includes tests where applicable. For major changes, consider opening an issue first to discuss your ideas.
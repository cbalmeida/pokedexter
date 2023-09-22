extension DoubleExtension on double {
  String get metersToMetersOrCentimeters {
    if (this >= 10.0) {
      return '${toStringAsFixed(1)}m'.replaceAll(".0", "");
    } else {
      double centimeters = this * 100;
      return '${centimeters.toStringAsFixed(1)}cm'.replaceAll(".0", "");
    }
  }
}

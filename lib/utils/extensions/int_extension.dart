extension IntExtension on int {
  String get asPokemonIdNumber {
    return "#${toString().padLeft(3, '0')}";
  }

  String get metersToMetersOrCentimeters {
    if (this >= 10.0) {
      return '${toStringAsFixed(1)}m'.replaceAll(".0", "");
    } else {
      double centimeters = this * 100;
      return '${centimeters.toStringAsFixed(1)}cm'.replaceAll(".0", "");
    }
  }

  String get asBytes {
    if (this < 1024) {
      return '$this B';
    } else if (this < 1024 * 1024) {
      return '${(this / 1024).toStringAsFixed(2)} KB';
    } else if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }
}

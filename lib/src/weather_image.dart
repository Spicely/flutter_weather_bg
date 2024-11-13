part of '../weather_animation.dart';

class WeatherImage {
  /// 云
  final ui.Image cloud;

  /// 闪电
  final ui.Image lightning0;
  final ui.Image lightning1;
  final ui.Image lightning2;
  final ui.Image lightning3;
  final ui.Image lightning4;
  final ui.Image rain;

  final ui.Image snow;
  final ui.Image sun;

  WeatherImage({
    required this.cloud,
    required this.lightning0,
    required this.lightning1,
    required this.lightning2,
    required this.lightning3,
    required this.lightning4,
    required this.rain,
    required this.snow,
    required this.sun,
  });
}

part of '../weather_animation.dart';

enum WeatherType {
  heavyRainy,
  heavySnow,
  middleSnow,
  thunder,
  lightRainy,
  lightSnow,
  sunnyNight,
  sunny,

  /// 多云
  cloudy,

  /// 多云晚上
  cloudyNight,
  middleRainy,
  overcast,

  /// 霾
  hazy,

  /// 雾
  foggy,

  /// 浮尘
  dusty,
}

/// 数据加载状态
enum WeatherDataState {
  /// 初始化
  init,

  /// 正在加载
  loading,

  /// 加载结束
  finish,
}

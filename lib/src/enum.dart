part of '../weather_animation.dart';

enum WeatherType {
  /// 大雪
  heavySnow,

  /// 中雪
  middleSnow,

  /// 小雪
  lightSnow,

  /// 大雨
  heavyRainy,

  /// 小雨
  lightRainy,

  /// 雷阵雨
  thunder,

  /// 晚上晴
  sunnyNight,

  /// 晴
  sunny,

  /// 多云
  cloudy,

  /// 多云晚上
  cloudyNight,

  /// 中雨
  middleRainy,

  /// 阴
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

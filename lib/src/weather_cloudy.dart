part of '../weather_animation.dart';

class _CloudAnimation extends StatefulWidget {
  final WeatherImage weatherImage;

  final WeatherType weatherType;

  const _CloudAnimation({required this.weatherImage, this.weatherType = WeatherType.sunny});

  @override
  State<_CloudAnimation> createState() => _CloudAnimationState();
}

class _CloudAnimationState extends State<_CloudAnimation> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          WeatherBgColor(weatherType: widget.weatherType),
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: CloudPainter(weatherType: widget.weatherType, weatherImage: widget.weatherImage),
          ),
          _buildRainSnowBg(),
          _buildThunderBg(),
          _buildNightStarBg(),
        ],
      ),
    );
  }

  /// 构建晴晚背景效果
  Widget _buildNightStarBg() {
    if (widget.weatherType == WeatherType.sunnyNight) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return WeatherNightStarBg(weatherType: widget.weatherType, width: constraints.maxWidth, height: constraints.maxHeight);
        },
      );
    }
    return Container();
  }

  /// 构建雷暴效果
  Widget _buildThunderBg() {
    if (widget.weatherType == WeatherType.thunder) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return WeatherThunderBg(weatherType: widget.weatherType, weatherImage: widget.weatherImage, width: constraints.maxWidth, height: constraints.maxHeight);
        },
      );
    }
    return Container();
  }

  /// 构建雨雪背景效果
  Widget _buildRainSnowBg() {
    if (_Utils.isSnowRain(widget.weatherType)) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return WeatherRainSnowBg(
            weatherType: widget.weatherType,
            viewHeight: constraints.maxHeight,
            weatherImage: widget.weatherImage,
            viewWidth: constraints.maxWidth,
          );
        },
      );
    }
    return Container();
  }
}

class CloudPainter extends CustomPainter {
  final _paint = Paint();

  final WeatherImage weatherImage;

  final WeatherType weatherType;

  late double widthRatio;

  CloudPainter({required this.weatherImage, required this.weatherType});

  @override
  void paint(Canvas canvas, Size size) {
    widthRatio = size.width / 392.0;
    switch (weatherType) {
      case WeatherType.sunny:
        drawSunny(canvas, size);
        break;
      case WeatherType.cloudy:
        drawCloudy(canvas, size);
        break;
      case WeatherType.cloudyNight:
        drawCloudyNight(canvas, size);
        break;
      case WeatherType.overcast:
        drawOvercast(canvas, size);
        break;
      case WeatherType.lightRainy:
        drawLightRainy(canvas, size);
        break;
      case WeatherType.middleRainy:
        drawMiddleRainy(canvas, size);
        break;
      case WeatherType.heavyRainy:
      case WeatherType.thunder:
        drawHeavyRainy(canvas, size);
        break;
      case WeatherType.hazy:
        drawHazy(canvas, size);
        break;
      case WeatherType.foggy:
        drawFoggy(canvas, size);
        break;
      case WeatherType.lightSnow:
        drawLightSnow(canvas, size);
        break;
      case WeatherType.middleSnow:
        drawMiddleSnow(canvas, size);
        break;
      case WeatherType.heavySnow:
        drawHeavySnow(canvas, size);
        break;
      case WeatherType.dusty:
        drawDusty(canvas, size);
        break;
      default:
        break;
    }
  }

  /// 绘制阳光
  void drawSunny(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    ui.Image image1 = weatherImage.sun;
    _paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    canvas.save();
    final sunScale = 1.2 * widthRatio;
    canvas.scale(sunScale, sunScale);
    var offset = Offset(size.width - image1.width.toDouble() * sunScale, -image1.width.toDouble() / 2);
    canvas.drawImage(image1, offset, _paint);
    canvas.restore();

    canvas.save();
    final scale = 0.6 * widthRatio;
    ui.Offset offset1 = const ui.Offset(-100, -100);
    canvas.scale(scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  void drawCloudy(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.9, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(0, -200);
    ui.Offset offset2 = ui.Offset(-image.width / 2, -130);
    ui.Offset offset3 = const ui.Offset(100, 0);
    canvas.scale(scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  /// 绘制多云的夜晚效果
  void drawCloudyNight(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.32, 0, 0, 0, 0, 0, 0.39, 0, 0, 0, 0, 0, 0.52, 0, 0, 0, 0, 0, 0.9, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(0, -200);
    ui.Offset offset2 = ui.Offset(-image.width / 2, -130);
    ui.Offset offset3 = const ui.Offset(100, 0);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  /// 绘制阴天
  void drawOvercast(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.7, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(0, -200);
    ui.Offset offset2 = ui.Offset(-image.width / 2, -130);
    ui.Offset offset3 = const ui.Offset(100, 0);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  /// 绘制小雨效果
  void drawLightRainy(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.45, 0, 0, 0, 0, 0, 0.52, 0, 0, 0, 0, 0, 0.6, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(-380, -150);
    ui.Offset offset2 = const ui.Offset(0, -60);
    ui.Offset offset3 = const ui.Offset(0, 60);
    canvas.scale(scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  /// 绘制霾逻辑
  void drawHazy(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.67, 0, 0, 0, 0, 0, 0.67, 0, 0, 0, 0, 0, 0.67, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 2.0 * widthRatio;
    ui.Offset offset1 = ui.Offset(-image.width.toDouble() * 0.5, -200);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  /// 绘制雾
  void drawFoggy(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.75, 0, 0, 0, 0, 0, 0.77, 0, 0, 0, 0, 0, 0.82, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 2.0 * widthRatio;
    ui.Offset offset1 = ui.Offset(-image.width.toDouble() * 0.5, -200);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  /// 绘制浮尘
  void drawDusty(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.62, 0, 0, 0, 0, 0, 0.55, 0, 0, 0, 0, 0, 0.45, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 2.0 * widthRatio;
    ui.Offset offset1 = ui.Offset(-image.width.toDouble() * 0.5, -200);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  /// 绘制大雨
  void drawHeavyRainy(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.19, 0, 0, 0, 0, 0, 0.2, 0, 0, 0, 0, 0, 0.22, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(-380, -150);
    ui.Offset offset2 = const ui.Offset(0, -60);
    ui.Offset offset3 = const ui.Offset(0, 60);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  /// 绘制中雨
  void drawMiddleRainy(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.16, 0, 0, 0, 0, 0, 0.22, 0, 0, 0, 0, 0, 0.31, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(-380, -150);
    ui.Offset offset2 = const ui.Offset(0, -60);
    ui.Offset offset3 = const ui.Offset(0, 60);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  /// 绘制小雪
  void drawLightSnow(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.67, 0, 0, 0, 0, 0, 0.75, 0, 0, 0, 0, 0, 0.87, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(-380, -100);
    ui.Offset offset2 = const ui.Offset(0, -170);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.restore();
  }

  /// 绘制中雪
  void drawMiddleSnow(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.7, 0, 0, 0, 0, 0, 0.77, 0, 0, 0, 0, 0, 0.87, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(-380, -100);
    ui.Offset offset2 = const ui.Offset(0, -170);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.restore();
  }

  /// 绘制大雪
  void drawHeavySnow(Canvas canvas, Size size) {
    ui.Image image = weatherImage.cloud;
    canvas.save();
    const identity = ColorFilter.matrix(<double>[0.74, 0, 0, 0, 0, 0, 0.74, 0, 0, 0, 0, 0, 0.81, 0, 0, 0, 0, 0, 1, 0]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = const ui.Offset(-380, -100);
    ui.Offset offset2 = const ui.Offset(0, -170);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

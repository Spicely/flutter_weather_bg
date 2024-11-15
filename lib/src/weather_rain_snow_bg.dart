// ignore_for_file: library_private_types_in_public_api

part of '../weather_animation.dart';

//// 雨雪动画层
class _WeatherRainSnowBg extends StatefulWidget {
  final WeatherType weatherType;

  final _WeatherImage weatherImage;

  final double viewWidth;

  final double viewHeight;

  const _WeatherRainSnowBg({required this.weatherType, required this.weatherImage, required this.viewWidth, required this.viewHeight});

  @override
  State<_WeatherRainSnowBg> createState() => _WeatherRainSnowBgState();
}

class _WeatherRainSnowBgState extends State<_WeatherRainSnowBg> with SingleTickerProviderStateMixin {
  final List<ui.Image> _images = [];

  late AnimationController _controller;

  final List<RainSnowParams> _rainSnows = [];

  int count = 0;

  WeatherDataState? _state;

  /// 异步获取雨雪的图片资源和初始化数据
  Future<void> fetchImages() async {
    _images.clear();
    _images.add(widget.weatherImage.rain);
    _images.add(widget.weatherImage.snow);
    _state = WeatherDataState.init;
    setState(() {});
  }

  /// 初始化雨雪参数
  Future<void> initParams() async {
    _state = WeatherDataState.loading;
    if (widget.viewWidth != 0 && widget.viewHeight != 0 && _rainSnows.isEmpty) {
      debugPrint("开始雨参数初始化 ${_rainSnows.length}， weatherType: ${widget.weatherType}, isRainy: ${WeatherUtils.isRainy(widget.weatherType)}");
      if (WeatherUtils.isSnowRain(widget.weatherType)) {
        if (widget.weatherType == WeatherType.lightRainy) {
          count = 70;
        } else if (widget.weatherType == WeatherType.middleRainy) {
          count = 100;
        } else if (widget.weatherType == WeatherType.heavyRainy || widget.weatherType == WeatherType.thunder) {
          count = 200;
        } else if (widget.weatherType == WeatherType.lightSnow) {
          count = 30;
        } else if (widget.weatherType == WeatherType.middleSnow) {
          count = 100;
        } else if (widget.weatherType == WeatherType.heavySnow) {
          count = 200;
        }
        var widthRatio = widget.viewWidth / 392.0;
        var heightRatio = widget.viewHeight / 817;
        for (int i = 0; i < count; i++) {
          var rainSnow = RainSnowParams(widget.viewWidth, widget.viewHeight, widget.weatherType);
          rainSnow.init(widthRatio, heightRatio);
          _rainSnows.add(rainSnow);
        }
        debugPrint("初始化雨参数成功 ${_rainSnows.length}");
      }
    }
    _controller.forward();
    _state = WeatherDataState.finish;
  }

  @override
  void didUpdateWidget(_WeatherRainSnowBg oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weatherType != widget.weatherType || oldWidget.viewWidth != widget.viewWidth || oldWidget.viewHeight != widget.viewHeight) {
      _rainSnows.clear();
      initParams();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(minutes: 1), vsync: this);
    CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
    fetchImages();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == WeatherDataState.init) {
      initParams();
    } else if (_state == WeatherDataState.finish) {
      return CustomPaint(
        painter: RainSnowPainter(this),
      );
    }
    return Container();
  }
}

class RainSnowPainter extends CustomPainter {
  final _paint = Paint();
  final _WeatherRainSnowBgState _state;

  RainSnowPainter(this._state);

  @override
  void paint(Canvas canvas, Size size) {
    if (WeatherUtils.isSnow(_state.widget.weatherType)) {
      drawSnow(canvas, size);
    } else if (WeatherUtils.isRainy(_state.widget.weatherType)) {
      drawRain(canvas, size);
    }
  }

  void drawRain(Canvas canvas, Size size) {
    if (_state._images.length > 1) {
      ui.Image image = _state._images[0];
      if (_state._rainSnows.isNotEmpty) {
        for (var element in _state._rainSnows) {
          move(element);
          ui.Offset offset = ui.Offset(element.x, element.y);
          canvas.save();
          canvas.scale(element.scale);
          var identity = ColorFilter.matrix(<double>[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, element.alpha, 0]);
          _paint.colorFilter = identity;
          canvas.drawImage(image, offset, _paint);
          canvas.restore();
        }
      }
    }
  }

  void move(RainSnowParams params) {
    params.y = params.y + params.speed;
    if (WeatherUtils.isSnow(_state.widget.weatherType)) {
      double offsetX = sin(params.y / (300 + 50 * params.alpha)) * (1 + 0.5 * params.alpha) * params.widthRatio;
      params.x += offsetX;
    }
    if (params.y > params.height / params.scale) {
      params.y = -params.height * params.scale;
      if (WeatherUtils.isRainy(_state.widget.weatherType) && _state._images.isNotEmpty) {
        params.y = -_state._images[0].height.toDouble();
      }
      params.reset();
    }
  }

  void drawSnow(Canvas canvas, Size size) {
    if (_state._images.length > 1) {
      ui.Image image = _state._images[1];
      if (_state._rainSnows.isNotEmpty) {
        for (var element in _state._rainSnows) {
          move(element);
          ui.Offset offset = ui.Offset(element.x, element.y);
          canvas.save();
          canvas.scale(element.scale, element.scale);
          var identity = ColorFilter.matrix(<double>[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, element.alpha, 0]);
          _paint.colorFilter = identity;
          canvas.drawImage(image, offset, _paint);
          canvas.restore();
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RainSnowParams {
  /// x 坐标
  double x;

  /// y 坐标
  double y;

  /// 下落速度
  double speed;

  /// 绘制的缩放
  double scale;

  /// 宽度
  double width;

  /// 高度
  double height;

  /// 透明度
  double alpha;

  /// 天气类型
  WeatherType weatherType;

  double widthRatio;
  double heightRatio;

  RainSnowParams(this.width, this.height, this.weatherType, {this.x = 0, this.y = 0, this.speed = 1, this.scale = 1, this.alpha = 1, this.widthRatio = 1, this.heightRatio = 1});

  void init(widthRatio, heightRatio) {
    this.widthRatio = widthRatio;
    this.heightRatio = max(heightRatio, 0.65);

    /// 雨 0.1 雪 0.5
    reset();
    y = Random().nextInt(800 ~/ scale).toDouble();
  }

  /// 当雪花移出屏幕时，需要重置参数
  void reset() {
    double ratio = 1.0;

    if (weatherType == WeatherType.lightRainy) {
      ratio = 0.5;
    } else if (weatherType == WeatherType.middleRainy) {
      ratio = 0.75;
    } else if (weatherType == WeatherType.heavyRainy || weatherType == WeatherType.thunder) {
      ratio = 1;
    } else if (weatherType == WeatherType.lightSnow) {
      ratio = 0.5;
    } else if (weatherType == WeatherType.middleSnow) {
      ratio = 0.75;
    } else if (weatherType == WeatherType.heavySnow) {
      ratio = 1;
    }
    if (WeatherUtils.isRainy(weatherType)) {
      double random = 0.4 + 0.12 * Random().nextDouble() * 5;
      scale = random * 1.2;
      speed = 30 * random * ratio * heightRatio;
      alpha = random * 0.6;
      x = Random().nextInt(width * 1.2 ~/ scale).toDouble() - width * 0.1 ~/ scale;
    } else {
      double random = 0.4 + 0.12 * Random().nextDouble() * 5;
      scale = random * 0.8 * heightRatio;
      speed = 8 * random * ratio * heightRatio;
      alpha = random;
      x = Random().nextInt(width * 1.2 ~/ scale).toDouble() - width * 0.1 ~/ scale;
    }
  }
}

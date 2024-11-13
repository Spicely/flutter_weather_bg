part of '../weather_animation.dart';

class WrapperScene extends StatefulWidget {
  final WeatherType weatherType;

  const WrapperScene({
    super.key,
    this.weatherType = WeatherType.cloudy,
  });

  @override
  State<WrapperScene> createState() => _WrapperSceneState();
}

class _WrapperSceneState extends State<WrapperScene> {
  Future<WeatherImage>? _fetchImages;

  /// 异步获取雷暴图片资源
  Future<WeatherImage> fetchImages() async {
    debugPrint('开始获取图片');
    List<ui.Image> images = await Future.wait<ui.Image>([
      _Utils.load('images/cloud.webp'),
      _Utils.load('images/lightning0.webp'),
      _Utils.load('images/lightning1.webp'),
      _Utils.load('images/lightning2.webp'),
      _Utils.load('images/lightning3.webp'),
      _Utils.load('images/lightning4.webp'),
      _Utils.load('images/rain.webp'),
      _Utils.load('images/snow.webp'),
      _Utils.load('images/sun.webp'),
    ]);
    debugPrint('获取图片完成');
    return WeatherImage(
      cloud: images[0],
      lightning0: images[1],
      lightning1: images[2],
      lightning2: images[3],
      lightning3: images[4],
      lightning4: images[5],
      rain: images[6],
      snow: images[7],
      sun: images[8],
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchImages = fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchImages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _CloudAnimation(weatherImage: snapshot.data as WeatherImage, weatherType: widget.weatherType);
        } else {
          return Container();
        }
      },
    );
  }
}

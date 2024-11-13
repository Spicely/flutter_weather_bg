part of '../weather_animation.dart';

class WeatherScene extends StatefulWidget {
  final WeatherType weatherType;

  const WeatherScene({
    super.key,
    this.weatherType = WeatherType.cloudy,
  });

  @override
  State<WeatherScene> createState() => _WeatherSceneState();
}

class _WeatherSceneState extends State<WeatherScene> {
  Future<_WeatherImage>? _fetchImages;

  /// 异步获取雷暴图片资源
  Future<_WeatherImage> fetchImages() async {
    if (WeatherUtils._weatherImage == null) {
      debugPrint('开始获取图片');
      List<ui.Image> images = await Future.wait<ui.Image>([
        WeatherUtils.load('images/cloud.webp'),
        WeatherUtils.load('images/lightning0.webp'),
        WeatherUtils.load('images/lightning1.webp'),
        WeatherUtils.load('images/lightning2.webp'),
        WeatherUtils.load('images/lightning3.webp'),
        WeatherUtils.load('images/lightning4.webp'),
        WeatherUtils.load('images/rain.webp'),
        WeatherUtils.load('images/snow.webp'),
        WeatherUtils.load('images/sun.webp'),
      ]);
      debugPrint('获取图片完成');
      WeatherUtils._weatherImage = _WeatherImage(
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
      return WeatherUtils._weatherImage!;
    }
    debugPrint('返回缓存文件');
    return WeatherUtils._weatherImage!;
  }

  @override
  void initState() {
    super.initState();
    _fetchImages = fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_WeatherImage>(
      future: _fetchImages,
      initialData: WeatherUtils._weatherImage,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _CloudAnimation(weatherImage: snapshot.data!, weatherType: widget.weatherType);
        } else {
          return Container();
        }
      },
    );
  }
}

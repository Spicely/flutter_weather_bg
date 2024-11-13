part of '../weather_animation.dart';

class _WeatherBgColor extends StatelessWidget {
  final WeatherType weatherType;

  const _WeatherBgColor({required this.weatherType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: WeatherUtils.getColor(weatherType),
          stops: const [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

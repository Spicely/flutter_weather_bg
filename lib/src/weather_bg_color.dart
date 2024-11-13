part of '../weather_animation.dart';

class WeatherBgColor extends StatelessWidget {
  final WeatherType weatherType;

  const WeatherBgColor({super.key, required this.weatherType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _Utils.getColor(weatherType),
          stops: const [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

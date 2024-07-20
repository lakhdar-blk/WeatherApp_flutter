class Weather {
  final String cityname;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double wind_speed;

  Weather(
      {required this.cityname,
      required this.temperature,
      required this.mainCondition,
      required this.humidity,
      required this.wind_speed});

  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
        cityname: json['name'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        humidity: json['main']['humidity'],
        wind_speed: json['wind']['speed'].toDouble());
  }
}

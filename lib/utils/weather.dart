import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/utils/location.dart';
import 'package:http/http.dart';
import 'dart:convert';

const apiKey = '4e74331de9a3eb64659ad5a484a0a420';

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
}

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  double currentTemperature;
  int currentCondition;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        print(currentTemperature);
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.moon,
            size: 75.0,
            color: Colors.white,
          ),
          weatherImage: AssetImage('assets/images/cloudy.jpg'));
    } else {
      var now = new DateTime.now();

      if (now.hour >= 17) {
        return WeatherDisplayData(
            weatherImage: AssetImage('assets/images/night.jpg'),
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75.0,
              color: Colors.white,
            ));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/images/sunny2.jpg'));
      }
    }
  }
}

class WeatherDataByCity {
  WeatherDataByCity();
  String city;
  String cityDescription;
  double cityTemperature;
  int cityCondition;

  Future<void> getCityTemperature(city) async {
    Response responseCity = await get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${apiKey}&units=metric'));

    if (responseCity.statusCode == 200) {
      String data = responseCity.body;
      var currentCityWeather = jsonDecode(data);

      try {
        cityTemperature = currentCityWeather['main']['temp'];
        cityCondition = currentCityWeather['weather'][0]['id'];
        cityDescription = currentCityWeather['weather'][0]['description'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }
}

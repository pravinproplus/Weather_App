class WeatherData {
  String getWeathericon(int condition) {
    if (condition < 300) {
      return 'http://openweathermap.org/img/wn/11d@2x.png';
    } else if (condition < 400) {
      return 'http://openweathermap.org/img/wn/09d@2x.png';
    } else if (condition < 600) {
      return 'http://openweathermap.org/img/wn/10d@2x.png';
    } else if (condition < 700) {
      return 'http://openweathermap.org/img/wn/13d@2x.png';
    } else if (condition < 800) {
      return 'http://openweathermap.org/img/wn/50d@2x.png';
    } else if (condition == 800) {
      return 'http://openweathermap.org/img/wn/01d@2x.png';
    } else if (condition == 801) {
      return 'http://openweathermap.org/img/wn/02d@2x.png';
    } else if (condition == 802) {
      return 'http://openweathermap.org/img/wn/03d@2x.png';
    } else if (condition == 803) {
      return 'http://openweathermap.org/img/wn/04d@2x.png';
    } else if (condition == 804) {
      return 'http://openweathermap.org/img/wn/04d@2x.png';
    } else {
      return 'http://openweathermap.org/img/wn/03d@2x.png';
    }
  }
}

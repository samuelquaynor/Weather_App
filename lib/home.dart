import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utils/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.weatherData}) : super(key: key);
  final WeatherData weatherData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          bottom: _height / 2.4,
          child: Image(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
          height: _height,
        ),
        Positioned(
            bottom: 0,
            child: Container(
              height: _height / 2.4,
              width: _width,
              color: Color(0xFF2D2C35),
            )),
        Foreground(temperature: temperature)
      ],
    );
  }
}

class Foreground extends StatelessWidget {
  Foreground({this.temperature});

  final int temperature;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    var inputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ));
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          // leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          // actions: [
          //   IconButton(
          //       icon: CircleAvatar(
          //         backgroundImage: NetworkImage(
          //             'https://i.ibb.co/Z1fYsws/profile-image.jpg'),
          //         backgroundColor: Colors.black26,
          //       ),
          //       onPressed: () {})
          // ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: DefaultTextStyle(
                  style: GoogleFonts.raleway(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Location',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$temperature°',
                            style: TextStyle(
                                fontSize: 65, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 65,
                      ),
                      Text(
                        'Check the weather by the city',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onSubmitted: (text) {
                          getCityWeatherData(text);
                        },
                        decoration: InputDecoration(
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            hintText: 'Search City',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Locations(),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: _height * 0.35,
                        child: locations.length == 0
                            ? Column(
                                children: [
                                  Text(
                                    'Add Locations By Searching',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black45,
                                                    BlendMode.darken),
                                                child: Image(
                                                  width: 200,
                                                  height: 300,
                                                  image:
                                                      locations[index].imageUrl,
                                                  fit: BoxFit.cover,
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  locations[index].text,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                // Text(locations[index].timing),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                Text(
                                                  locations[index]
                                                          .temperature
                                                          .toString() +
                                                      '°',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Text(
                                                  locations[index].weather,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                itemCount:
                                    null == locations ? 0 : locations.length,
                                scrollDirection: Axis.horizontal,
                              ),
                      )
                      // LocationRow(height: _height)
                    ],
                  ),
                ))));
  }
}

class LocationRow extends StatelessWidget {
  const LocationRow({
    Key key,
    @required double height,
  })  : _height = height,
        super(key: key);

  final double _height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black45, BlendMode.darken),
                          child: Image.network(
                            locations[index].imageUrl,
                            height: _height * 0.35,
                          )),
                      Column(
                        children: [
                          Text(
                            locations[index].text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(locations[index].timing),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            locations[index].temperature.toString() + '°',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(locations[index].weather)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          itemCount: null == locations ? 0 : locations.length,
        ))
      ],
    );
  }
}

class Locations extends StatelessWidget {
  const Locations({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My locations',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          child: Icon(Icons.more_horiz),
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(width: 1, color: Colors.white),
            shape: CircleBorder(),
          ),
        )
      ],
    );
  }
}

class Location {
  final String text;
  final String timing;
  final String weather;
  final AssetImage imageUrl;
  final int temperature;

  Location(
      {this.temperature, this.text, this.timing, this.weather, this.imageUrl});
}

final locations = [];

void getCityWeatherData(String cityName) async {
  WeatherDataByCity cityData = WeatherDataByCity();
  await cityData.getCityTemperature(cityName);

  if (cityData.cityTemperature == null || cityData.cityCondition == null) {
    print('City Data is empty');
  } else {
    locations.add(Location(
      temperature: cityData.cityTemperature.round(),
      text: cityName.toUpperCase(),
      timing: '7:44 am',
      weather: cityData.cityDescription.toUpperCase(),
      imageUrl: AssetImage('assets/images/sunny.jpg'),
    ));
  }
}

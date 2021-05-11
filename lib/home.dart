import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          bottom: _height / 2.4,
          child: Image.network('https://i.ibb.co/Y2CNM8V/new-york.jpg'),
          height: _height,
        ),
        Positioned(
            bottom: 0,
            child: Container(
              height: _height / 2.4,
              width: _width,
              color: Color(0xFF2D2C35),
            )),
        Foreground()
      ],
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({
    Key key,
  }) : super(key: key);

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
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: [
          IconButton(
              icon: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://i.ibb.co/Z1fYsws/profile-image.jpg'),
                backgroundColor: Colors.black26,
              ),
              onPressed: () {})
        ],
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
                    height: 50,
                  ),
                  Text(
                    'Hello Samuel',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Check the weather by the city',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextField(
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
                    height: 110,
                  ),
                  Locations(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var location in locations)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black45, BlendMode.darken),
                                  child: Image.network(
                                    location.imageUrl,
                                    height: _height * 0.35,
                                  )),
                              Column(
                                children: [
                                  Text(
                                    location.text,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(location.timing),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    location.temperature.toString() + '°',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(location.weather)
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  )
                ],
              ),
            )),
      ),
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
  final String imageUrl;
  final int temperature;

  Location(
      {this.temperature, this.text, this.timing, this.weather, this.imageUrl});
}

final locations = [
  Location(
    text: 'New York',
    timing: '10:44 am',
    temperature: 15,
    weather: 'Cloudy',
    imageUrl: 'https://i.ibb.co/df35Y8Q/2.png',
  ),
  Location(
    text: 'San Francisco',
    timing: '7:44 am',
    temperature: 6,
    weather: 'Raining',
    imageUrl: 'https://i.ibb.co/7WyTr6q/3.png',
  ),
];

// class StackWidget extends StatelessWidget {
//   const StackWidget({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Image.network(
//           locations.imageUrl,
//           height: height,
//         )
//       ],
//     );
//   }
// }

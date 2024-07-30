import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
const key='//use your own key';
class display extends StatefulWidget {
  display({this.alldata});
  final alldata;
  @override
  State<display> createState() => _displayState();
}

class _displayState extends State<display> {
  var lat;
  var lon;
  String city = '';
  String temp = '';
  var des;
  String max = '';
  String min = '';
  String pre = 'Pressure:  ';
  String hum = 'Humidity:  ';
  String vis = 'Visibility:  ';
  String wsp = 'Wind Speed:  ';
  String deg = 'Wind Degree:  ';
  String clo = 'Cloudiness:  ';
  var wde;
  String flk = 'Feels Like:  ';
  var t;
  int time=0;
  void initState() {
    super.initState();
    datas(widget.alldata);
  }

  void datas(dynamic values) {
    setState(() {
      final now = DateTime.now();
      final formatter = DateFormat('HH');
      t=formatter.format(now);
      time=int.parse(t);
      city = jsonDecode(values)['name'];
      var temp1 = jsonDecode(values)['main']['temp'];
      temp = temp1.toString() + ' °C';
      des = jsonDecode(values)['weather'][0]['main'];
      var max1 = jsonDecode(values)['main']['temp_max'];
      max = max1.toString() + ' °C';
      var min1 = jsonDecode(values)['main']['temp_min'];
      min = min1.toString() + ' °C';
      var pre1 = jsonDecode(values)['main']['pressure'];
      pre = pre + pre1.toString();
      var hum1 = jsonDecode(values)['main']['humidity'];
      hum = hum + hum1.toString();
      var vis1 = jsonDecode(values)['visibility'];
      vis = vis + vis1.toString() + ' m';
      var wsp1 = jsonDecode(values)['wind']['speed'];
      wsp = wsp + wsp1.toString();
      var deg1 = jsonDecode(values)['wind']['deg'];
      deg = deg + deg1.toString();
      var clo1 = jsonDecode(values)['clouds']['all'];
      clo = clo + clo1.toString() + '%';
      wde = jsonDecode(values)['weather'][0]['description'];
      var flk1 = jsonDecode(values)['main']['feels_like'];
      flk = flk + flk1.toString() + ' °C';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  (time>=06 && time<=16)?AssetImage('images/sun.jpg'):(time>=17 && time<=19)?AssetImage('images/evening.jpg'):AssetImage('images/night.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Refreshed!'),
                        content: Text('The weather has been refreshed.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  lat=position.latitude;
                  lon=position.longitude;
                  Response response= await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key&units=metric'));
                  var data=response.body;
                  display(alldata: data);
                },
                  child: Icon(
                Icons.refresh,
                size: 40,
              ),
            ),
            ),
            Text(
              city,
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              temp,
              style: TextStyle(
                fontSize: 70,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 10),
            Text(
              des,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  max,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '/',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  min,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 170,
                    height: 180,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          pre,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 120,
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          hum,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 120,
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          vis,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 170,
                    height: 180,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          wsp,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 120,
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          deg,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 120,
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          clo,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      wde,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 30,
                      width: 220,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      flk,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 220,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Data provided by Bornik in collaboration',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'with OpenWeather.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

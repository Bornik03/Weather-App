import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'display.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
const key='69a2747d3b61fab6d4663dda62244004';
class loadingscreen extends StatefulWidget {
  @override
  State<loadingscreen> createState() => _loadingscreenState();
}
class _loadingscreenState extends State<loadingscreen> {
  var lat;
  var lon;
  @override
  void initState() {
    getlocation();
    super.initState();
  }
  void getlocation ()
  async {
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission==LocationPermission.whileInUse)
      {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        lat=position.latitude;
        lon=position.longitude;
        getdata();
      }
  }
  Future<void> getdata() async
  {
    Response response= await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key&units=metric'));
    var data=response.body;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>display(
      alldata: data,
    )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.red,
          size: 100.0,
        ),
      ),
    );
  }
}

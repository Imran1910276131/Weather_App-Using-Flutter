import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
void main()
{
   runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController cityNameController=new TextEditingController();
  /*


{

  "weather": [
    {
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
  },
  "name": "Zocca",
  "cod": 200
}


   */
  var  currentCity;
  var temperature;
  var description;
  void getWeather() async
  {
    print("Clicked");
    String cityName =cityNameController.text;
    final queryparameter={
      "q":cityName,
      "appid":"593876f78ab3540a64919e2fa313dcb6"
    };
    Uri uri=new Uri.https("api.openweathermap.org","/data/2.5/weather",queryparameter);
    final jsonData=await get(uri);
    final json=jsonDecode(jsonData.body);
    //print(json);
    // setState()
    // currentCity = json["name"];
    // temperature=json["main"]["temp"];
    // description=json["weather"][0]["main"];
    // print(description);
    setState((){
      currentCity = json["name"];
      temperature=json["main"]["temp"];
      description=json["weather"][0]["main"];
      print(description);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          centerTitle:true ,
          title:Text("Weather App",
          style:TextStyle(
              fontStyle:FontStyle.italic,
              fontSize: 30.0,
              color: Colors.cyan,
          ),

        )
        ),
        body:Center(
         child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Currently in "+(currentCity == null?"loading":currentCity).toString(),
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight:FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text((temperature==null? "loading":(temperature-273).toStringAsFixed(2)).toString()+"\u00B0"+"C"),
              Text((description==null? "loading":description).toString(),
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: cityNameController,
                  textAlign: TextAlign.center,
                ) ,
              ),
              // TextField(
              //
              // ),
              ElevatedButton(
                  onPressed: getWeather,
                  child: Text("Search"),
              ),


            ],
          ),
        ),
      ),
    );

  }
}

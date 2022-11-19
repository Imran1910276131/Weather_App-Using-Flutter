import 'dart:convert';
import 'package:intl/intl.dart';
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
  var humidity;
  var dt;
  var feels_like;
  var sunrise;
  var formattedDate;
  void getWeather() async
  {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('EEE d MMM \n kk:mm:ss ').format(now);
    //print(formattedDate);
    //print("Clicked");
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
      humidity=json["main"]["humidity"];
      feels_like=json["main"]["feels_like"];
      sunrise=json["sys"]["sunrise"];
      dt=json["dt"];
      print(sunrise);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.teal[200],
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          centerTitle:true ,
          title:Text("Weather App",
          style:TextStyle(
              fontStyle:FontStyle.italic,
              fontSize: 36.0,
              color: Colors.pinkAccent[200],
          ),

        )
        ),
        body:Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: getWeather,

                child: Text("Search",style: TextStyle(
                  fontSize: 20,
                ),),
              ),
              SizedBox(
                height: 10,
              ),
              Text("           Weather details          \n",
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight:FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text((currentCity == null?" ":"Location        "+currentCity).toString(),
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight:FontWeight.bold,
                  color: Colors.green,
                  fontStyle: FontStyle.italic,

                ),
              ),
              Text(
                  (temperature==null?" ":"Temperature    "+(temperature-273).toStringAsFixed(2).toString()+"\u00B0 C /"+
                      (((temperature*9)-2297)/5).toStringAsFixed(2).toString()+"\u00B0 F"),
                style: TextStyle(

                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                  fontStyle: FontStyle.italic,
                )),
              Text(
                  (feels_like==null?"  ":"Feels Like    "+(feels_like-273).toStringAsFixed(2).toString()+
                  "\u00B0 C"),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    fontStyle: FontStyle.italic,
                  )),
              Text((formattedDate==null?"  ":"Current Date and Time \n"+formattedDate),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontStyle: FontStyle.italic,
                  )
              ),

              // Text("Date         "+(dt==null? "loading":dt).toString(),
              //     style: TextStyle(fontSize: 40.0),
              // ),

              // Text((description==null? "loading":description).toString(),
              //   style: TextStyle(fontSize: 40.0),
              // ),
              // Text("Humidity         "+(humidity==null? "loading":humidity).toString()+"%",
              //   style: TextStyle(fontSize: 40.0),
              // ),
              // SizedBox(
              //   width: 200,
              //   child: TextField(
              //     controller: cityNameController,
              //     textAlign: TextAlign.center,
              //   ) ,
              // ),
              // // TextField(
              // //
              // // ),
              // SizedBox(
              //   height: 10,
              // ),
              // ElevatedButton(
              //   onPressed: getWeather,
              //
              //   child: Text("Search",style: TextStyle(
              //     fontSize: 40,
              //   ),),
              // ),


            ],
          ),

        ),
      ),
    );

  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class HomePage extends StatefulWidget {
  const  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY, language:Language.ENGLISH);
  Weather? _weather;

  @override
  void initState(){
    super.initState();
    _wf.currentWeatherByCityName("Kathmandu").then((w) {
      setState(() {
        _weather =w;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    if(_weather == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        _locationHeader(),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.08,
        ),
        _dateTimeInfo(),
        SizedBox(
           height: MediaQuery.sizeOf(context).height * 0.05,
        ),
        _weatherIcon(),
        SizedBox(
           height: MediaQuery.sizeOf(context).height * 0.02,
        ),

        _currentTemp(),
        SizedBox(
           height: MediaQuery.sizeOf(context).height * 0.02,
        ),

        _extraInfo(),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,)
      ],
    ),);
  }

  Widget _locationHeader() {
    return Text(_weather?.areaName ?? "",
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),);
  }

  Widget _dateTimeInfo(){
    DateTime now =_weather!.date!;
    return Column(
      children: [
        Text(DateFormat("h:mm:a").format(now),
        style: const TextStyle(
          fontSize: 35,
        ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now),
              style: const TextStyle(
              fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              " ${DateFormat("d.m.y").format(now)}",
              style: const TextStyle(
              fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )
      ],
    );
  }


  Widget _weatherIcon(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
           height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(image: DecorationImage(
      image: AssetImage("assets/images/weather.png"),
      fit: BoxFit.cover, // Optional: scales the image to cover the container
    ),
    )
    ),
    Text(_weather?.weatherDescription?? "",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),),
    ],
    );
  }

  Widget _currentTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 90,
      fontWeight: FontWeight.bold
      )
    );
  }

  Widget _extraInfo(){
    return Container(
       height: MediaQuery.sizeOf(context).height * 0.15,
       width: MediaQuery.sizeOf(context).width * 0.80,
        decoration: BoxDecoration(
        color:Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(8.0),

        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                    ),

                    Text(
                      "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                    ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                    ),

                    Text(
                      "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                    ),
                ],
              ),
            ],
          ),
        );
  }
}
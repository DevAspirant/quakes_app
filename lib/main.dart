import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Global Var
Map _data;
List _features;

void main() async {
  _data = await getQuakes();

  _features = _data['features'];

  print(_data['features'][0]['properties']);

  runApp(new MaterialApp(
    title: "Quikes",
    home: new Quakes(),
  ));
}

class Quakes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Quakes'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: _features.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              if(position.isOdd) return new Divider();
              final index = position ~/ 2;

              // creating the rows
              return new ListTile(
                title: new Text(
                    "Mag: ${_features[position]['properties']['mag']}",
                style: new TextStyle(fontSize: 19.5,color: Colors.orange, fontWeight: FontWeight.w500),),
              subtitle: new Text("${_features[index]['properties']['place']}",style: new TextStyle(
                fontSize: 14.5,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
              ),),);
            }),
      ),
    );
  }
}

Future<Map> getQuakes() async {
  String apiUrl =
      "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson";
  http.Response response = await http.get(apiUrl);
  return jsonDecode(response.body);
}

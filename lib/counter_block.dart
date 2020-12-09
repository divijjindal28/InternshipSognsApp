import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'counter_event.dart';

class music{
  String track_id;
  String track_name;
  String album_name;
  String artist_name;
  music({
    @required this.track_id,
    @required this.track_name,
    @required this.album_name,
    @required this.artist_name,

  });
}

class CounterBloc {
  int _counter = 0;
  final List<music> myMusic =[];
  final _counterStateController = StreamController<List<music>>();
  StreamSink<List<music>> get _inCounter => _counterStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<List<music>> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  // For events, exposing only a sink which is an input
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event)async {
    if (event is FetchBasicData)
      {
        final response = await http.get('https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7');
        final extractedData = json.decode(response.body)['message']['body']['track_list'] as List<dynamic>;

        if(extractedData !=  null) {
          //print(extractedData);
          extractedData.forEach((element) {
            print(element['track'].toString());
            myMusic.insert(0, music(
            album_name:  element['track']['album_name'],
            artist_name:  element['track']['artist_name'],
            track_id:  element['track']['track_id'].toString(),
            track_name:  element['track']['track_name'],
          ));});
          myMusic.forEach((element) { print(element.track_id.toString());});
        }
        _counter++;
      }
    else
      _counter--;

    _inCounter.add(myMusic);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}


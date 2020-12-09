import 'package:flutter/material.dart';
import 'package:internshsip_songs_app/counter_block.dart';
import 'package:internshsip_songs_app/counter_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context){
    _bloc.counterEventSink.add(FetchBasicData());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.counter,
          builder: (BuildContext context, AsyncSnapshot<List<music>> snapshot) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(snapshot.data[index].track_name),
                  subtitle: Text(snapshot.data[index].album_name),
                  trailing: Text(snapshot.data[index].artist_name),
                );
              },
            );
          },
        ),
      ),
//      floatingActionButton: Row(
//        mainAxisAlignment: MainAxisAlignment.end,
//        children: <Widget>[
//          FloatingActionButton(
//            onPressed: () => _bloc.counterEventSink.add(FetchBasicData()),
//            tooltip: 'Increment',
//            child: Icon(Icons.add),
//          ),
//          SizedBox(width: 10),
//          FloatingActionButton(
//            onPressed: () => _bloc.counterEventSink.add(FetchFinalData()),
//            tooltip: 'Decrement',
//            child: Icon(Icons.remove),
//          ),
//        ],
//      ),
    );
  }
}

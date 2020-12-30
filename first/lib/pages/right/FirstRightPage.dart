import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class FirstRightPage extends StatelessWidget {
  int mode = 0;
  String s = "Play";

  AudioPlayer player = new AudioPlayer();
  AudioCache cache = new AudioCache();

  final int index;

  FirstRightPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                child: Text(s),
                color: Colors.lightBlue,
                onPressed: () { _func1(); },
              ),

               MaterialButton(
                child: Text('Pause'),
                color: Colors.lightBlue,
                onPressed: () { _func2(); },
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text("Song : vanilla missile - esuriit"),
                Text("Follow Artist : https://bit.ly/37WRISz"),
                Text("Music promoted by DayDreamSound : https://youtu.be/unw220HUWsg", textAlign: TextAlign.center,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _func1() async {
    if( mode == 0 ) {
      const audioFile = "audio/vanilla_missile-esuriit.mp3";
      player = await cache.play(audioFile);
      mode = 1;
    }

    else if( mode == 1 ) { player?.pause(); mode = 2; }
    else { player?.resume(); mode = 1; }
  }

  _func2() async { player?.stop(); mode = 0; }
}

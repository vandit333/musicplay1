import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class playpage extends StatefulWidget {
  List? currentsong;
  int? nextsong;

  playpage(this.currentsong,this.nextsong);

  @override
  State<playpage> createState() => _playpageState();
}

class _playpageState extends State<playpage> {
  @override
  String? localpath;


  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop().then((value) {

    });
  }
  AudioPlayer audioPlayer = AudioPlayer();
  bool play=false;
  PageController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localpath=widget.currentsong![widget.nextsong!].data;
    audioPlayer.play(localpath!,isLocal: true);
    // controller = PageController(initialPage: widget.currentsong);
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ListTile(title: Text(widget.currentsong![widget.nextsong!].title),),
            // ListTile(title: Text(widget.currentsong![widget.nextsong!].displayName),),
            Center(
              child: Row(
                children: [
                  IconButton(onPressed: () async {
                    if(widget.nextsong!>0)
                      {
                        await audioPlayer.stop();
                        widget.nextsong=widget.nextsong!-1;
                        localpath=widget.currentsong![widget.nextsong!].data;
                        await audioPlayer.play(localpath!,isLocal:true);
                      }
                    setState(() {
                    });


                  }, icon: Icon(Icons.fast_rewind)),
                  IconButton(onPressed: () async {
                    setState((){
                      play=!play;
                    });
                    if(play)
                      {
                        await audioPlayer.pause();
                      }
                    else
                      {
                        await audioPlayer.resume();
                      }
                  }, icon: play? Icon(Icons.play_arrow):Icon(Icons.pause)),
                  IconButton(onPressed: () async {
                    if(widget.nextsong!<widget.currentsong!.length+1)
                      {
                        await audioPlayer.stop();
                        widget.nextsong=widget.nextsong!+1;
                        localpath=widget.currentsong![widget.nextsong!].data;
                        await audioPlayer.play(localpath!,isLocal: true);
                      }
                    setState(() {
                    });

                  }, icon: Icon(Icons.fast_forward_sharp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

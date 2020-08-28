import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:CourseMate/models/file.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';

const title = TextStyle(
    color: Colors.white,
    fontSize: 36,
    letterSpacing: 13.0,
    fontWeight: FontWeight.w600);

class AudioComponent extends StatefulWidget {
  @override
  _AudioComponentState createState() => _AudioComponentState();
}

class _AudioComponentState extends State<AudioComponent> {
  List<FileModel> files;
  FileModel selectedModel;
  var audio;
  AudioPlayer player;
  AudioCache cache;
  bool initialPlay = true;
  bool playing;

  @override
  void initState() {
    super.initState();
    player = new AudioPlayer();
    cache = new AudioCache(fixedPlayer: player);

    getAudiosPath();
  }

  getAudiosPath() async {
    var audioPath = await StoragePath.audioPath;
    var audios = jsonDecode(audioPath) as List;
    files = audios.map<FileModel>((e) {
      return FileModel.fromJson(e);
    }).toList();

    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        audio = files[0].files[0];
      });
  }

  @override
  dispose() {
    super.dispose();
    player.stop();
  }

  playPause(sound) {
    if (initialPlay) {
      cache.play(sound);
      playing = true;
      initialPlay = false;
    }
    return IconButton(
      color: Colors.white70,
      iconSize: 80.0,
      icon: playing
          ? Icon(Icons.pause_circle_filled)
          : Icon(Icons.play_circle_filled),
      onPressed: () {
        setState(() {
          if (playing) {
            playing = false;
            player.pause();
          } else {
            playing = true;
            player.resume();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String audioName = audio['displayName'].toString().split('.')[0];
    String audioPath = audio['path'].toString();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.folder_open),
                  SizedBox(width: 10),
                  DropdownButtonHideUnderline(
                      child: DropdownButton<FileModel>(
                    items: getItems(),
                    onChanged: (FileModel d) {
                      assert(d.files.length > 0);
                      audio = d.files[0];
                      setState(() {
                        selectedModel = d;
                      });
                    },
                    value: selectedModel,
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Next',
                ),
              )
            ],
          ),
          Divider(),
          audio != null
              ? Center(
                  child: Column(children: [
                    Text(audioName.toUpperCase(), style: title),
                    playPause(audioPath)
                  ]),
                )
              : Container(),
          files != null
              ? selectedModel == null && selectedModel.files.length < 1
                  ? Container()
                  : Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.38,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4),
                            itemBuilder: (_, i) {
                              var file = selectedModel.files[i];
                              print(file.toString());
                              return GestureDetector(
                                child: Container(
                                    child: Text("${file['displayName']}")),
                                onTap: () {
                                  setState(() {
                                    audio = file;
                                  });
                                },
                              );
                            },
                            itemCount: selectedModel.files.length),
                      ),
                    )
              : SizedBox()
        ]));
  }

  List<DropdownMenuItem<FileModel>> empty = [];
  List<DropdownMenuItem> getItems() {
    return files != null
        ? files
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.folder,
                        //   style: TextStyle(color: Colors.black),
                      ),
                      value: e,
                    ))
                .toList() ??
            []
        : empty;
  }
}

class Background extends StatefulWidget {
  final String sound;
  const Background({Key key, this.sound}) : super(key: key);
  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  Timer timer;
  bool _visible = false;

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  swap() {
    if (mounted) {
      setState(() {
        _visible = !_visible;
      });
    }
  }

  @override
  build(BuildContext context) {
    timer = Timer(Duration(seconds: 6), swap);
    return Stack(
      children: [
        Image.asset(
          'assets/images/forest_1.jpg',
          fit: BoxFit.cover,
        ),
        AnimatedOpacity(
            child: Image.asset(
              'assets/images/forest_2.jpg',
              fit: BoxFit.cover,
            ),
            duration: Duration(seconds: 2),
            opacity: _visible ? 1.0 : 0.0)
      ],
    );
  }
}

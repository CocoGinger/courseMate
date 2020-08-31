import 'dart:async';
import 'dart:convert';

import 'package:CourseMate/models/file.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';
import 'package:video_player/video_player.dart';

const title =
    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600);

class VideoComponent extends StatefulWidget {
  @override
  _VideoComponentState createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  List<FileModel> files;
  FileModel selectedModel;
  VideoPlayerController _controller;
  var video;

  @override
  @override
  void initState() {
    super.initState();

    getAllVideo();

    _controller = video != null
        ? VideoPlayerController.file(video['path'])
        : VideoPlayerController.network(
            'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  Future getVideosPath() async {
    var videoPath = await StoragePath.videoPath;
    var video = jsonDecode(videoPath) as List;
    files = video.map<FileModel>((e) {
      return FileModel.fromJson(e);
    }).toList();

    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        video = files[0].files[0];
      });
    return files;
  }

  Stream getAllVideo() {
    return Stream.fromFuture(getVideosPath());
  }

  @override
  void dispose() {
    super.dispose();
  }

  playPause() {
    return IconButton(
      color: Colors.white70,
      iconSize: 80.0,
      icon: _controller.value.isPlaying
          ? Icon(Icons.pause_circle_filled)
          : Icon(Icons.play_circle_filled),
      onPressed: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      video = d.files[0];
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
          video != null
              ? _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container()
              : Container(),
          SizedBox(height: 10),
          Divider(),
          files != null
              ? selectedModel == null && selectedModel.files.length < 1
                  ? Container()
                  : Flexible(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3),
                          itemBuilder: (_, i) {
                            var file = selectedModel.files[i];
                            print(file.toString());
                            return GestureDetector(
                              child: Stack(children: [
                                Text(
                                  file['displayName']
                                          .toString()
                                          ?.split('.')
                                          ?.first ??
                                      "",
                                  overflow: TextOverflow.fade,
                                ),
                              ]),
                              onTap: () {
                                setState(() {
                                  video = file;
                                });
                              },
                            );
                          },
                          itemCount: selectedModel.files.length))
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

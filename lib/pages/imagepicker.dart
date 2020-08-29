import 'package:CourseMate/components/audio_component.dart';
import 'package:CourseMate/components/image_component.dart';
import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  bool image = true;
  bool file = false;
  bool audio = false;
  bool video = false;
  Widget _asset() {
    if (image) {
      return ImageComponent();
    } else if (file) {
      return Container(child: Text("Filee"));
    } else if (audio) {
      return AudioComponent();
    } else {
      return Container(child: Text("Video"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          onLongPress: () {
            setState(() {
              image = true;
              audio = false;
              file = false;
            });
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.note_add),
                    onPressed: () {
                      setState(() {
                        image = false;
                        audio = false;
                        video = false;
                        
                        file = true;
                      });
                    },
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0xff00aeff), shape: BoxShape.circle),
                  child: IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.audiotrack),
                    onPressed: () {
                      setState(() {
                        image = false;
                        file = false;
                        video = false;
                        audio = true;
                      });
                    },
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0xffff3f20), shape: BoxShape.circle),
                  child: IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.video_library),
                    onPressed: () {
                      setState(() {
                        image = false;
                        file = false;
                        audio = false;
                        video = true;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _asset());
  }
}

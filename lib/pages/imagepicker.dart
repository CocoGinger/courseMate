import 'dart:convert';
import 'dart:io';

import 'package:CourseMate/models/file.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<FileModel> files;
  FileModel selectedModel;
  String image;
  @override
  void initState() {
    super.initState();
    getImagesPath();
  }

  getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath) as List;
    files = images.map<FileModel>((e) {
      return FileModel.fromJson(e);
    }).toList();

    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
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
                          image = d.files[0];
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
              Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: image != null
                      ? Hero(
                          tag: "btn1",
                          child: Image.file(File(image),
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width),
                        )
                      : Container()),
              Divider(),
              files != null?
              selectedModel == null && selectedModel.files.length < 1
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

                              return GestureDetector(
                                child: Hero(
                                  tag: "btn1",
                                  child: Image.file(
                                    File(file),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    image = file;
                                  });
                                },
                              );
                            },
                            itemCount: selectedModel.files.length),
                      ),
                    ): SizedBox()
            ],
          ),
        ),
      ),
    );
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
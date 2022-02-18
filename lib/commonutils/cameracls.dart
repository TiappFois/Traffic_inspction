import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'dart:convert';
import 'package:ti/model/SttnInspModels/TrnSgnlFailureModel.dart';
import 'package:flutter/material.dart';
import 'package:ti/commonutils/ti_utilities.dart';
import 'package:image_picker/image_picker.dart';

class CameraCls extends StatefulWidget {
  File imageFile = null ;
  final Function cameraCallBack;

  CameraCls({Key key ,this.cameraCallBack, this.imageFile}) : super(key: key);

  @override
  _CameraClsState createState() => _CameraClsState();
}

class _CameraClsState extends State<CameraCls> {


  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  String _retrieveDataError;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Column(
              children: <Widget>[
                Container(
                  width: 90,
                  height: 70,
                  child: _previewImage(),
                ),
              ],
            ),
            onTap: () async {
              _openPreviewDialogBox();
            },
          ),
          Container(
            child: GestureDetector(
              child: Column(
                children: <Widget>[
                  new Container(
                      child: Image.asset(
                        'assets/camera_icon.png',
                        width: 90,
                        height: 70,
                      )),
                ],
              ),
              onTap: () async {
                await _optionsDialogBox();

              },
            ),
          )
        ],
      ),
    );
  }
  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      print("_imageFile:" );
      final pickedFile = await _picker.getImage(
          source: source, maxHeight: 300, maxWidth: 200.0, imageQuality: 80);
      setState(() {
        print("_imageFile:" );
        widget.imageFile = File(pickedFile.path);

        print("_imageFile:" + widget.imageFile.toString());
        print('MYimagefile:' + widget.imageFile.path);
        widget.cameraCallBack(widget.imageFile);

      });
    } catch (e) {
      _pickImageError = e;
    }
  }
  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (widget.imageFile != null) {
      return Image.file(
        widget.imageFile,
        fit: BoxFit.cover,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        'Upload Image (if any)',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
      );
    }
  }


  Future<void> _openPreviewDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _previewImage(),
                  GestureDetector(
                    child: Text(
                      'Close Preview',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Select Option',
                    style: new TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    child: Text(
                      'Take a picture',
                      style: new TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    onTap: () {
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(
                      'Select from gallery',
                      style: new TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    onTap: () {
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(
                      'Clear Image',
                      style: new TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    onTap: () {
                      setState(() {
                        widget.imageFile = null;
                        widget.cameraCallBack(widget.imageFile);
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                  GestureDetector(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }


}

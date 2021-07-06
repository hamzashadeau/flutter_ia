import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/realtime/bounding_box.dart';
import 'package:object_detection/realtime/camera.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';

import 'camera_cnn.dart';

class Cnn extends StatefulWidget {
  final List<CameraDescription> cameras;
  Cnn(this.cameras);
  @override
  _Cnn createState() => _Cnn();
}

class _Cnn extends State<Cnn> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  initCameras() async {

  }
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/yolov2_tiny.tflite",
      labels: "assets/models/yolov2_tiny.txt",
    );
  }
  /*
  The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
  */
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Yolov Test"),
      ),
      body: Stack(
        children: <Widget>[
          Cameracnn(widget.cameras, setRecognitions),
          BoundingBox(
            _recognitions == null ? [] : _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
          ),
        ],
      ),
    );
  }
}
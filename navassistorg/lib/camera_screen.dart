import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:vibration/vibration.dart';

class ObstacleDetectionScreen extends StatefulWidget {
  @override
  _ObstacleDetectionScreenState createState() => _ObstacleDetectionScreenState();
}

class _ObstacleDetectionScreenState extends State<ObstacleDetectionScreen> {
  CameraController? _cameraController;
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController!.initialize();
    setState(() {});
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: 'assets/tflite_model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  void _startDetection() {
    if (_cameraController != null && !_isDetecting) {
      _cameraController!.startImageStream((CameraImage img) {
        if (_isDetecting) return;
        _isDetecting = true;
        Tflite.runModelOnFrame(
          bytesList: img.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: img.height,
          imageWidth: img.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.5,
          asynch: true,
        ).then((recognitions) {
          recognitions?.forEach((recognition) {
            if (recognition["confidence"] > 0.6) {
              Vibration.vibrate();
            }
          });
          _isDetecting = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obstacle Detection'),
      ),
      body: Column(
        children: [
          if (_cameraController != null && _cameraController!.value.isInitialized)
            Container(
              height: 300,
              child: CameraPreview(_cameraController!),
            ),
          ElevatedButton(
            onPressed: _startDetection,
            child: Text('Start Obstacle Detection'),
          ),
        ],
      ),
    );
  }
}

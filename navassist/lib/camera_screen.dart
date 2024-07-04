import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Interpreter _interpreter;
  late List<CameraDescription> _cameras;
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
  }

  void _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {});
    _controller.startImageStream((CameraImage image) {
      if (!_isDetecting) {
        _isDetecting = true;
        _runModelOnFrame(image).then((_) => _isDetecting = false);
      }
    });
  }

  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/tflite_model.tflite');
  }

  Future<void> _runModelOnFrame(CameraImage image) async {
    // Preprocess the camera image
    final input = _preprocessCameraImage(image);

    // Define output buffer
    var output = List.generate(1, (index) => List.generate(10, (index) => List.filled(4, 0.0))).cast<List<List<double>>>();

    // Run inference
    _interpreter.run(input, output);

    // Process the results and trigger haptic feedback if an obstacle is detected
    if (_isObstacleDetected(output)) {
      HapticFeedback.mediumImpact();
    }
  }

  Uint8List _preprocessCameraImage(CameraImage image) {
    // Calculate the height and width of the image
    final int width = image.width;
    final int height = image.height;

    // Convert the YUV420 format to RGB format
    img.Image convertedImage = img.Image(width, height);
    for (int plane = 0; plane < image.planes.length; plane++) {
      // Convert each plane to a List<int>
      final bytes = image.planes[plane].bytes;
      final planeHeight = plane == 0 ? height : height ~/ 2;
      final planeWidth = plane == 0 ? width : width ~/ 2;
      for (int x = 0; x < planeWidth; x++) {
        for (int y = 0; y < planeHeight; y++) {
          final pixelIndex = y * planeWidth + x;
          final pixel = bytes[pixelIndex];
          // Assign the pixel value to the corresponding location in the image
          if (plane == 0) {
            // Y plane
            convertedImage.setPixel(x, y, img.getColor(pixel, pixel, pixel));
          } else if (plane == 1) {
            // U plane (we'll use it to update the blue channel)
            convertedImage.setPixel(x * 2, y * 2, img.getColor(0, 0, pixel));
            convertedImage.setPixel(x * 2 + 1, y * 2, img.getColor(0, 0, pixel));
            convertedImage.setPixel(x * 2, y * 2 + 1, img.getColor(0, 0, pixel));
            convertedImage.setPixel(x * 2 + 1, y * 2 + 1, img.getColor(0, 0, pixel));
          } else if (plane == 2) {
            // V plane (we'll use it to update the red channel)
            convertedImage.setPixel(x * 2, y * 2, img.getColor(pixel, 0, 0));
            convertedImage.setPixel(x * 2 + 1, y * 2, img.getColor(pixel, 0, 0));
            convertedImage.setPixel(x * 2, y * 2 + 1, img.getColor(pixel, 0, 0));
            convertedImage.setPixel(x * 2 + 1, y * 2 + 1, img.getColor(pixel, 0, 0));
          }
        }
      }
    }

    // Resize the image to the required dimensions (e.g., 300x300)
    final resizedImage = img.copyResize(convertedImage, width: 300, height: 300);

    // Convert the image to a byte buffer
    final Uint8List input = Uint8List(300 * 300 * 3);
    int bufferIndex = 0;
    for (int y = 0; y < 300; y++) {
      for (int x = 0; x < 300; x++) {
        final pixel = resizedImage.getPixel(x, y);
        input[bufferIndex++] = img.getRed(pixel);
        input[bufferIndex++] = img.getGreen(pixel);
        input[bufferIndex++] = img.getBlue(pixel);
      }
    }

    return input;
  }

  bool _isObstacleDetected(List<List<List<double>>> output) {
    // Analyze the model output to determine if an obstacle is detected
    for (var i = 0; i < output[0].length; i++) {
      if (output[0][i][2] > 0.5) { // Assuming index 2 is the confidence score and 0.5 is the threshold
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    _controller.dispose();
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: CameraPreview(_controller),
    );
  }
}

import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class InferenceModel {
  final File imageFile;
  int interpreterAddress;
  List<String> labels;
  List<int> inputShape;
  List<int> outputShape;
  late SendPort responsePort;

  InferenceModel(
    this.imageFile,
    this.interpreterAddress,
    this.labels,
    this.inputShape,
    this.outputShape,
  );
}

class IsolateInference {
  static const String _debugName = "TFLITE_INFERENCE";
  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;
  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: _debugName,
    );
    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final InferenceModel isolateModel in port) {
      final imageFile = isolateModel.imageFile;
      final inputShape = isolateModel.inputShape;
      final imageMatrix = _imagePreProcessing(imageFile, inputShape);

      final input = [imageMatrix];
      final output = [List<int>.filled(isolateModel.outputShape[1], 0)];
      final address = isolateModel.interpreterAddress;
      final result = _runInference(input, output, address);

      int maxScore = result.reduce((a, b) => a + b);
      final keys = isolateModel.labels;
      final values = result
          .map((e) => e.toDouble() / maxScore.toDouble())
          .toList();
      var classification = Map.fromIterables(keys, values);
      classification.removeWhere((key, value) => value == 0);

      isolateModel.responsePort.send(classification);
    }
  }

  static List<List<List<num>>> _imagePreProcessing(
    File imageFile,
    List<int> inputShape,
  ) {
    final bytes = imageFile.readAsBytesSync();
    img.Image? image = img.decodeImage(bytes);

    final resized = img.copyResize(
      image!,
      width: inputShape[1],
      height: inputShape[2],
    );

    final imageMatrix = List.generate(
      resized.height,
      (y) => List.generate(resized.width, (x) {
        final pixel = resized.getPixel(x, y);
        return [pixel.r, pixel.g, pixel.b];
      }),
    );
    return imageMatrix;
  }

  static List<int> _runInference(
    List<List<List<List<num>>>> input,
    List<List<int>> output,
    int interpreterAddress,
  ) {
    Interpreter interpreter = Interpreter.fromAddress(interpreterAddress);
    interpreter.run(input, output);
    final result = output.first;
    return result;
  }

  Future<void> close() async {
    _isolate.kill();
    _receivePort.close();
  }
}



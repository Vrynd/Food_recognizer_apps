import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:food_recognizer_app/service/isolate_inference.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ImageClassificationService {
  late final IsolateInference isolateInference;

  final modelPath = 'assets/mobilenet.tflite';
  final labelsPath = 'assets/probability-labels-en.txt';
  late final Interpreter interpreter;
  late final List<String> labels;
  late Tensor inputTensor;
  late Tensor outputTensor;

  Future<void> _loadModel() async {
    final options = InterpreterOptions()
      ..useNnApiForAndroid = true
      ..useMetalDelegateForIOS = true;

    interpreter = await Interpreter.fromAsset(modelPath, options: options);

    inputTensor = interpreter.getInputTensors().first;
    outputTensor = interpreter.getOutputTensors().first;
  }

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString(labelsPath);
    labels = labelTxt.split('\n');
  }

  Future<void> initHelper() async {
    await _loadLabels();
    await _loadModel();
    isolateInference = IsolateInference();
    await isolateInference.start();
  }

  Future<Map<String, double>> runInference(File imageFile) async {
    final responsePort = ReceivePort();

    final isolateModel = InferenceModel(
      imageFile,
      interpreter.address,
      labels,
      inputTensor.shape,
      outputTensor.shape,
    )..responsePort = responsePort.sendPort;

    isolateInference.sendPort.send(isolateModel);
    final result = await responsePort.first as Map<String, double>;
    responsePort.close();
    return result;
  }

  Future<void> close() async {
    await isolateInference.close();
  }
}

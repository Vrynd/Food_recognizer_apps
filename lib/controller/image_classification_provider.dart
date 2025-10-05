import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_recognizer_app/service/image_classification_service.dart';

class ImageClassificationProvider extends ChangeNotifier {
  final ImageClassificationService _service;
  ImageClassificationProvider(this._service);

  Map<String, num> _classifications = {};
  Map<String, num> get classifications {
    if (_classifications.isEmpty) return {};
    final sortedEntries = _classifications.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return {sortedEntries.first.key: sortedEntries.first.value};
  }

  Future<void> runClassification(File imageFile) async {
    _classifications = await _service.runInference(imageFile);
    notifyListeners();
  }

  void clearClassification() {
    _classifications.clear();
    notifyListeners();
  }

  Future<void> close() async {
    await _service.close();
  }
}

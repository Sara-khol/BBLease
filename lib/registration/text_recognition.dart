import 'dart:io';

import 'package:bblease/class_user.dart';
import 'package:bblease/registration/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


class TextRecognition extends StatefulWidget {
  const TextRecognition({super.key});

  @override
  State<TextRecognition> createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {

  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                title: const Text('Text Recognition Sample'),
              ),
              body: Column(
                children: [
                  Image.asset('assets/images/tryen.jpg'),
                  Container(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: _scanImage,
                            child: const Text('Scan text'),
                          ),
                        ),
                      ),
                ],
              ),
    );
  }

  Future<void> _scanImage() async {

    final navigator = Navigator.of(context);


      final pictureFile = User().regImages[0];

      final file = File('assets/images/tryen.jpg');
      print(file.path);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) => ResultScreen(text: recognizedText.text),
        ),
      );
  }
}
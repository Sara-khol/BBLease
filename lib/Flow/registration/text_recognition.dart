import 'package:bblease/models/class_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


void TextRecognition(int index) async {
  debugPrint('start text scanning');

  XFile? image=User().regImages[index];
  String scannedText = "";

  final inputImage = InputImage.fromFilePath(image!.path);
  final textDetector = GoogleMlKit.vision.textRecognizer();
  RecognizedText recognisedText = await textDetector.processImage(inputImage);
  await textDetector.close();
  scannedText = "";
  for (TextBlock block in recognisedText.blocks) {
    for (TextLine line in block.lines) {
      scannedText = "$scannedText${line.text}\n";
    }
  }

index==0? await extractData(scannedText):await extractData2(scannedText);
}

Future<void> extractData(String data) async {
  print('extracting...');

  List<String> lines = data.split('\n');
  print('lines: $lines');

  List<String> sectionPrefixes = [
    '1',
    '2',
    '3',
    '4a',
    '4b',
    '4d',
    '5',
    '9'
  ];

  // Extract content for each section prefix
  Map<String, String> extractedData = {};
  for (var line in lines) {
    for (var prefix in sectionPrefixes) {
      if (line.startsWith(prefix)) {
        if (line.startsWith('$prefix.')) {
          extractedData[prefix] = line.substring(prefix.length+1,).trim();
        }
        else {
          //todo why needed , is there data without .
         // added this check to avoid going over good data
          if(extractedData[prefix]==null) {
            extractedData[prefix] = line.substring(prefix.length).trim();
          }
        }
      }

    }
  }
  User().firstName = extractedData['2'] ?? '';
  User().lastName = extractedData['1'] ?? '';

  //User().birthDate=extractedData['3'] ?? '';
  final rawDateB = extractedData['3'] ?? '';
  final parsedDateB = parseFlexibleDate(rawDateB);

  User().birthDate = parsedDateB != null
      ? DateFormat('yyyy-MM-dd').format(parsedDateB) // Store in consistent DB/API format
      : '';


 // User().licenseIssDate=extractedData['4a'] ?? '';
  final rawDateL = extractedData['4a'] ?? '';
  final parsedDateL = parseFlexibleDate(rawDateL);
  User().licenseIssDate = parsedDateL != null
      ? DateFormat('yyyy-MM-dd').format(parsedDateL) // Store in consistent DB/API format
      : '';

//User().licenseExpDate=extractedData['4b'] ?? '';
  final rawDateE = extractedData['4b'] ?? '';
  final parsedDateE = parseFlexibleDate(rawDateE);

  User().licenseExpDate = parsedDateE != null
      ? DateFormat('yyyy-MM-dd').format(parsedDateE) // Store in consistent DB/API format
      : '';


  // User().tz = extractedData['5']?.replaceFirst('ID ', '').trim() ?? '';
  // User().licenseId = extractedData['4d'] ?? '';

  final tzRaw = extractedData['5'];
  final licenseRaw = extractedData['4d'];


  if ((tzRaw ?? '').contains('ID ')) {
    User().tz = tzRaw!.replaceFirst('ID ', '').trim();
    User().licenseId = licenseRaw ?? '';
  } else if ((licenseRaw ?? '').contains('ID ')) {
    User().tz = licenseRaw!.replaceFirst('ID ', '').trim();
    User().licenseId = tzRaw ?? '';
  }
  User().licenseDegree = extractedData['9'] ?? '';
  debugPrint(extractedData.toString());

}
Future<void> extractData2(String text) async{
  debugPrint('extracting2...');
  debugPrint(text);
  if(text.contains('new driver')){
    User().isNewDriver=true;
  }
}

DateTime? parseFlexibleDate(String input) {
  final formats = [
    DateFormat('dd.MM.yyyy'),
    DateFormat('dd/MM/yyyy'),
    DateFormat('yyyy-MM-dd'),
    DateFormat('dd-MM-yyyy'),
    DateFormat('MM/dd/yyyy'),
    DateFormat('dd/MM/yy'),
  ];

  for (final format in formats) {
    try {
      return format.parseStrict(input);
    } catch (_) {
      continue;
    }
  }
  return null;
}

/*Future<void> writeStringToFile(String data) async {
  // Get the application directory path
  final directory = await getApplicationDocumentsDirectory();

  // Create a reference to the file location
  final file = File('${directory?.path}/my_file.txt');
  print('my_file path: ${file.path}');

  String content = "";

  if (await file.exists()) {
    // Read the existing content
    content = await file.readAsString();

    // Translate a specific section (replace with the actual condition to identify the section)
    String sectionToTranslate = "some section"; // Update this to the actual section you want to translate
    if (content.contains(sectionToTranslate)) {
      String translatedSection = translate(sectionToTranslate);
      content = content.replaceFirst(sectionToTranslate, translatedSection);
    }

    // Append the new data
    content += data;

    // Write the updated content back to the file
    await file.writeAsString(content);
  } else {
    // Translate the data (if needed) before writing
    String translatedData = translate(data); // Adjust this based on how you wish to translate
    await file.writeAsString(translatedData);
  }

  OpenFile.open(file.path);
}*/

/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition example"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                children: [
                   if (textScanning) const CircularProgressIndicator(),
                   if (!textScanning && imageFile == null)
                     Container(
                     width: 300,
                     height: 300,
                     color: Colors.grey[300]!,
                     ),
                   if (imageFile != null) Image.file(File(imageFile!.path))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => getImage(ImageSource.camera),
                      child: const Text("Camera"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  scannedText,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occurred while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    String text = await FlutterTesseractOcr.extractText(image.path,language: 'heb+eng');

    scannedText += text;
    print('scannedText:  ${scannedText}');

    setState(() {
      textScanning = false;
    });
  }
}*/

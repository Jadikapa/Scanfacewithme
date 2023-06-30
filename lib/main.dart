import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(FaceComparisonApp());
}

class FaceComparisonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Comparison App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  bool _isImagePickerActive = false;

  Future<void> _scanAndCompare() async {
    if (_isImagePickerActive) {
      return; // Image picker is already active
    }

    setState(() {
      _isImagePickerActive = true;
    });

    try {
      final liveImage = await _picker.pickImage(source: ImageSource.camera);
      final idCardImage = await _picker.pickImage(source: ImageSource.gallery);

      if (liveImage != null && idCardImage != null) {
        // Perform image comparison here
        print('Live Image Path: ${liveImage.path}');
        print('ID Card Image Path: ${idCardImage.path}');
      }
    } catch (e) {
      print('Image picker error: $e');
    } finally {
      setState(() {
        _isImagePickerActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Comparison'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _scanAndCompare,
          child: Text('Scan and Compare'),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ios_insecure_screen_detector/ios_insecure_screen_detector.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IosInsecureScreenDetector _iosInsecureScreenDetector = IosInsecureScreenDetector();
  late bool isScreenRecording = false;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      initScreenshotDetector();
    }
  }

  void initScreenshotDetector() async {
    _iosInsecureScreenDetector.initialize();
    _iosInsecureScreenDetector.addListener(iosScreenshotCallback, iosScreenrecordCallback);
  }

  void iosScreenshotCallback() {
    print("User took screenshot");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Screenshot captured")));
  }

  void iosScreenrecordCallback(bool isRecording) {
    setState(() {
      isScreenRecording = isRecording;
    });
  }

  @override
  void dispose() {
    _iosInsecureScreenDetector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text("Some exam questions"),
          ),
          isScreenRecording
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                )
              : Container()
        ],
      ),
    );
  }
}

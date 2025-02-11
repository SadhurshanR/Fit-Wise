import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class ProgressTrackingScreen extends StatefulWidget {
  @override
  _ProgressTrackingScreenState createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  File? _previousImage;
  File? _currentImage;
  int _batteryLevel = 100;
  final Battery _battery = Battery(); // Battery instance
  String _connectionStatus = "Checking..."; // Network status
  final Connectivity _connectivity = Connectivity(); // Connectivity instance

  @override
  void initState() {
    super.initState();
    _fetchBatteryLevel(); // Get battery level when the screen loads
    _checkConnectivity(); // Check connectivity when the screen loads
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus); // Listen for changes
  }

  // Function to pick an image from the gallery (for "Before" image)
  Future<void> _pickBeforeImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _previousImage = File(pickedFile.path);
      });
    }
  }

  // Function to take a picture using the camera (for "Now" image)
  Future<void> _captureNowImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _currentImage = File(pickedFile.path);
      });
    }
  }

  // Function to get battery level
  Future<void> _fetchBatteryLevel() async {
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  // Function to check current network status
  Future<void> _checkConnectivity() async {
    var result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Function to update connection status
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      if (result == ConnectivityResult.mobile) {
        _connectionStatus = "Connected via Mobile Data";
      } else if (result == ConnectivityResult.wifi) {
        _connectionStatus = "Connected via WiFi";
      } else {
        _connectionStatus = "No Internet Connection";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Your Progress"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Compare Your Progress",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Display Before & Now images
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _imageContainer(_previousImage, "Before"),
                SizedBox(width: 10),
                _imageContainer(_currentImage, "Now"),
              ],
            ),

            SizedBox(height: 20),

            // Upload Button (For "Before" Image)
            ElevatedButton.icon(
              icon: Icon(Icons.photo_library),
              label: Text("Upload Before Image"),
              onPressed: _pickBeforeImage,
            ),

            SizedBox(height: 10),

            // Capture Button (For "Now" Image)
            ElevatedButton.icon(
              icon: Icon(Icons.camera),
              label: Text("Take Now Picture"),
              onPressed: _captureNowImage,
            ),

            SizedBox(height: 20),

            // Battery Level Display
            Text(
              "Battery Level: $_batteryLevel%",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.battery_full),
              label: Text("Update Battery Status"),
              onPressed: _fetchBatteryLevel,
            ),

            SizedBox(height: 20),

            // Network Status Display
            Text(
              "Network Status: $_connectionStatus",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.refresh),
              label: Text("Check Network Status"),
              onPressed: _checkConnectivity,
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display images
  Widget _imageContainer(File? image, String label) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(10),
          ),
          child: image != null
              ? Image.file(image, fit: BoxFit.cover)
              : Center(child: Text("No Image", textAlign: TextAlign.center)),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

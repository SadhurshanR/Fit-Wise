import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class WorkoutDetailView extends StatefulWidget {
  final Map workout;

  const WorkoutDetailView({super.key, required this.workout});

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  Map<String, dynamic>? workoutDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWorkoutDetails();
  }

  Future<void> loadWorkoutDetails() async {
    // Load JSON file
    String data = await rootBundle.loadString('assets/data/workout_details.json');
    Map<String, dynamic> jsonData = json.decode(data);

    // Find the workout details using the ID
    String workoutId = widget.workout["id"] ?? "";
    setState(() {
      workoutDetails = jsonData[workoutId] ?? {};
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout["title"] ?? "Workout Details"),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the workout image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                workoutDetails?["image"] ?? "assets/images/placeholder.jpg",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Workout title
            Text(
              widget.workout["title"] ?? "",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Workout time
            Text(
              widget.workout["time"] ?? "",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            // Workout description
            Text(
              workoutDetails?["description"] ?? "No details available.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            // Workout details
            Text(
              "Workout:",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              workoutDetails?["workout"] ?? "No workout available.",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
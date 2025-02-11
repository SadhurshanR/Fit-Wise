import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../../Common/color_extension.dart';
import '../../Common_Widget/latest_activity_row.dart';
import '../../Common_Widget/today_target_cell.dart';
import '../ProgressTracker/progress.dart';
import 'WorkoutDetailView.dart';

class ActivityTrackerView extends StatefulWidget {
  const ActivityTrackerView({super.key});

  @override
  State<ActivityTrackerView> createState() => _ActivityTrackerViewState();
}

class _ActivityTrackerViewState extends State<ActivityTrackerView> {
  List lastWorkoutArr = [
    {
      "image": "assets/images/N5.png",
      "title": "Fullbody Workout",
      "time": "180 Calories Burn | 20 minutes",
      "id": "fullbody"
    },
    {
      "image": "assets/images/N2.png",
      "title": "Lowerbody Workout",
      "time": "200 Calories Burn | 30 minutes",
      "id": "lowerbody"
    },
    {
      "image": "assets/images/N4.png",
      "title": "Ab Workout",
      "time": "150 Calories Burn | 25 minutes",
      "id": "abs"
    },
    {
      "image": "assets/images/N6.png",
      "title": "Upperbody Workout",
      "time": "220 Calories Burn | 20 minutes",
      "id": "upperbody"
    },
    {
      "image": "assets/images/N5.png",
      "title": "Morning Stretch & Mobility",
      "time": "100 Calories Burn | 20 minutes",
      "id": "stretch"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tcolor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Tcolor.lightgrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/images/A1.png",
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Tcolor.lightgrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/images/more.png",
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Tcolor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Tcolor.primaryColor2.withOpacity(0.3),
                      Tcolor.primaryColor1.withOpacity(0.3)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today Target",
                          style: TextStyle(
                            color: Tcolor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Tcolor.primaryG,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              height: 30,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textColor: Tcolor.primaryColor1,
                              minWidth: double.maxFinite,
                              elevation: 0,
                              color: Colors.transparent,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        Expanded(
                          child: TodayTargetCell(
                            icon: "assets/images/glass.png",
                            value: "8L",
                            title: "Water Intake",
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: TodayTargetCell(
                            icon: "assets/images/boots.png",
                            value: "2400",
                            title: "Foot Steps",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Workout",
                    style: TextStyle(
                        color: Tcolor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressTrackingScreen()));
                    },
                    child: Text(
                      "Check Progress",
                      style: TextStyle(
                          color: Tcolor.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: lastWorkoutArr.length,
                itemBuilder: (context, index) {
                  var wObj = lastWorkoutArr[index] as Map? ?? {};
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailView(workout: wObj),
                        ),
                      );
                    },
                    child: LatestActivityRow(wObj: wObj),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

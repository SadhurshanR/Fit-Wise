import 'package:fit_wise/Common_Widget/latest_activity_row.dart';
import 'package:flutter/material.dart';
import '../../Common/color_extension.dart';
import '../../Common_Widget/round_button.dart';

class SleepTrackerView extends StatefulWidget {
  const SleepTrackerView({super.key});

  @override
  _SleepTrackerViewState createState() => _SleepTrackerViewState();
}

class _SleepTrackerViewState extends State<SleepTrackerView> {
  List lastWorkoutArr = [
    {"image": "assets/images/N5.png", "title": "Fullbody Workout", "time": "180 Calories Burn | 20minutes"},
    {"image": "assets/images/N2.png", "title": "Lowerbody Workout", "time": "200 Calories Burn | 30minutes"},
    {"image": "assets/images/N4.png", "title": "Ab Workout", "time": "150 Calories Burn | 25 minutes"},
    {"image": "assets/images/N6.png", "title": "Upperbody Workout ", "time": "220 Calories Burn | 20 minutes"},
    {"image": "assets/images/N5.png", "title": "Morning Stretch & Mobility", "time": "100 Calories Burn | 20 minutes"},
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
          "Sleep Tracker",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Graph.png',
                  fit: BoxFit.contain,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Banner.png',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Tcolor.primaryColor2.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Sleep Schedule",
                    style: TextStyle(
                        color: Tcolor.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: RoundButton(
                      title: "Check",
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: lastWorkoutArr.length,
                itemBuilder: (context, index) {
                  var wObj = lastWorkoutArr[index] as Map? ?? {};
                  return InkWell(
                      onTap: () {},
                      child: LatestActivityRow(wObj: wObj));
                }),
          ],
        ),
      ),
    );
  }
}

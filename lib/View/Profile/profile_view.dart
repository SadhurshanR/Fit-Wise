import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Common/color_extension.dart';
import '../../Common_Widget/round_button.dart';
import '../../Common_Widget/setting_row.dart';
import '../../Common_Widget/title_subtitle_cell.dart';
import 'package:fit/View/Onboarding/Onboarding_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = "Loading...";
  String height = "N/A";
  String weight = "N/A";
  String age = "N/A";

  // Sections data
  List<Map<String, String>> accountArr = [
    {"image": "assets/images/P1.png", "name": "Personal Data"},
    {"image": "assets/images/P2.png", "name": "Achievement"},
    {"image": "assets/images/P3.png", "name": "Activity History"},
    {"image": "assets/images/P4.png", "name": "Workout Progress"},
  ];

  List<Map<String, String>> otherArr = [
    {"image": "assets/images/P6.png", "name": "Contact Us"},
    {"image": "assets/images/P7.png", "name": "Privacy Policy"},
    {"image": "assets/images/P8.png", "name": "Settings"},
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        email = user.email ?? "No Email";
      });

      try {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            height = userDoc['height'] != null ? "${userDoc['height']} cm" : "N/A";
            weight = userDoc['weight'] != null ? "${userDoc['weight']} kg" : "N/A";
            age = userDoc['age'] != null ? "${userDoc['age']} yo" : "N/A";
          });
        } else {
          print("User document does not exist.");
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tcolor.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Tcolor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/images/DP.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email,
                          style: TextStyle(
                              color: Tcolor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Gain Muscle Program",
                          style: TextStyle(
                            color: Tcolor.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 25,
                    child: RoundButton(
                      title: "Logout",
                      type: RoundButtonType.bgGradient,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        _auth.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnboardingView()));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: TitleSubtitleCell(title: "$height", subtitle: "Height")),
                  const SizedBox(width: 15),
                  Expanded(child: TitleSubtitleCell(title: "$weight", subtitle: "Weight")),
                  const SizedBox(width: 15),
                  Expanded(child: TitleSubtitleCell(title: "$age", subtitle: "Age")),
                ],
              ),
              const SizedBox(height: 30),
              // Accounts Section
              sectionWidget("Accounts", accountArr),
              const SizedBox(height: 30),
              // Notifications Section
              sectionWidget("Notifications", [
                {"image": "assets/images/P5.png", "name": "Pop-up Notification"}
              ]),
              const SizedBox(height: 30),
              // Others Section
              sectionWidget("Others", otherArr),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionWidget(String title, List<Map<String, String>> items) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Tcolor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Tcolor.black, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 25),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return SettingRow(icon: item["image"]!, title: item["name"]!, onPressed: () {});
            },
          ),
        ],
      ),
    );
  }
}

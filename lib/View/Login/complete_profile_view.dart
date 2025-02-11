import 'package:fit/View/NavBar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Common/color_extension.dart';
import '../../Common_Widget/rounded_textfield.dart';
import '../../common_widget/round_button.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtWeight = TextEditingController();
  TextEditingController txtHeight = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? _selectedGender; // State variable for gender selection

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print("Logged in user: \${loggedInUser?.displayName ?? loggedInUser?.email}");
      }
    } catch (e) {
      print("Error retrieving user: $e");
    }
  }

  void saveUserProfileData() async {
    if (loggedInUser == null) {
      print("No logged-in user found!");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(loggedInUser!.uid).set({
        'age': txtDate.text,
        'weight': txtWeight.text,
        'height': txtHeight.text,
        'gender': _selectedGender,
        'email': loggedInUser!.email,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("User profile data saved successfully!");
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/GetStarted.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: media.width * 0.05),
                Text(
                  "Let’s complete your profile",
                  style: TextStyle(
                      color: Tcolor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: Tcolor.grey, fontSize: 12),
                ),
                SizedBox(height: media.width * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Tcolor.lightgrey,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "assets/images/Gender.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  color: Tcolor.grey,
                                )),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedGender,
                                  items: ["Male", "Female"].map((name) {
                                    return DropdownMenuItem(
                                      value: name,
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                            color: Tcolor.grey,
                                            fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  isExpanded: true,
                                  hint: Text(
                                    _selectedGender ?? "Choose Gender",
                                    style: TextStyle(
                                        color: Tcolor.grey, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                      SizedBox(height: media.width * 0.04),
                      RoundTextField(controller: txtDate, hitText: "Age", icon: "assets/images/DOB.png"),
                      SizedBox(height: media.width * 0.04),
                      RoundTextField(controller: txtWeight, hitText: "Your Weight", icon: "assets/images/weight.png"),
                      SizedBox(height: media.width * 0.04),
                      RoundTextField(controller: txtHeight, hitText: "Your Height", icon: "assets/images/height.png"),
                      SizedBox(height: media.width * 0.07),
                      RoundButton(
                        title: "Confirm",
                        onPressed: () {
                          saveUserProfileData(); // Save data to Firestore
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const Navbar(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

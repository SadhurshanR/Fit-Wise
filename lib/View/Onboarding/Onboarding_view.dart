import 'package:fit/Common_Widget/round_button.dart';
import 'package:fit/View/Login/signup_view.dart';
import 'package:flutter/material.dart';
import '../../Common/color_extension.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  bool isChangeColor = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: Container(
        width: media.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Tcolor.primaryG,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Fit Wise",
              style: TextStyle(
                color: Tcolor.black,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Everybody Can Train",
              style: TextStyle(
                color: Tcolor.grey,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupView(),
                        ),
                      );
                    },
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    textColor: Tcolor.primaryColor1,
                    minWidth: double.maxFinite,
                    color: Tcolor.white,
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                            colors: Tcolor.primaryG,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)
                            .createShader(
                          Rect.fromLTRB(0, 0, 0, 0),
                        );
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Tcolor.primaryColor1,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: media.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

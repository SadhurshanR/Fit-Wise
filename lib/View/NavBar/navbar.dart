import 'package:fit/Common/color_extension.dart';
import 'package:fit/Common_Widget/tab_button.dart';
import 'package:fit/View/Home/notification_view.dart';
import 'package:fit/View/Onboarding/Onboarding_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Home/activity_tracker_view.dart';
import '../Profile/profile_view.dart';
import '../SleepTracker/sleep_tracker_view.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectTab = 0;
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTab = const ActivityTrackerView();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: PageStorage(bucket: pageStorageBucket,child: currentTab,),

      bottomNavigationBar: BottomAppBar(
        child: Container(
          // decoration: BoxDecoration(color: Tcolor.white, boxShadow: const [
          //   BoxShadow(
          //       color: Colors.black26, blurRadius: 2, offset: Offset(0, -2)),
          // ]),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                icon: "assets/images/Home.png",
                selectIcon: "assets/images/Home.png",
                isActive: selectTab == 0,
                onTap: () {
                  currentTab = const ActivityTrackerView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              TabButton(
                icon: "assets/images/Activity.png",
                selectIcon: "assets/images/Activity.png",
                isActive: selectTab == 1,
                onTap: () {
                  currentTab =  SleepTrackerView();
                  selectTab = 1;
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              TabButton(
                icon: "assets/images/Notification.png",
                selectIcon: "assets/images/Notification.png",
                isActive: selectTab == 2,
                onTap: () {
                  currentTab = const NotificationView();
                  selectTab = 2;
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              TabButton(
                icon: "assets/images/Profile.png",
                selectIcon: "assets/images/Profile.png",
                isActive: selectTab == 3,
                onTap: () {
                  selectTab = 3;
                  currentTab = const ProfileView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

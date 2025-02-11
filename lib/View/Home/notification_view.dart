import 'package:flutter/material.dart';
import 'package:fit/Common/color_extension.dart';
import '../../Common_Widget/notification_row.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List notificationArr = [
    {"image": "assets/images/N1.png", "title": "Hey, it’s time for lunch", "time": "About 1 minute ago"},
    {"image": "assets/images/N2.png", "title": "Don’t miss your lower body workout", "time": "About 3 hours ago"},
    {"image": "assets/images/N3.png", "title": "Hey, let’s add some meals for your b..", "time": "About 3 hours ago"},
    {"image": "assets/images/N4.png", "title": "Congratulations, You have finished A..", "time": "22 May"},
    {"image": "assets/images/N5.png", "title": "Hey, it’s time for lunch", "time": "8 April"},
    {"image": "assets/images/N6.png", "title": "Oops, You have missed your Lower body workout...", "time": "3 April"},
    {"image": "assets/images/N2.png", "title": "Congratulations, You have finished A..", "time": "29 May"},
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
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/images/A1.png",
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: Text(
          "Notification",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
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
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        itemBuilder: (context, index) {
          var nObj = notificationArr[index] as Map? ?? {};
          return NotificationRow(
            nObj: nObj,
            titleStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, // Adapt to theme
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Tcolor.lightgrey,
            height: 1,
          );
        },
        itemCount: notificationArr.length,
      ),
    );
  }
}

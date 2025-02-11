import 'package:flutter/material.dart';

import '../Common/color_extension.dart';

class SettingRow extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const SettingRow({super.key,required this.icon,required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 15,
              width: 15,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Text(
                  title,
                  style:
                  TextStyle(color: Tcolor.black, fontSize: 12),
                )),
            Image.asset(
              "assets/images/Arrow.png",
              height: 12,
              width: 12,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

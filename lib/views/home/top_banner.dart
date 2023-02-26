import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Trigger a SOS in just one tap!",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.only(top: 8.0)),
        Text(
          "In case of emergencies you can trigger SOS:",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 18),
        ),
        Text(
          "➜ From Lock screen notification",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15),
        ),
        Text(
          "➜ From the notification bar",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ],
    );
  }
}

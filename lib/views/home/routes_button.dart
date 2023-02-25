import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RouteButtons extends StatelessWidget {
  const RouteButtons({
    Key? key,
    required this.size,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final Size size;
  final String title;
  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.white,
      height: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: Colors.black26,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.30,
          margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  icon,
                  height: size.height * 0.1,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

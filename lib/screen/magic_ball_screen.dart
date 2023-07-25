import 'package:flutter/material.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 2, 1),
                      Color.fromRGBO(16, 12, 44, 1),
                    ]
                )
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24.0),
            child: Image.asset("image/ball_idle.png"),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(65.0),
            child: Image.asset("image/shadow.png"),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(left: 80, right: 80, bottom: 6),
            child: RichText(
              text: const TextSpan(
                text: "Нажмите на шар или потрясите телефон",
                style: TextStyle(color: Color.fromRGBO(114, 114, 114, 1), fontSize: 12)
              ),
              textAlign: TextAlign.center,
            )
          )
        ],

      ),
    );
  }
}

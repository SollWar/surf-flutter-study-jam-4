import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/api/api_service.dart';
import 'package:surf_practice_magic_ball/model/prediction_data.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallTap();
}

class _MagicBallTap extends State<MagicBallScreen> {
  PredictionData predictionData = PredictionData(reading: "");
  String prediction = "";
  bool shadow = false;
  bool textOpacity = true;

  void _setPrediction() {
    setState(() {
      prediction = predictionData.reading;
      textOpacity = true;
    });
  }

  void _tapBall() {
    setState(() {
      shadow = true;
      textOpacity = false;
    });
    _getData();
  }

  void _getData() async {
    predictionData = (await ApiService().getPrediction())!;
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => _setPrediction());
  }

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
                ])),
          ),
          GestureDetector(
            onTap: _tapBall,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset("image/ball_idle.png"),
                ),
                AnimatedOpacity(
                    opacity: shadow ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset("image/ball_shadow.png"),
                    ),
                ),
                AnimatedOpacity(
                    opacity: textOpacity ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(24.0),
                      child: RichText(
                        text: TextSpan(
                            text: prediction,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
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
                    style: TextStyle(
                        color: Color.fromRGBO(114, 114, 114, 1), fontSize: 12)),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}

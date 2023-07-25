import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/api/api_service.dart';
import 'package:surf_practice_magic_ball/model/prediction_data.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallTap();

}

class _MagicBallTap extends State<MagicBallScreen> {
  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      _tapBall();
    });
  }

  PredictionData predictionData = PredictionData(reading: ""); // Data класс с предсказаниями
  String prediction = ""; // Текс предсказания
  bool shadow = false; // Тень у шара
  bool red = false;
  bool textOpacity = true; // Исчезновение текста

  void _setPrediction() {
    // Обновление предсказания и появление текста
    setState(() {
      if (predictionData.reading != "") {
        prediction = predictionData.reading;
        textOpacity = true;
      } else {
        shadow = true;
        red = true;
      }
    });
  }

  void _tapBall() {
    // Обработка тапа
    setState(() {
      shadow = true; // Затенение шара
      red = false;
      textOpacity = false; // Исчезновение текста
    });
    _getData(); // Запрос api
  }

  void _getData() async {
    predictionData = (await ApiService()
        .getPrediction())!; // Запроса api через класс ApiService
    Future.delayed(const Duration(
            milliseconds: 500)) // Задержка в 500 мс для имитации загрузки
        .then((value) => _setPrediction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            // Градиент
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
            // Виджет с обработкой нажатий
            onTap: _tapBall,
            child: Stack(
              children: [
                Container(
                  //Шаром
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset("image/ball_idle.png"),
                ),
                AnimatedOpacity(
                  // Тень шара
                  opacity: shadow ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(48.0),
                    child: Image.asset("image/ball_shadow.png"),
                  ),
                ),
                AnimatedOpacity(
                  // Красный шар
                  opacity: red ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(48.0),
                    child: Image.asset("image/ball_red.png"),
                  ),
                ),
                AnimatedOpacity(
                  // Текст в шаре
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
          AnimatedOpacity(
            opacity: textOpacity ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 250),
            child: Container(
              // Внешняя тень шара
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(65.0),
              child: Image.asset("image/shadow_back.png"),
            ),
          ),
          AnimatedOpacity(
            opacity: shadow ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 250),
            child: Container(
              // Внутренняя тень шара
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(65.0),
              child: Image.asset("image/shadow_center.png"),
            ),
          ),
          AnimatedOpacity(
              opacity: red ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                // Красная тень шара
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(65.0),
                child: Image.asset("image/shadow_error.png"),
              ),
            ),
          Container(
              // Надпись снизу
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

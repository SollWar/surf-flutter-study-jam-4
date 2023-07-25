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
  // Переменные для AnimatedContainer
  double curAnimBall = 23;
  double minAnimBall = 23;
  double maxAnimBall = 43;

  double curAnimShadow = 65;
  double minAnimShadow = 65;
  double maxAnimShadow = 85;

  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      _tapBall();
    });
    Future.delayed(Duration(milliseconds: 10), () { // Старт анимации
      setState(() {
        curAnimBall = maxAnimBall;
        curAnimShadow = maxAnimShadow;
      });
    });
  }

  PredictionData predictionData =
      PredictionData(reading: ""); // Data класс с предсказаниями
  String prediction = ""; // Текс предсказания
  bool shadow = false; // Тень в шаре
  bool red = false; // Красная тень
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
      red = false; // Выключение красной тени
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
          AnimatedContainer(
            duration: Duration(seconds: 2),
            padding: EdgeInsets.fromLTRB(23, 23, 23, curAnimBall),
            curve: Curves.decelerate,
            onEnd: () {
              setState(() {
                curAnimBall =
                    curAnimBall != maxAnimBall ? maxAnimBall : minAnimBall;
              });
            },
            child: GestureDetector(
              // Виджет с обработкой нажатий
              onTap: _tapBall,
              child: Stack(
                children: [
                  Container(
                    //Шар
                    alignment: Alignment.center,
                    child: Image.asset("assets/image/ball_idle.png"),
                  ),
                  AnimatedOpacity(
                    // Тень шара
                    opacity: shadow & !red ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Image.asset("assets/image/ball_shadow.png"),
                    ),
                  ),
                  AnimatedOpacity(
                    // Красный шар
                    opacity: red ? 0.8 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Image.asset("assets/image/ball_red.png"),
                    ),
                  ),
                  AnimatedOpacity(
                    // Текст в шаре
                    opacity: textOpacity ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Container(
                        alignment: Alignment.center,
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
          ),
          AnimatedContainer(
            duration: Duration(seconds: 2),
            padding: EdgeInsets.fromLTRB(curAnimShadow, 65, curAnimShadow, 65),
            curve: Curves.decelerate,
            onEnd: () {
              setState(() {
                curAnimShadow = curAnimShadow != minAnimShadow
                    ? minAnimShadow
                    : maxAnimShadow;
              });
            },
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: textOpacity ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    // Внешняя тень шара
                    alignment: Alignment.bottomCenter,
                    child: Image.asset("assets/image/shadow_back.png"),
                  ),
                ),
                AnimatedOpacity(
                  opacity: shadow ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    // Внутренняя тень шара
                    alignment: Alignment.bottomCenter,
                    child: Image.asset("assets/image/shadow_center.png"),
                  ),
                ),
                AnimatedOpacity(
                  opacity: red ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    // Красная тень шара
                    alignment: Alignment.bottomCenter,
                    child: Image.asset("assets/image/shadow_error.png"),
                  ),
                ),
              ],
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

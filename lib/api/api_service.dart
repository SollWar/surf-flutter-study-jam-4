import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:surf_practice_magic_ball/model/prediction_data.dart';


class ApiService{ // Класс работы с api

  static String baseUrl = 'https://www.eightballapi.com';
  static String apiEndpoint = '/api';

  Future<PredictionData?> getPrediction() async { // Запрос api и его обработка
    try {
      var url = Uri.parse(baseUrl + apiEndpoint); // Генерация ссылки
      var response = await http.get(url); // Отправка get запроса
      if (response.statusCode == 200) { // Обработка get запроса
        PredictionData model = predictionDataFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
      PredictionData model = PredictionData(reading: "");
      return model;
    }
  }
}
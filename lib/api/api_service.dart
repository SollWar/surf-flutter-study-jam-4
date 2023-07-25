import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:surf_practice_magic_ball/model/prediction_data.dart';


class ApiService{
  Future<PredictionData?> getPrediction() async {
    try {
      var url = Uri.parse(PredictionData.baseUrl + PredictionData.apiEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        PredictionData model = predictionDataFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
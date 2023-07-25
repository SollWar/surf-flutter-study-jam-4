import 'dart:convert';

PredictionData predictionDataFromJson(String str) => PredictionData.fromJson(json.decode(str));
String predictionDataToJson(PredictionData data) => json.encode(data.toJson());

class PredictionData {
  static String baseUrl = 'https://www.eightballapi.com';
  static String apiEndpoint = '/api';
  String reading;

  PredictionData({
    required this.reading,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) => PredictionData(
    reading: json["reading"],
  );

  Map<String, dynamic> toJson() => {
    "reading": reading,
  };
}


import 'dart:convert';

PredictionData predictionDataFromJson(String str) => PredictionData.fromJson(json.decode(str));
String predictionDataToJson(PredictionData data) => json.encode(data.toJson());

class PredictionData { // Data класс предсказаний, генерировался через app.quicktype.io

  String reading; // Значение предсказания

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


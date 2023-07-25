class SampleData { // Класс мок-данных, не используется

  String reading = ""; // Предсказание
  int counter = -1;

  SampleData(this.reading);

  void newSample() { // Метод с перечеслением предсказаний из списка
    List<String> list = [
      "Будет норм",
      "Будет не норм",
      "Будет супер",
      "Не будет"
    ];
    counter++;

    if (counter == list.length - 1) {
      counter = 0;
    }

    reading = list[counter];
  }
}
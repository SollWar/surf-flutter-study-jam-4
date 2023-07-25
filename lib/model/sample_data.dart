class SampleData {

  String reading = "";
  int counter = -1;

  SampleData(this.reading);

  void newSample() {
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
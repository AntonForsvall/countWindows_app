class Counter {
  List<Counter> counters;
  String image;
  int id;
  int value;
  DateTime date;
  bool compleated;

  Counter(this.image, this.id, this.value, this.compleated);

  factory Counter.fromJson(Map<String, dynamic> parsedJson) {
    return Counter(parsedJson['id'], parsedJson['image'], parsedJson['value'],
        parsedJson['date']);
  }
}

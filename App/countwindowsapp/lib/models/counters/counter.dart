class Counter {
  List<Counter> counters;
  String image;
  int id;
  int value;
  DateTime date;
  bool compleated;
  int projectId;

  Counter(this.image, this.id, this.value, this.compleated, this.projectId);

  factory Counter.fromJson(Map<String, dynamic> parsedJson) {
    return Counter(parsedJson['id'], parsedJson['image'], parsedJson['value'],
        parsedJson['date'], parsedJson['project_id']);
  }
}

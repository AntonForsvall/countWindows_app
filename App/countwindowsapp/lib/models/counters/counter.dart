class Counter {
  List<Counter> counters;
  String image;
  int id;
  int value;
  String date;
  bool compleated;
  int projectId;

  Counter(this.image, this.id, this.value, this.date, this.projectId);

  factory Counter.fromJson(Map<String, dynamic> parsedJson) {
    return Counter( parsedJson['image'], parsedJson['id'], parsedJson['value'],
        parsedJson['date'], parsedJson['project_id']);
  }
}

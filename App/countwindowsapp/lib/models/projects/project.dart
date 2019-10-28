class Project {
  int id;
  String projectName;
  String date;

  Project({this.id, this.projectName, this.date});

  factory Project.fromJson(Map<String, dynamic> parsedJson) {
    return new Project(
      id: parsedJson['id'],
      projectName: parsedJson['projectName'],
      date: parsedJson['date']);
  }
}

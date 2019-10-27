class Project {
  List<Project> projects;
  int id;
  String projectName;
  String date;

  Project(this.id, this.projectName, this.date);

  factory Project.fromJson(Map<String, dynamic> parsedJson) {
    return Project(
        parsedJson['id'], parsedJson['project_name'], parsedJson['date']);
  }
}

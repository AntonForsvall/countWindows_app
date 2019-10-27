import 'package:countwindowsapp/models/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:countwindowsapp/models/projects/project.dart';

class ProjectBloc {
  final _repository = Repository();
  final _projectGetter = PublishSubject<Project>();

  Observable<Project> get getProject => _projectGetter.stream;

  saveProject(String projectName, String date, String apiKey) async {
    Project project = await _repository.saveProject(projectName, date, apiKey);
    _projectGetter.sink.add(project);
  }

  dispose() {
    _projectGetter.close();
  }
}

final projectBloc = ProjectBloc();

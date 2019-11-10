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

class GetProjectBloc {
  final _repository = Repository();
  final _projectSubject = BehaviorSubject<List<Project>>();
  String apiKey;

  var _projects = <Project>[];

  GetProjectBloc(String api_key) {
    this.apiKey = api_key;
    _updateProjects(api_key).then((_) {
      _projectSubject.add(_projects);
    });
  }
  
    Stream<List<Project>> get getProjects => _projectSubject.stream;

    Future<Null> _updateProjects(String apiKey) async {
    _projects = await _repository.getUserProjects(apiKey);
  }
}

class DeleteProjectBloc {
  final _repository = Repository();


  deleteProject(String apiKey, int projectId) async {
    await _repository.deleteProject(apiKey, projectId);
  }

}

final projectBloc = ProjectBloc();
final deleteProjectBloc = DeleteProjectBloc();

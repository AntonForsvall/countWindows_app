import 'package:countwindowsapp/models/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:countwindowsapp/models/users/user.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<User>();

  Observable<User> get getUser => _userGetter.stream;

  registerUser(String company, String email,
      String password) async {
    User user = await _repository.registerUser(company, email, password);
    _userGetter.sink.add(user);
  }

  signinUser(String company, String password, String apiKey) async {
    User user = await _repository.signinUser(company, password, apiKey);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

final userBloc = UserBloc();

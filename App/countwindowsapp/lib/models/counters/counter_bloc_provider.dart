import 'dart:async';

import 'package:countwindowsapp/models/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:countwindowsapp/models/counters/counter.dart';

class CounterBloc {
  final _repository = Repository();
  final _counterGetter = PublishSubject<Counter>();

  Observable<Counter> get getCounter => _counterGetter.stream;

  saveCounter(String image, int value, String date, String apiKey, int projectId) async {
    Counter counter = await _repository.saveCounter(image, value, date, apiKey, projectId);
    _counterGetter.sink.add(counter);
  }

  dispose() {
    _counterGetter.close();
  }
}

class GetCounterBloc {
  final _repository = Repository();
  final _counterSubject = BehaviorSubject<List<Counter>>();

  var _projects = <Counter>[];

  GetCounterBloc(String apiKey, int projectId) {
    _updateCounters(apiKey, projectId).then((_) {
      _counterSubject.add(_projects);
    });
  }
  
    Stream<List<Counter>> get getCounters => _counterSubject.stream;

    Future<Null> _updateCounters(String apiKey, int projectId) async {
    _projects = await _repository.getUserCounters(apiKey, projectId);
  }
}

final counterBloc = CounterBloc();

import 'package:countwindowsapp/models/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:countwindowsapp/models/counters/counter.dart';

class CounterBloc {
  final _repository = Repository();
  final _counterGetter = PublishSubject<Counter>();

  Observable<Counter> get getCounter => _counterGetter.stream;

  saveCounter(String image, int value, String date, String apiKey) async {
    Counter counter = await _repository.saveCounter(image, value, date, apiKey);
    _counterGetter.sink.add(counter);
  }

  dispose() {
    _counterGetter.close();
  }
}

final counterBloc = CounterBloc();

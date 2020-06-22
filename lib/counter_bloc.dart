import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'counter_event.dart';
import 'couter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => CounterState.initial();

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    print(event.runtimeType);
    if (event is IncrementEvent) {
      yield CounterState(counter: state.counter + 1);
      print(state.counter);
    } else if (event is DecrementEvent) {
      yield CounterState(counter: state.counter - 1);
      print(state.counter);
    }
  }
}

import 'package:rxdart/rxdart.dart';
import 'package:flutter_template/common/event.dart';
import 'package:flutter_template/domain/managers/mock_manager.dart';
import 'package:flutter_template/domain/models/mock_data.dart';
import 'package:flutter_template/presentation/assets/error_messages.dart';
import 'package:flutter_template/presentation/ui/_base/base_bloc.dart';

class HomeBloc extends BaseBloc {
    MockManager _mockManager;

    /// Event to fetch new data
    var _fetchNewDataSubject = PublishSubject<Event>();
    Sink<Event> get fetchNewDataSink => _fetchNewDataSubject.sink;

    /// Event to relay MockData information to the UI
    var _mockDataSubject = BehaviorSubject<MockData>();
    Stream<MockData> get mockDataStream => _mockDataSubject.stream;

    HomeBloc(this._mockManager) {
      disposable.add(
          _fetchNewDataSubject
            .stream
            .flatMap((_) => _mockManager.getMockData())
            .listen(_mockDataSubject.add, onError: (error) {
              print(error);
              handleOnError(genericErrorMessage);
          })
      );
    }
}
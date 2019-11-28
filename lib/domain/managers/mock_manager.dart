import 'package:rxdart/rxdart.dart';
import 'package:flutter_template/data/remote/services/mock_service.dart';
import 'package:flutter_template/domain/mappers/mock_data_mapper.dart';
import 'package:flutter_template/domain/models/mock_data.dart';

class MockManager {
  MockService _mockService;
  MockDataRemoteMapper _mockMapper;

  MockManager(this._mockService, this._mockMapper);

  Observable<MockData> getMockData() {
    return _mockService.getMockData()
        .map(_mockMapper.map);
  }
}
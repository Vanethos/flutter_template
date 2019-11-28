import 'package:flutter/material.dart';
import 'package:flutter_template/constants.dart';
import 'package:flutter_template/data/remote/endpoints/mock_endpoints.dart';
import 'package:flutter_template/data/remote/models/_base/parser.dart';
import 'package:flutter_template/data/remote/services/mock_service.dart';
import 'package:flutter_template/data/shared_preferences/template_shared_preferences.dart';
import 'package:flutter_template/di/network_dependencies.dart';
import 'package:flutter_template/domain/managers/mock_manager.dart';
import 'package:flutter_template/domain/managers/shared_preferences_manager.dart';
import 'package:flutter_template/domain/mappers/mock_data_mapper.dart';
import 'package:flutter_template/presentation/ui/home/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// As an [InheritedWidget] this class will provide its childs the objects it hold
///
/// By accessing [of] and providing a [BuildContext] we can access, for example, the [Config] instance.
/// Usage: `var provider = DependencyProvider.of(context);`
class DependencyProvider extends InheritedWidget {

  DependencyProvider({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  MockManager _cowManager;

  SharedPreferencesManager _sharedPreferencesManager;

  HomeBloc _homeBloc;

  HomeBloc getHomeBloc({bool forceCreation = false}) {
    if (_homeBloc == null || forceCreation) {
      _homeBloc = HomeBloc(_cowManager);
    }
    return _homeBloc;
  }

  /// Initializes app dependencies,
  Future<bool> initialize() async {
    // Storage Dependencies
    var sharedPrefences = await SharedPreferences.getInstance();
    var appPreferences = TemplateSharedPreferences(sharedPrefences);
    _sharedPreferencesManager = SharedPreferencesManager(appPreferences);

    // Interceptors
    var loggingInterceptor = getLoggingInterceptor();
    var errorInterceptor = getErrorInterceptor(loggingInterceptor);
    var responseInterceptor =
    getResponseInterceptor(loggingInterceptor);
    var requestInterceptor =
    getRequestInterceptor(loggingInterceptor);

    // network dependencies
    var dioOptions = createDioOptions(
        "https://jsonplaceholder.typicode.com/", connectionTimeout, connectionReadTimeout);
    var dio = await createDio(dioOptions, errorInterceptor,
        responseInterceptor, requestInterceptor);
    var parser = Parser();

    // endpoints
    var mockEndpoints = MockEndpoints(dio);

    // Services
    var mockServices = MockService(mockEndpoints, parser);

    // Mappers
    var mockMappers = MockDataRemoteMapper();

    // Managers
    _cowManager = MockManager(mockServices, mockMappers);
  }


  /// Since we just want to creat the dependencies once, at the start of the app, we won't need
  /// update this widget
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static DependencyProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DependencyProvider)
    as DependencyProvider);
  }
}
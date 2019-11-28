import 'package:flutter/material.dart';
import 'package:flutter_template/di/dependency_provider.dart';
import 'package:flutter_template/presentation/navigation/navigation.dart';
import 'package:flutter_template/presentation/ui/home/home_page.dart';

class FlutterTemplateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: routeHome,
      routes: {
        routeHome: (context) => HomePage(title: 'flutter_template App', bloc: DependencyProvider.of(context).getHomeBloc(),),
      },
    );
  }
}
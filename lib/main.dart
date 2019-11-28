import 'package:flutter/material.dart';
import 'package:flutter_template/di/dependency_provider.dart';
import 'package:flutter_template/presentation/app.dart';

void main() async {
  var dependencyProvider = DependencyProvider(child : FlutterTemplateApp());
  await dependencyProvider.initialize();
  runApp(dependencyProvider);
}



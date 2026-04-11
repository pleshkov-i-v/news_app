import 'package:flutter/material.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/news_app.dart';

void main() {
  configureDependencies();
  runApp(const NewsApp());
}

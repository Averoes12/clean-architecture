import 'package:clean_architecture/app/imdb_clone_app.dart';
import 'package:clean_architecture/core/di/di_container.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:imdb_localization/strings.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initDi();
  runApp(
    TranslationProvider(child: ImdbCloneApp())
  );
  
}

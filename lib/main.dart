import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos/Bloc/Notes/notes_bloc.dart';
import 'package:todos/Models/NoteModels.dart';
import 'package:todos/Screens/HomePage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelsAdapter());
  await Hive.openBox<NoteModels>('mestodos');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(),
      child: MaterialApp(
        title: 'Todo app',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todos/Models/NoteModels.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(TodosInitialState()) {
 
     on<AddTodo>((event, emit) async {
    var box = Hive.box<NoteModels>('mestodos');

    var noteModel = NoteModels(
      title: event.title,
      body: event.body,
      isComplete: event.isComplete,
    );
    box.add(noteModel);
    });


     on<UpdateNoteEvent>((event, emit) async {
var box = Hive.box<NoteModels>('mestodos');

    var noteModel = NoteModels(
      title: event.title,
      body: event.body,
      isComplete: event.isComplete,
    );

    box.putAt(event.index, noteModel);
    });   
    
    
      on<DeleteNoteEvent>((event, emit) async {
 var box = Hive.box<NoteModels>('mestodos');

    box.deleteAt(event.index);
    });


  }




}

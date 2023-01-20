part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent extends Equatable {

}

class AddTodo extends NotesEvent {
  final String title;
  final String body;
  final bool isComplete;

  AddTodo({required this.title, required this.body, required this.isComplete});
  
  @override
  // TODO: implement props
  List<Object?> get props => [title, body, isComplete];
}

class SelectedColorEvent extends NotesEvent {
  final int color;

  SelectedColorEvent(this.color);
  
  @override
  // TODO: implement props
  List<Object?> get props => [color];
}

class UpdateNoteEvent extends NotesEvent {
  final String title;
  final String body;
  final bool isComplete;
  final int index;

  UpdateNoteEvent(
      {required this.title,
      required this.body,
      required this.isComplete,
      required this.index});    
        @override
        // TODO: implement props
        List<Object?> get props => [title, body, index, isComplete];
}

class DeleteNoteEvent extends NotesEvent {
  final int index;

  DeleteNoteEvent(this.index);
  
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}



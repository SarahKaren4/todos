part of 'notes_bloc.dart';


abstract class NotesState  extends Equatable{


}

class TodosInitialState extends NotesState {
  @override
  List<Object> get props => [];
}

class TodosLoadedState extends NotesState {
  @override
  List<Object> get props => [];
}

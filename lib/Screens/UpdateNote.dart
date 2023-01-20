import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/Bloc/Notes/notes_bloc.dart';
import 'package:todos/Models/NoteModels.dart';

class ShowNotePage extends StatefulWidget {
  final NoteModels note;
  final int index;

  const ShowNotePage({required this.note, required this.index});

  @override
  _ShowNotePageState createState() => _ShowNotePageState();
}

class _ShowNotePageState extends State<ShowNotePage> {
  late TextEditingController _titleController =
      TextEditingController(text: widget.note.title);
  late TextEditingController _noteController =
      TextEditingController(text: widget.note.body);

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NotesBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF2F3F7),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F3F7),
        elevation: 0,
        title: Text(
          widget.note.title!,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Center(
                child: Text(
              'Annuler',
              style: TextStyle(fontSize: 15, color: Color(0xff0C6CF2)),
            ))),
        actions: [
          InkWell(
            onTap: () {
              context.read<NotesBloc>().add(UpdateNoteEvent(
                  title: _titleController.text,
                  body: _noteController.text,
                  //isComplete: widget.note.isComplete!,
                  isComplete: false,
                  index: widget.index));

              _titleController.clear();
              _noteController.clear();

              Navigator.pop(context);
            },
            child: Container(
                alignment: Alignment.center,
                width: 60,
                child: Text(
                  'Sauver',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff0C6CF2),
                  ),
                )),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Titre',
                        contentPadding: EdgeInsets.only(left: 10.0)),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextField(
                    controller: _noteController,
                    // style: GoogleFonts.getFont('Inter'),
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ecrivez quelque chose...',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

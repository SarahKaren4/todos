import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos/Bloc/Notes/notes_bloc.dart';
import 'package:todos/Models/NoteModels.dart';
import 'package:todos/Screens/AddNotePage.dart';

import 'UpdateNote.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NotesBloc>(context);
    final box = Hive.box<NoteModels>('mestodos');

    return Scaffold(
      appBar: AppBar(title: Text("Mes notes")),
      backgroundColor: Color(0xffF2F3F7),
      body: SafeArea(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (_, Box box, __) {
              if (box.values.isEmpty) {
                return Center(
                  child: Text(
                    'Aucun todo',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                );
              }

              return BlocBuilder<NotesBloc, NotesState>(builder: (_, state) {
                return Column(
                  children: [
                    _ListNotes(),
                  ],
                );
              });
            },
          ),
        ],
      )),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddNotePage())),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xff1977F3),
          child: const Icon(Icons.mode_edit_outline, color: Colors.white),
        ),
      ),
    );
  }
}

class _ListNotes extends StatelessWidget {
  const _ListNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NotesBloc>(context);
    final box = Hive.box<NoteModels>('mestodos');

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: box.values.length,
        itemBuilder: (_, i) {
          NoteModels note = box.getAt(i)!;
          return Dismissible(
            key: Key(note.title!),
            background: Container(),
            direction: DismissDirection.endToStart,
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 35.0),
              margin: EdgeInsets.only(bottom: 15.0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))),
              child: Icon(Icons.delete_sweep_rounded,
                  color: Colors.white, size: 40),
            ),
            onDismissed: (direction) => noteBloc.add(DeleteNoteEvent(i)),
            child: Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 5.0),
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note.title.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    note.body.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                          value: note.isComplete,
                          onChanged: (_) {
                            context.read<NotesBloc>().add(UpdateNoteEvent(
                                title: note.title!.toString(),
                                body: note.body!.toString(),
                                isComplete: !note.isComplete!,
                                index: i));
                          }),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ShowNotePage(note: note, index: i)));
                            print("Edit " + i.toString());
                          },
                          child:
                              Icon(Icons.edit, color: Colors.black, size: 20)),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


/**
 * context.read<NotesBloc>().add(UpdateNoteEvent(
                  title: _titleController.text,
                  body: _noteController.text,
                  isComplete: false,
                  index: widget.index));


                Checkbox(
                        //key: FlutterTodosKeys.detailsScreenCheckBox,
                        value: note.isComplete,
                        onChanged: (_) {
                          context.read<NotesBloc>().add(UpdateNoteEvent(
                              title: note.title!.toString(),
                              body: note.body!.toString(),
                              isComplete: !note.isComplete!,
                              index: i));
                        }),
                    

 */
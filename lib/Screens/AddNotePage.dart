import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/Bloc/Notes/notes_bloc.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NotesBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF2F3F7),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F3F7),
        elevation: 0,
        title: Text(
          'Créer une note',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Text(
                'Annuler',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            )),
        actions: [
          InkWell(
            onTap: () {
              if (_titleController.text.isNotEmpty &&
                  _noteController.text.isNotEmpty) {
                context.read<NotesBloc>().add(AddTodo(
                      title: _titleController.text,
                      body: _noteController.text,
                      isComplete: false,
                    ));

                _titleController.clear();
                _noteController.clear();
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.black12,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    content: SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              child: const Icon(Icons.dangerous,
                                  color: Colors.white, size: 38),
                            ),
                          ),
                          const SizedBox(height: 35.0),
                          Text(
                            "Vous devez ajouter du contenu",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 20.0),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: const Text(
                                'Ok',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(
                alignment: Alignment.center,
                width: 60,
                child: Text(
                  "Sauver",
                  style: TextStyle(fontSize: 15, color: Colors.black),
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

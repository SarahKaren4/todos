import 'package:hive/hive.dart';

part 'NoteModels.g.dart';

@HiveType(typeId: 1)
class NoteModels {

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? body;

  @HiveField(2)
  bool? isComplete;



  NoteModels({ this.title, this.body, this.isComplete});

}

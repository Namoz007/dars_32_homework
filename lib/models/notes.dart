import 'package:json_annotation/json_annotation.dart';
import 'package:working/views/screens/notes.dart';

part 'notes.g.dart';

@JsonSerializable()
class Note{
  int id;
  String description;
  DateTime date;
  Note({required this.id,required this.description,required this.date});


  factory Note.fromJson(Map<String, dynamic> json){
    return _$NoteFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$NoteToJson(this);
  }
}
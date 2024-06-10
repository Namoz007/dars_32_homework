import 'package:working/models/contact.dart';
import 'package:working/models/notes.dart';
import 'package:working/services/local_database.dart';
import 'package:working/services/notes_local_database.dart';

class NotesController{
  final db = NotesLocalDatabase();
  List<Note> notes = [];

  Future<List<Note>> getNotes() async{
    final data = await db.database;
    List<Note> response = await db.getNotes();

    if(response == null){
      print('Malumot mavjud emas');
      return [];
    }else{
      if(notes.length == 0){
        notes = response;
        return  notes;
      }else{
        for(int i = 0;i < response.length;i++){
          bool isHave = false;
          for(int j = 0;j < notes.length;j++)
            if(response[i].id == notes[j].id){
              isHave = true;
            }
          if(!isHave){
            notes.add(response[i]);
          }
        }
        print('Malumotlar mavjud');
        return notes;
      }
    }
  }

  Future<void> addNote(Note note) async{
    final response = await db.addNote(note);
  }


  Future<void> deleteNote(int id) async{
    final response = await db.deleteNote(id);
    for(int i = 0;i < notes.length;i++)
      if(notes[i].id == id)
         notes.removeAt(i);
  }

  Future<void> editNote(Note note) async{
    await deleteNote(note.id);
    for(int i = 0;i < notes.length;i++)
      if(notes[i].id == note.id)
        notes.removeAt(i);

    await db.addNote(note);
    notes.add(note);
  }
}
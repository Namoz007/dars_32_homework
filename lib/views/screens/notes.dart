import 'package:flutter/material.dart';
import 'package:working/controllers/notes_controller.dart';
import 'package:working/models/notes.dart';
import 'package:working/views/widgets/add_note.dart';
import 'package:working/views/widgets/custom_drawer.dart';
import 'package:working/views/widgets/edit_note.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final controller = NotesController();
  bool isLoading = true;

  void addNote(Note note) async {
    setState(() {
      isLoading = true;
    });
    await controller.db.addNote(note);
    setState(() {
      isLoading = false;
    });
  }

  void editNote(Note note) {
    setState(() {
      isLoading = true;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: controller.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Kechirasiz, malumot olishda xato yuzaga keldi!",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "Hozircha Eslatmalar mavjud emas!",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            );
          }

          final List<Note> notes = snapshot.data as List<Note>;
          print(notes);
          return Column(
            children: [
              IconButton(
                  onPressed: () async {
                    final data = await showDialog(
                        context: context,
                        builder: (ctx) {
                          return AddNote(notes: notes);
                        });

                    if(data != null){
                      await controller.db.addNote(data);
                      setState(() {});
                    }
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Eslatma qoshish",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              notes.length == 0
                  ? Center(
                child: Text(
                  "Hozircha eslatmalar mavjud emas",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              )
                  : Column(
                children: [
                  for(int i = 0;i < notes.length;i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 5,),
                                  Text("${notes[i].description}",style: TextStyle(fontSize: 20,color: Colors.green),),
                                  SizedBox(height: 10,),
                                  Text("${notes[i].date.day}/${notes[i].date.month}/${notes[i].date.year}")
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(onPressed: () async{
                                    final data = await showDialog(context: context, builder: (ctx){
                                      return EditNote(note: notes[i]);
                                    });

                                    if(data != null){
                                      await controller.editNote(data);
                                      setState(() {});
                                    }
                                  }, icon: Icon(Icons.edit)),

                                  IconButton(onPressed: () async{
                                    await controller.deleteNote(i);
                                    setState(() {});
                                  }, icon: Icon(Icons.delete,color: Colors.red,))
                                ],
                              )
                            ],
                          )
                      ),
                    )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

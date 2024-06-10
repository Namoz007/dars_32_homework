import 'package:flutter/material.dart';
import 'package:working/models/contact.dart';
import 'package:working/models/notes.dart';

class AddNote extends StatefulWidget {
  List<Note> notes;
  AddNote({super.key, required this.notes});

  @override
  State<AddNote> createState() => _AddContactState();
}

class _AddContactState extends State<AddNote> {
  final formKey = GlobalKey<FormState>();
  TextEditingController noteDescription = TextEditingController();
  DateTime? date;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Eslatma qoshish"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Text(
                  error,
                  style: TextStyle(fontSize: 20, color: Colors.red),
                )),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Eslamat tavsifi bosh bolmasligi kerak';
                }
                return null;
              },
              controller: noteDescription,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Eslatma tavsifi"),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Bekor qilish')),
        ElevatedButton(onPressed: () {
          if(formKey.currentState!.validate()){
            if(widget.notes.length == 0){
              Navigator.of(context).pop(Note(id: 0, description: noteDescription.text, date: DateTime.now()));
            }else{
              Navigator.of(context).pop(Note(id: widget.notes[widget.notes.length - 1].id + 1, description: noteDescription.text, date: DateTime.now()));
            }
          }
        }, child: Text("Saqlash"))
      ],
    );
  }
}

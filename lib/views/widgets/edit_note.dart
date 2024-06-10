import 'package:flutter/material.dart';
import 'package:working/models/contact.dart';
import 'package:working/models/notes.dart';

class EditNote extends StatefulWidget {
  Note note;
  EditNote({super.key, required this.note});

  @override
  State<EditNote> createState() => _EditContactState();
}

class _EditContactState extends State<EditNote> {
  final formKey = GlobalKey<FormState>();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit note"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Eslatma tavsifi bosh bolmasligi kerak';
                }

                return null;
              },
              controller: description,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name'
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Bekor qilish")),

        ElevatedButton(onPressed: () async{
          if(formKey.currentState!.validate()){
            Navigator.of(context).pop(Note(id: widget.note.id, description: description.text, date: DateTime.now()));
          }
        }, child: Text("Saqlash")),

      ],
    );
  }
}

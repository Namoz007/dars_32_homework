import 'package:flutter/material.dart';
import 'package:working/models/contact.dart';

class EditContact extends StatefulWidget {
  Contact contact;
  EditContact({super.key, required this.contact});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController imgUrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit contact"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Kontakt nomi bosh bolmasligi kerak';
                }

                return null;
              },
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name'
              ),
            ),
            SizedBox(height: 30,),

            TextFormField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Kontakt raqami bosh bolmasligi kerak';
                }

                return null;
              },
              controller: number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Number'
              ),
            ),
            SizedBox(height: 30,),

            TextFormField(
              controller: imgUrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ImgUrl'
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
            Navigator.of(context).pop(Contact(id: widget.contact.id, name: name.text, number: number.text,imgUrl: imgUrl.text));
          }
        }, child: Text("Saqlash")),

      ],
    );
  }
}

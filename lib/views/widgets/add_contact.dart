import 'package:flutter/material.dart';
import 'package:working/models/contact.dart';

class AddContact extends StatefulWidget {
  List<Contact> contacts;
  AddContact({super.key, required this.contacts});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final formKey = GlobalKey<FormState>();
  TextEditingController contactName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController contactImgUrl = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Kontakt qoshish"),
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
                  return 'Kontakt raqam nomi bosh bolmasligi kerak';
                }
                return null;
              },
              controller: contactName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Kontakt nomi"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kontakt raqami bosh bolmasligi kerak';
                }

                try {
                  int number = int.parse(value);

                  return null;
                } catch (e) {
                  return 'Kontakt raqami raqamlardan iborat bolishi kerak';
                }
              },
              controller: contactNumber,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Kontakt raqam'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Kontakt surati(ihtiyoriy)'),
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
            if(widget.contacts.length == 0){
              Navigator.of(context).pop(Contact(id: 0, name: contactName.text, number: contactNumber.text,imgUrl: contactImgUrl.text));
            }else{
              bool isNumber = false;
              for(int i = 0;i < widget.contacts.length;i++)
                if(widget.contacts[i].number == contactNumber.text)
                  isNumber = true;

              if(isNumber){
                setState(() {
                  error = 'Bunaqa kontakt mavjud';
                });
              }else{
                Navigator.of(context).pop(Contact(id: widget.contacts[widget.contacts.length - 1].id + 1, name: contactName.text, number: contactNumber.text,imgUrl: contactImgUrl.text));
              }
            }
          }
        }, child: Text("Saqlash"))
      ],
    );
  }
}

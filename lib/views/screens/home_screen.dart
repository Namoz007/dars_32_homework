import 'package:flutter/material.dart';
import 'package:working/controllers/contact_controller.dart';
import 'package:working/models/contact.dart';
import 'package:working/views/widgets/add_contact.dart';
import 'package:working/views/widgets/custom_drawer.dart';
import 'package:working/views/widgets/edit_contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ContactController();
  bool isLoading = true;

  void addContact(Contact contact) async {
    setState(() {
      isLoading = true;
    });
    await controller.db.addContact(contact);
    setState(() {
      isLoading = false;
    });
  }

  void editContact(Contact contact) {
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
        title: Text("Contacts"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: controller.getContacts(),
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
                "Hozircha kontaktlar mavjud emas!",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            );
          }

          final List<Contact> contacts = snapshot.data as List<Contact>;
          print('Bu kelayotgan maluadfasfdmot $contacts');
          return Column(
            children: [
              IconButton(
                  onPressed: () async {
                    final data = await showDialog(
                        context: context,
                        builder: (ctx) {
                          return AddContact(contacts: contacts);
                        });

                    if(data != null){
                      await controller.db.addContact(data);
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
                        "Kontakt qoshish",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              contacts.length == 0
                  ? Center(
                      child: Text(
                        "Hozircha kontaktlar mavjud emas",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    )
                  : Column(
                children: [
                  for(int i = 0;i < contacts.length;i++)
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
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Text("${contacts[i].name}",style: TextStyle(fontSize: 20,color: Colors.green),),
                                SizedBox(width: 20,),
                                Text("${contacts[i].number}")
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: () async{
                                  final data = await showDialog(context: context, builder: (ctx){
                                    return EditContact(contact: contacts[i]);
                                  });

                                  if(data != null){
                                    await controller.editContact(data);
                                    setState(() {});
                                  }
                                }, icon: Icon(Icons.edit)),

                                IconButton(onPressed: () async{
                                  await controller.deleteContact(i);
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

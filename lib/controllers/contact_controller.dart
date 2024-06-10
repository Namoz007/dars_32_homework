import 'package:working/models/contact.dart';
import 'package:working/services/local_database.dart';

class ContactController{
  final db = ContactsLocalDatabase();
  List<Contact> contacts = [];

  Future<List<Contact>> getContacts() async{
    final data = db.database;
    List<Contact> response = await db.getContacts();

    if(response == null){
      print('Malumot mavjud emas');
      return [];
    }else{
      if(contacts.length == 0){
        contacts = response;
        return contacts;
      }else{
        for(int i = 0;i < response.length;i++){
          bool isHave = false;
          for(int j = 0;j < contacts.length;j++)
            if(response[i].id == contacts[j].id){
              isHave = true;
            }
          if(!isHave){
            contacts.add(response[i]);
          }
        }
        print('Malumotlar mavjud');
        return contacts;
      }
    }
  }

  Future<void> addContact(Contact contact) async{
    final response = await db.addContact(contact);
  }


  Future<void> deleteContact(int id) async{
    final response = await db.deleteContact(id);
    for(int i = 0;i < contacts.length;i++)
      if(contacts[i].id == id)
        contacts.removeAt(i);
  }

  Future<void> editContact(Contact contact) async{
    await deleteContact(contact.id);
    for(int i = 0;i < contacts.length;i++)
      if(contacts[i].id == contact.id)
        contacts.removeAt(i);

    await db.addContact(contact);
    contacts.add(contact);
  }
}
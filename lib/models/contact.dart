
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact{
  int id;
  String name;
  String number;
  String? imgUrl;
  Contact({required this.id,required this.name,required this.number,this.imgUrl});


  factory Contact.fromJson(Map<String, dynamic> json){
    return _$ContactFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$ContactToJson(this);
  }
}
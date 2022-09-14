import 'package:flutter/material.dart';
import 'dob_model.dart';
import 'name_model.dart';
import 'user_id.dart';
import 'picture_model.dart';
import 'location_model.dart';

class UserModel extends ChangeNotifier{
Id? id;
Name? name;
String? email;
String? phone;
Dob? dob;
String? gender;
Picture? picture;
Location? location;


UserModel({
  this.name,
  this.email,
  this.phone,
  this.dob,
  this.gender,
  this.picture,
});

final List<UserModel> _users = [];
UserModel.fromJson(Map<String,dynamic> json){
  name = json['name'] != null ? Name.fromJson(json['name']) : null;
  email = json['email'];
  phone = json['phone'];
  dob = json['dob'] != null ? Dob.fromJson(json['dob']) : null;
  gender = json['gender'];
  picture = json['picture'] != null ? Picture.fromJson(json['picture']) : null;
  location = json['location'] != null ? Location.fromJson(json['location']) : null;
}

Map<String,dynamic> toJson(){
  final Map<String, dynamic> data =  <String, dynamic>{};
  data['gender'] = gender;
  if (name != null) {
    data['name'] = name!.toJson();
  }
  data['email'] = email;
  data['phone'] = phone;
  if (dob != null) {
    data['dob'] = dob!.toJson();
  }
  if(id != null){
    data['id'] = id!.toJson();
  }
  if(picture != null){
    data['picture'] = picture!.toJson();
  }
  if(location != null){
    data['location'] = location!.toJson();
  }

  return data;
}


}
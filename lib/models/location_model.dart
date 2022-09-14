import 'package:user_list/models/street_model.dart';

class Location {
  Street? street;
  String? city;
  String? state;
  String? country;
  String? postcode;

  Location(
      {this.street,
        this.city,
        this.state,
        this.country,
        this.postcode,
        });

  Location.fromJson(Map<String, dynamic> json) {
    street =
    json['street'] != null ? Street.fromJson(json['street']) : null;
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postcode = json['postcode'].toString() ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (street != null) {
      data['street'] = street!.toJson();
    }
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['postcode'] = postcode;

    return data;
  }
}
import 'package:http/http.dart' as http;

class UsersDataRepo{
     String gender;
     int dataLength;
     UsersDataRepo({required this.gender,required this.dataLength});

    // calling the API.
    Future<dynamic> fetchData() async{
    String url = "https://randomuser.me/api/?results=$dataLength";
    print('Gender Passed is ${gender}');
    if(gender == "Male"){
      url = "https://randomuser.me/api/?gender=male&results=$dataLength";

    }
    else if(gender == "Female"){
      url = "https://randomuser.me/api/?gender=female&results=$dataLength";
    }
    print(url);
    return await http.get(Uri.parse(url)).catchError((onError){
      print(onError);
      throw onError;
    });

  }
}
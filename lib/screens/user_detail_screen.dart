import 'package:flutter/material.dart';
import 'package:user_list/models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  UserModel userModel;
  UserDetailsScreen({Key? key,required this.userModel}) : super(key: key);
   var boxDecoration = BoxDecoration(
    borderRadius:  BorderRadius.circular(10),
    color: const Color.fromRGBO(155, 155, 155, 0.3),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(

      toolbarHeight: MediaQuery.of(context).size.height/10,
      title: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: Text('${userModel.name!.title!} ${userModel.name!.first!} ${userModel.name!.last!}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.pop(context);
        },),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Color.fromRGBO(174, 0, 87, 3),
                Color.fromRGBO(122, 0, 108, 3),
                Color.fromRGBO(74, 0, 128, 3)]),
        ),
      ),
    ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: CircleAvatar(
                radius: 130,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userModel.picture!.large!),
                  radius: 120,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(148, 132,167, 3),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(20),
              decoration: boxDecoration,
              child: Column(
                children: [
                Text('${userModel.name!.title!} ${userModel.name!.first!} ${userModel.name!.last!}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text('${userModel.email}',
                     style: const TextStyle(
                     fontSize: 20
                  ),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone,),
                      Text('${userModel.phone}'),
                    ],
                  ),

                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(148, 132,167, 3),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(20),
              decoration: boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on),
                  Text('${userModel.location!.country!}, ${userModel.location!.state!}, ${userModel.location!.country!}'),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(148, 132,167, 3),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(20),
              decoration: boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today),
                  Text(userModel.dob!.date!.toString()),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(148, 132,167, 3),
            ),

          ],
        ),
      ),
    );
  }
}

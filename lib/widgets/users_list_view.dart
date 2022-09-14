import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Screens/user_detail_screen.dart';
import '../models/user_model.dart';
import '../repositories/users_data_repo.dart';
import 'image_widget.dart';

class UsersListView extends StatefulWidget {
  final String gender;
  const UsersListView( {Key? key,required this.gender}) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {

  final ScrollController _scrollController = ScrollController();
  dynamic response;
  List<UserModel> _users = [];

  late UsersDataRepo usersdataRepo = UsersDataRepo(gender: widget.gender,dataLength: 80);

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(pagination);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void pagination(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){

    }
  }
  Future<dynamic> _fetchData() async {
    try {
      response = await usersdataRepo.fetchData();
      _users = List<UserModel>.from(
          json.decode(response.body)['results'].map((item) {
            return UserModel.fromJson(item);
          }));
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, dataSnapshot) {
      if (dataSnapshot.connectionState == ConnectionState.waiting) {
        print('Waiting......');
        return const Center(
          child: SpinKitThreeInOut(
            color: Color.fromRGBO(174, 0, 87, 3),
            size: 50.0,
          ),
        );
      } else if (dataSnapshot.error != null) {
        return AlertDialog(
          content: const Text('Something went wrong'),
          title: Text(dataSnapshot.error.toString()),
        );
      } else {
        return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {

                String fullName =
                    "${_users[index].name!.title!} ${_users[index].name!.first!} ${_users[index].name!.last!}";
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserDetailsScreen(userModel: _users[index])));
                      },
                      leading: ImageWidget(users: _users,index:index),
                      title: Text(
                        fullName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_users[index].email!),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Divider(
                        color: Color.fromRGBO(148, 132, 167, 3),
                        thickness: 1,
                      ),
                    )
                  ],
                );
              },
              itemCount: _users.length,
            );

      }
    });
  }
}



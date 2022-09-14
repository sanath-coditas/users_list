import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_list/repositories/users_data_repo.dart';

import '../Screens/user_detail_screen.dart';
import '../models/user_model.dart';
import 'image_widget.dart';

class PaginatedListView extends StatefulWidget {
  final String gender;
  const PaginatedListView({Key? key,required this.gender}) : super(key: key);

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  late List<UserModel> _users;
  final int _nextPageTrigger = 3;

  Future<dynamic> _fetchData() async {
    try {
      UsersDataRepo userdataRepo = UsersDataRepo(gender: widget.gender,dataLength: _numberOfPostsPerRequest);
      final response = await userdataRepo.fetchData();
      var userList = List<UserModel>.from(
          json.decode(response.body)['results'].map((item) {
            return UserModel.fromJson(item);
          }));

      setState(() {
        _isLastPage = userList.length < _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _users.addAll(userList);
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    print("called");
    _pageNumber = 0;
    _users = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    _fetchData();
    super.initState();

  }
  Widget errorDialog({required double size}){
    return SizedBox(
      height: 180,
      width: 200,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          FlatButton(
              onPressed:  ()  {
                setState(() {
                  _loading = true;
                  _error = false;
                  _fetchData();
                });
              },
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),)),
        ],
      ),
    );
  }

  Widget buildPostsView() {
    if (_users.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (_error) {
        return Center(
            child: errorDialog(size: 20)
        );
      }
    }
    return ListView.builder(
        itemCount: _users.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {

          if (index == _users.length - _nextPageTrigger) {
            _fetchData();
          }
          if (index == _users.length) {
            if (_error) {
              return Center(
                  child: errorDialog(size: 15)
              );
            } else {
              return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
            }
          }
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return buildPostsView();
  }
}

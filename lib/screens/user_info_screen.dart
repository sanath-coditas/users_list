import 'package:flutter/material.dart';
import 'package:user_list/widgets/paginated_list_view.dart';

class UserInfoScreen extends StatelessWidget {


   UserInfoScreen({Key? key}) : super(key: key){
     _screen=[PaginatedListView(gender: "Female"), PaginatedListView(gender: "Male")];
   }


   List<Widget> _screen =[];


  @override
  Widget build(BuildContext context) {
    print("inside build");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 10,
          title: const Text(
            'User Info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color.fromRGBO(174, 0, 87, 3),
                    Color.fromRGBO(122, 0, 108, 3),
                    Color.fromRGBO(74, 0, 128, 3)
                  ]),
            ),
          ),
          bottom: TabBar(
            onTap: (int index) {
              print('Index is $index');

            },
            indicatorColor: const Color.fromRGBO(219, 30, 103, 3),
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Tab(icon: Icon(Icons.female)), Text('Female')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Tab(
                    icon: Icon(Icons.male),
                  ),
                  Text('Male')
                ],
              ),
            ],
          ),
        ),
        body:TabBarView(children: _screen),
      ),
    );
  }
}

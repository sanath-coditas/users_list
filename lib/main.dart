import 'package:flutter/material.dart';
import 'package:user_list/Screens/user_info_screen.dart';
void  main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserInfoScreen(),
      );

  }
}

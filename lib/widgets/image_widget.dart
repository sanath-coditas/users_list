import 'package:flutter/material.dart';
import 'package:user_list/models/user_model.dart';

class ImageWidget extends StatelessWidget {

  const ImageWidget({
    Key? key,
    required List<UserModel> users,
     required this.index,

  }) : _users = users, super(key: key);

  final List<UserModel> _users;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(_users[index].picture!.getLarge!,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

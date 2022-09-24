import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/widgets/post_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Posts')),
        body: BlocBuilder<PostBloc, PostState>(builder: ((context, state) {
          if (state.status == PostStatus.initial) {
            BlocProvider.of<PostBloc>(context).add(PostFetched());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return PostList(state: state);
          }
        })));
  }
}

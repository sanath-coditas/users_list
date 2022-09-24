import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/bloc/post_bloc.dart';

class PostList extends StatefulWidget {
  PostState state;
  PostList({super.key, required this.state});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      BlocProvider.of<PostBloc>(context).add(LoadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.99);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: ((context, index) {
        print('Posts Length is :${widget.state.posts.length}');
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(widget.state.posts[index].id.toString()),
                  )),
              Expanded(
                flex: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.state.posts[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.state.posts[index].body,
                      ),
                      SizedBox(
                        height: 14.0,
                      ),
                    ]),
              ),
            ],
          ),
        );
      }),
      itemCount: widget.state.posts.length,
    );
  }
}

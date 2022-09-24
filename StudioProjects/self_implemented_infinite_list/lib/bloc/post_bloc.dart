import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/repository/post_repository.dart';
import '../models/post.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  int start = 0, end = 10;
  PostBloc() : super(PostState()) {
    on<PostFetched>((PostFetched event, Emitter<PostState> emit) async {
      try {
        if (state.status == PostStatus.initial) {
          print('Inside PostFetched event.....');
          final posts = await PostRepository().fetchPosts(start, end);
          completePosts.addAll(posts);
          return emit(state.copyWith(
            status: PostStatus.success,
            posts: completePosts,
          ));
        }
      } catch (e) {
        emit(state.copyWith(status: PostStatus.failure, posts: []));
      }
    });

    on<LoadMore>((event, emit) async {
      print('Inside LoadMore event.....');
      start += 10;
      end += 10;
      final posts = await PostRepository().fetchPosts(start,end);
      completePosts.addAll(posts);
      return emit(state.copyWith(
        status: PostStatus.success,
        posts: completePosts,
      ));
    });
  }

  List<Post> completePosts = [];
  get posts {
    return completePosts;
  }
}

import 'package:application/app/data/providers/api/api.dart';

class HomeRepository {
  final EprhomProvider api;

  HomeRepository(this.api);

  getAllPosts() => this.api.getPosts();
}
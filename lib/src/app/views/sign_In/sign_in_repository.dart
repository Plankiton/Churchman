import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/app/models/post_model.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';

class SignInRepository {
  final CustomDio dio;

  SignInRepository(this.dio);

  Future<List<PostModel>> getPosts() async {
    try{
      var response = await dio.client.get('/posts');
      return (response.data as List).map((item) => PostModel.fromJson(item)).toList();
    } on DioError catch (e) {
      throw(e.message);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/app/models/post_model.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';

class SignInRepository {
  final ChurchAPI dio;

  SignInRepository(this.dio);
}

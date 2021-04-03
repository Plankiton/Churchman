import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:projeto_igreja/src/app/models/post_model.dart';
import 'package:projeto_igreja/src/app/views/sign_In/sign_in_repository.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends BlocBase {
  final SignInRepository repo;

  SignInBloc(this.repo);
  @override
  void dispose() {
    super.dispose();
  }
}

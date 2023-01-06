import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/login_base_rebository.dart';

class LoginUseCase
    implements UseCase<LoginEntity, LoginParams> {
  final LogInBaseRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(
      LoginParams params) async {
    return await repository.login(
        userName: params.userName,
        password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String userName;
  final String password;

  const LoginParams({
    required this.userName,
    required this.password,
  });

  @override
  List<Object> get props => [
    userName,
    password,
  ];
}

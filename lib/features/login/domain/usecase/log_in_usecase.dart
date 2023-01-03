import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';
import 'package:gymawy/features/login/domain/repository/login_base_rebository.dart';

class LogInUseCase extends UseCase<LogIn,LogInParameters>{

  LogInBaseRepository logInBaseRepository;


  LogInUseCase(this.logInBaseRepository);

  @override
  Future<Either<Failure, LogIn>> call(LogInParameters params) async{
    return  await logInBaseRepository.logIn(params);
  }
}

class LogInParameters extends Equatable{

  String email;
  String password;

  LogInParameters(this.email, this.password);

  @override
  List<Object?> get props => [email,password];
}
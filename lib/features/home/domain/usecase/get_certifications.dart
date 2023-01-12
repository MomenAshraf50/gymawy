import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/certificate_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class GetCertificateUseCase extends UseCase<List<CertificateEntity>,GetCertificateParams>{

  HomeBaseRepository homeBaseRepository;


  GetCertificateUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<CertificateEntity>>> call(GetCertificateParams params) async{
    return await homeBaseRepository.getCertificate(params);
  }
}

class GetCertificateParams extends Equatable{

  int ownerId;
  String ownerName;

  GetCertificateParams({required this.ownerId,required this.ownerName});

  @override
  List<Object?> get props => [
    ownerId,
    ownerName,
  ];
}
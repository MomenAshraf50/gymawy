import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/home_base_repository.dart';

class DeleteCertificateUseCase implements UseCase<void, DeleteCertificateParams> {
  final HomeBaseRepository repository;

  DeleteCertificateUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      DeleteCertificateParams params) async {
    return await repository.deleteCertificate(
      certificateId: params.certificateId,
    );
  }
}

class DeleteCertificateParams extends Equatable {
  final String certificateId;


  const DeleteCertificateParams({
    required this.certificateId,
  });

  @override
  List<Object> get props => [
    certificateId,
  ];
}

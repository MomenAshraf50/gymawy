import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/certificate_entity.dart';
import '../repository/home_base_repository.dart';

class CertificateUseCase implements UseCase<CertificateEntity, CertificateParams> {
  final HomeBaseRepository repository;

  CertificateUseCase(this.repository);

  @override
  Future<Either<Failure, CertificateEntity>> call(
      CertificateParams params) async {
    return await repository.certificate(
      id: params.id,
      certificateName:params.certificateName,
      certificateFile:params.certificateFile,
      certificateDate:params.certificateDate
    );
  }
}

class CertificateParams extends Equatable {
  final String id;
  final String certificateName;
  final FilePickerResult certificateFile;
  final String certificateDate;


  const CertificateParams({
    required this.id,
    required this.certificateName,
    required this.certificateFile,
    required this.certificateDate,
  });

  @override
  List<Object> get props => [
    id,
    certificateName,
    certificateFile,
    certificateName,
  ];
}

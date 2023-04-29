import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/certificate_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class UpdateCertificateUseCase
    extends UseCase<CertificateEntity, UpdateCertificateParams> {
  HomeBaseRepository homeBaseRepository;

  UpdateCertificateUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, CertificateEntity>> call(
      UpdateCertificateParams params) {
    return homeBaseRepository.updateCertificate(params);
  }
}

class UpdateCertificateParams extends Equatable {
  bool isFile;
  FilePickerResult? certificate;
  int certificateId;
  String certificateName;
  String certificateSerial;
  String certificateDate;
  String certificateExpirationDate;
  String certificateDescription;

  UpdateCertificateParams(
      {required this.certificateId,
      required this.certificateName,
      required this.certificateSerial,
      required this.certificateDate,
      required this.certificateDescription,
      required this.certificateExpirationDate,
      required this.isFile,
      this.certificate});

  @override
  List<Object?> get props => [certificateId, certificateName,certificateExpirationDate,certificateDescription, certificateSerial,certificateDate];
}

import 'package:equatable/equatable.dart';

class CertificateEntity extends Equatable {
  String ownerName;
  int certificateId;
  int ownerId;
  String certificateName;
  String certificateFile;
  String certificateDate;

  CertificateEntity({
    required this.ownerName,
    required this.certificateId,
    required this.ownerId,
    required this.certificateName,
    required this.certificateFile,
    required this.certificateDate,
  });

  @override
  List<Object?> get props => [
        ownerName,
        certificateId,
        ownerId,
        certificateName,
        certificateFile,
        certificateDate,
      ];
}

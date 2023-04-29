import 'package:equatable/equatable.dart';

class CertificateEntity extends Equatable {
  String ownerName;
  int certificateId;
  String certificateName;
  String certificateFile;
  String certificateDate;
  String certificateSerial;
  String certificateExpirationDate;
  String certificateDescription;

  CertificateEntity({
    required this.ownerName,
    required this.certificateId,
    required this.certificateName,
    required this.certificateFile,
    required this.certificateDate,
    required this.certificateSerial,
    required this.certificateExpirationDate,
    required this.certificateDescription,
  });

  @override
  List<Object?> get props => [
        ownerName,
        certificateId,
        certificateName,
        certificateFile,
        certificateDate,
    certificateSerial,
    certificateExpirationDate,
    certificateDescription,
      ];
}

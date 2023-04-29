import 'package:gymawy/features/home/domain/entities/certificate_entity.dart';

class CertificateModel extends CertificateEntity {
  CertificateModel({
    required super.ownerName,
    required super.certificateId,
    required super.certificateName,
    required super.certificateFile,
    required super.certificateDate,
    required super.certificateDescription,
    required super.certificateExpirationDate,
    required super.certificateSerial,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      ownerName: json['owner'] ?? 'UnKnown',
      certificateId: json['certificate_id'],
      certificateName: json['certificate_name'] ?? 'UnKnown',
      certificateFile: json['certificate_file'] ?? 'UnKnown',
      certificateDate: json['date'] ?? 'UnKnown',
      certificateDescription: json['description'],
      certificateExpirationDate: json['expiration_date'],
      certificateSerial: json['certificate_serial'] ,
    );
  }
}

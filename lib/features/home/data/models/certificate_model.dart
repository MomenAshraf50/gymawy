import 'package:gymawy/features/home/domain/entities/certificate_entity.dart';

class CertificateModel extends CertificateEntity {
  CertificateModel({
    required super.ownerName,
    required super.certificateId,
    required super.ownerId,
    required super.certificateName,
    required super.certificateFile,
    required super.certificateDate,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      ownerName: json['owner_name'] ?? 'UnKnown',
      certificateId: json['certificate_id'] ?? 0,
      ownerId: json['owner'] ?? 0,
      certificateName: json['certificate_name'] ?? 'UnKnown',
      certificateFile: json['certificate_file'] ?? 'UnKnown',
      certificateDate: json['date'] ?? 'UnKnown',
    );
  }
}

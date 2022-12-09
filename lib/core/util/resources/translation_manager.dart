class TranslationModel {
  late String success;
  late String error;
  late String info;
  late String warning;
  late String deleteMessage;
  late String cancel;
  late String yesOnly;
  late String gymawy;


  TranslationModel.fromJson(Map<String, dynamic> json) {
    yesOnly = json['yesOnly'];
    cancel = json['cancel'];
    success = json['success'];
    error = json['error'];
    info = json['info'];
    warning = json['warning'];
    deleteMessage = json['deleteMessage'];
    gymawy= json['gymawy'];
  }
}

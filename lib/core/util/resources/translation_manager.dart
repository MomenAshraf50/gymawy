class TranslationModel {
  late String success;
  late String error;
  late String info;
  late String warning;
  late String deleteMessage;
  late String cancel;
  late String yesOnly;
  late String selectCurrencyType = 'Select Your Currency Type';
  late String selectConverterCurrencyType = 'Select Converter Currency Type';
  late String enterYourCurrency = 'Enter your Currency';
  late String internetConnection = 'No Internet Connection';
  late String enterConverterCurrency = 'Enter Converter Currency';
  late String currencyConvert = 'Currency Convert';
  late String currencyHistory = 'Currency History';
  late String pleaseFillEmptyFields = 'Please fill in the empty fields';
  late String convert = 'Convert';
  late String pleaseEnterCurrency = 'Please enter Your Currency';
  late String pleaseSelectTwoCountries = 'Please select two countries';


  TranslationModel.fromJson(Map<String, dynamic> json) {
    yesOnly = json['yesOnly'];
    cancel = json['cancel'];
    success = json['success'];
    error = json['error'];
    info = json['info'];
    warning = json['warning'];
    deleteMessage = json['deleteMessage'];
  }
}

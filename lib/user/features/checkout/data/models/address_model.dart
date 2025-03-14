class AddressModel {
  final String city;
  final String country;
  final String line1;
  final String postalCode;
  final String state;

  AddressModel({
    required this.city,
    required this.country,
    required this.line1,
    required this.postalCode,
    required this.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        city: json['city'],
        country: json['country'],
        line1: json['line1'],
        postalCode: json['postal_code'],
        state: json['state']);
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'line1': line1,
      'postal_code': postalCode,
      'state': state,
    };
  }
}

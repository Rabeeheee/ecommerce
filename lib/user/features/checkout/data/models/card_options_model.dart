class CardOptionsModel {
  final String? network;
  final String requestThreeDSecure;

  CardOptionsModel({
    this.network,
    required this.requestThreeDSecure,
  });

  factory CardOptionsModel.fromJson(Map<String, dynamic> json) {
    return CardOptionsModel(
      network: json['network'],
      requestThreeDSecure: json['request_three_d_secure'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'network': network,
      'request_three_d_secure': requestThreeDSecure,
    };
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

class StripePayoutService {
  final String secretKey;

  StripePayoutService(this.secretKey);

  Future<void> createPayout({required int amount, required String currency, required String destination}) async {
    final url = Uri.parse('https://api.stripe.com/v1/transfers');
    
    final body = {
      'amount': amount.toString(),
      'currency': currency.toLowerCase(),
      'destination': destination, 
      'transfer_group': 'ORDER_95',
    };

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $secretKey",
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );

    if (response.statusCode == 200) {
      jsonDecode(response.body);
    } else {
      throw Exception('Failed to create payout: ${response.reasonPhrase}');
    }
  }
}

// Example usage
// void main() async {
//   final payoutService = StripePayoutService('your_secret_key_here');
//   try {
//     await payoutService.createPayout(amount: 1000, currency: 'usd', destination: 'acct_1Gqj58Hpdw6KrtgH');
//   } catch (e) {
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';

class PaymentStatusPage extends StatelessWidget {
  final String status;
  final String? error;

  const PaymentStatusPage({super.key, required this.status, this.error});

  @override
  Widget build(BuildContext context) {
    bool isSuccess = status.toLowerCase() == 'success';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSuccess ? Icons.check_circle : Icons.error,
                    size: 100,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isSuccess ? 'Payment Successful' : 'Payment Failed',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isSuccess ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isSuccess
                        ? 'Thank you! Your payment was processed successfully.'
                        : error ??
                            'Sorry! There was an issue with your payment. Please try again.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                     GoRouter.of(context).goNamed(AppRouteConstants.mainPage);
                    },
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

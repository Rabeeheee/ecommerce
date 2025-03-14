import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';

class SubmitPage extends StatelessWidget {
  const SubmitPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // showsheet();
    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CheckoutLoading) {
          return const Loader();
        }
        return const Loader();
      },
    );
  }
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/providers.dart';

import 'package:babysitterapp/models/models.dart';

import 'package:babysitterapp/views/booking.dart';

class CheckoutScreen extends HookConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PaymentMethodOption> paymentMethods = <PaymentMethodOption>[
      PaymentMethodOption(
        title: 'Cash on Service',
        description: 'Pay when service is delivered',
        icon: Icons.payments_outlined,
        method: PaymentMethod.cashOnService,
      ),
      PaymentMethodOption(
        title: 'Google Pay',
        description: 'Fast and secure payment',
        icon: Icons.g_mobiledata,
        method: PaymentMethod.gPay,
      ),
    ];

    final PaymentMethod selectedMethod =
        ref.watch(selectedPaymentMethodProvider);
    final double totalAmount = ref.watch(totalAmountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...paymentMethods
                      .map((PaymentMethodOption method) => PaymentMethodCard(
                            method: method,
                            isSelected: selectedMethod == method.method,
                            onTap: () => ref
                                .read(selectedPaymentMethodProvider.notifier)
                                .state = method.method,
                          )),
                  const SizedBox(height: 24),
                  PaymentSummary(totalAmount: totalAmount),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutBottomBar(
        totalAmount: totalAmount,
        onCheckout: () => _handleCheckout(context, selectedMethod),
      ),
    );
  }

  void _handleCheckout(BuildContext context, PaymentMethod method) {
    if (method == PaymentMethod.gPay) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => const GPayBottomSheet(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payed successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

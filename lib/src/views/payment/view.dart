import 'package:babysitterapp/src/controllers/booking_controller.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/services/toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class CheckoutScreen extends HookConsumerWidget {
  const CheckoutScreen({
    super.key,
    this.booking,
  });

  final Booking? booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final BookingController bookingController =
        ref.watch(bookingControllerService.notifier);
    final Toast toast = ref.watch(toastService);

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
        ref.watch(selectedPaymentMethodService);

    final double totalAmount = useMemoized(() {
      debugPrint('Calculating total amount...');
      debugPrint('Booking: $booking');
      debugPrint('Booking totalCost: ${booking?.totalCost}');

      if (booking == null) {
        debugPrint('Booking is null');
        return 0.0;
      }

      try {
        final double amount = double.parse(booking!.totalCost);
        debugPrint('Parsed amount: $amount');
        return amount;
      } catch (e) {
        debugPrint('Error parsing totalCost: $e');
        return 0.0;
      }
    }, <Object?>[booking]);

    Future<void> handlePayment(PaymentMethod method) async {
      try {
        isLoading.value = true;

        final String paymentMethod =
            method == PaymentMethod.cashOnService ? 'cash' : 'gpay';

        if (booking != null) {
          await bookingController.updateBookingStatus(
            bookingId: booking!.id!,
            paymentStatus: 'completed',
            paymentMethod: paymentMethod,
          );
        }

        if (context.mounted) {
          toast.show(
            context: context,
            title: 'Success',
            message: 'Payment completed successfully',
            type: 'success',
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          toast.show(
            context: context,
            title: 'Error',
            message: 'Payment failed: $e',
            type: 'error',
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: VerificationGuard(
        user: ref.watch(authControllerService).user,
        child: SafeArea(
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
                                  .read(selectedPaymentMethodService.notifier)
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
      ),
      bottomNavigationBar: CheckoutBottomBar(
        totalAmount: totalAmount,
        isLoading: isLoading.value,
        onCheckout: () => handlePayment(selectedMethod),
      ),
    );
  }
}

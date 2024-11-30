import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:babysitterapp/src/models.dart';

final StateProvider<PaymentMethod> selectedPaymentMethodService =
    StateProvider<PaymentMethod>(
        (StateProviderRef<PaymentMethod> ref) => PaymentMethod.cashOnService);
final StateProvider<double> totalAmountService =
    StateProvider<double>((StateProviderRef<double> ref) => 99.99);

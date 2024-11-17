import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:babysitterapp/models/models.dart';

final StateProvider<PaymentMethod> selectedPaymentMethodProvider =
    StateProvider<PaymentMethod>(
        (StateProviderRef<PaymentMethod> ref) => PaymentMethod.cashOnService);
final StateProvider<double> totalAmountProvider =
    StateProvider<double>((StateProviderRef<double> ref) => 99.99);

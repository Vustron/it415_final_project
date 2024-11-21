import 'package:flutter/material.dart';

import 'package:babysitterapp/src/views.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String homeClient = '/home-client';
  static const String homeBabysitter = '/home-babysitter';
  static const String messages = '/messages';
  static const String notifications = '/notifications';
  static const String booking = '/booking';
  static const String payment = '/payment';
  static const String bookingDetails = '/booking-details';
  static const String receipt = '/receipt';
  static const String search = '/search';
  static const String filter = '/filter';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String account = '/account';
  static const String editAccount = '/edit-account';
  static const String availability = '/availability';
  static const String helpSupport = '/help-support';
  static const String transactionHistory = '/transaction-history';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      splash: (BuildContext context) => const SplashView(),
      login: (BuildContext context) => const LoginView(),
      register: (BuildContext context) => RegisterView(),
      homeClient: (BuildContext context) => HomeClientView(),
      homeBabysitter: (BuildContext context) => const HomeBabysitterView(
            location: '',
            username: '',
            userImg: '',
          ),
      messages: (BuildContext context) => MessageView(),
      notifications: (BuildContext context) => NotificationView(),
      booking: (BuildContext context) => BookingView(),
      payment: (BuildContext context) => const CheckoutScreen(),
      bookingDetails: (BuildContext context) => BookingDetailsView(),
      receipt: (BuildContext context) => PaymentConfirmationView(),
      search: (BuildContext context) => const SearchView(),
      filter: (BuildContext context) => FilterView(),
      settings: (BuildContext context) => SettingsView(),
      profile: (BuildContext context) => AccountView(),
      account: (BuildContext context) => AccountView(),
      editAccount: (BuildContext context) => EditProfileView(user: null),
      availability: (BuildContext context) => AvailabilityView(),
      helpSupport: (BuildContext context) => const HelpSupportView(),
      transactionHistory: (BuildContext context) =>
          const TransactionHistoryView(),
    };
  }
}

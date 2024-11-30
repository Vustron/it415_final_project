import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
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
  static const String verification = '/verification';
  static const String allBabysittersView = '/all-babysitters';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      splash: (BuildContext context) => const SplashView(),
      login: (BuildContext context) => LoginView(),
      register: (BuildContext context) => RegisterView(),
      // Protected routes
      dashboard: (BuildContext context) => const AuthGuard(
            child: BottomNavbarView(),
          ),
      homeBabysitter: (BuildContext context) => const AuthGuard(
            child: HomeBabysitterView(),
          ),
      messages: (BuildContext context) => AuthGuard(
            child: MessageView(),
          ),
      notifications: (BuildContext context) => const AuthGuard(
            child: NotificationView(),
          ),
      booking: (BuildContext context) => const AuthGuard(
            child: BookingView(),
          ),
      payment: (BuildContext context) => const AuthGuard(
            child: CheckoutScreen(),
          ),
      bookingDetails: (BuildContext context) => const AuthGuard(
            child: BookingDetailsView(),
          ),
      receipt: (BuildContext context) => AuthGuard(
            child: PaymentConfirmationView(),
          ),
      search: (BuildContext context) => const AuthGuard(
            child: SearchView(),
          ),
      filter: (BuildContext context) => AuthGuard(
            child: FilterView(),
          ),
      settings: (BuildContext context) => AuthGuard(
            child: SettingsView(),
          ),
      profile: (BuildContext context) => AuthGuard(
            child: AccountView(),
          ),
      account: (BuildContext context) => AuthGuard(
            child: AccountView(),
          ),
      editAccount: (BuildContext context) => AuthGuard(
            child: EditAccountView(user: null),
          ),
      availability: (BuildContext context) => AuthGuard(
            child: AvailabilityView(),
          ),
      helpSupport: (BuildContext context) => const AuthGuard(
            child: HelpSupportView(),
          ),
      transactionHistory: (BuildContext context) => const AuthGuard(
            child: TransactionHistoryView(),
          ),
      verification: (BuildContext context) => const AuthGuard(
            child: VerificationView(),
          ),
      allBabysittersView: (BuildContext context) => const AuthGuard(
            child: AllBabysittersView(),
          ),
    };
  }
}

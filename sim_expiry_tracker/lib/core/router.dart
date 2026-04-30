import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_expiry_tracker/features/dashboard/presentation/dashboard_screen.dart';
import 'package:sim_expiry_tracker/features/auth/presentation/login_screen.dart';
import 'package:sim_expiry_tracker/features/accounts/presentation/account_form_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/add-account',
        builder: (context, state) => const AccountFormScreen(),
      ),
      GoRoute(
        path: '/edit-account/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AccountFormScreen(accountId: id);
        },
      ),
    ],
  );
});

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sim_expiry_tracker/core/theme.dart';
import 'package:sim_expiry_tracker/core/router.dart';
import 'package:sim_expiry_tracker/core/isar_service.dart';
import 'package:sim_expiry_tracker/features/accounts/presentation/account_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    if (kIsWeb) {
      debugPrint('Firebase not fully configured for web, skipping initialization or passing placeholder options if necessary.');
      // For now, if we don't have firebase_options.dart, we'll just skip on web 
      // or we can initialize without options if it works (it doesn't, so skip it).
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  // Initialize Isar
  final isarService = IsarService();
  await isarService.init();

  runApp(
    ProviderScope(
      overrides: [
        isarServiceProvider.overrideWithValue(isarService),
      ],
      child: const SimExpiryApp(),
    ),
  );
}

class SimExpiryApp extends ConsumerWidget {
  const SimExpiryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'SIM Expiry Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}

// Simple ThemeMode provider for now
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

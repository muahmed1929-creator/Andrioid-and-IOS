import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_expiry_tracker/features/accounts/domain/account_model.dart';
import 'package:sim_expiry_tracker/core/isar_service.dart';

final isarServiceProvider = Provider((ref) => IsarService());

final accountsProvider = StreamProvider<List<Account>>((ref) {
  final service = ref.watch(isarServiceProvider);
  return service.watchAccounts();
});

final filteredAccountsProvider = Provider<List<Account>>((ref) {
  final accountsAsync = ref.watch(accountsProvider);
  final filter = ref.watch(accountFilterProvider);
  
  return accountsAsync.when(
    data: (accounts) {
      if (filter == 'All') return accounts;
      return accounts.where((a) => a.status == filter || a.packageType == filter).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final accountFilterProvider = StateProvider<String>((ref) => 'All');

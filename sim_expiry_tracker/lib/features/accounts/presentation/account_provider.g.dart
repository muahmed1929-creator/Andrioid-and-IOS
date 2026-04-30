// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isarServiceHash() => r'400ccd51c2529e536beaa646615d9d9ed2f07323';

/// See also [isarService].
@ProviderFor(isarService)
final isarServiceProvider = Provider<IsarService>.internal(
  isarService,
  name: r'isarServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isarServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsarServiceRef = ProviderRef<IsarService>;
String _$accountsHash() => r'ae17b4f6c424cc91e1a4f3cda0b627e137132b8d';

/// See also [Accounts].
@ProviderFor(Accounts)
final accountsProvider =
    AutoDisposeStreamNotifierProvider<Accounts, List<Account>>.internal(
  Accounts.new,
  name: r'accountsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Accounts = AutoDisposeStreamNotifier<List<Account>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

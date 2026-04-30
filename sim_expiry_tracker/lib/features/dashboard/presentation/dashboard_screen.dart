import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sim_expiry_tracker/features/accounts/domain/account_model.dart';
import 'package:sim_expiry_tracker/features/accounts/presentation/account_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          accountsAsync.when(
            data: (accounts) => _buildSummaryCards(context, accounts),
            loading: () => const SliverToBoxAdapter(child: LinearProgressIndicator()),
            error: (err, _) => SliverToBoxAdapter(child: Text('Error: $err')),
          ),
          _buildFilterChips(context),
          accountsAsync.when(
            data: (accounts) => _buildAccountList(context, accounts),
            loading: () => const SliverToBoxAdapter(child: SizedBox()),
            error: (err, _) => const SliverToBoxAdapter(child: SizedBox()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-account'),
        icon: const Icon(Icons.add),
        label: const Text('New Account'),
      ).animate().scale(delay: 400.ms),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar.large(
      title: const Text('SIM Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context, List<Account> accounts) {
    final total = accounts.length;
    final expired = accounts.where((a) => a.daysLeft <= 0).length;
    final expiring = accounts.where((a) => a.daysLeft > 0 && a.daysLeft <= 3).length;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _SummaryCard(
                title: 'Total',
                value: '$total',
                icon: FontAwesomeIcons.simCard,
                color: Colors.blue,
              ),
              _SummaryCard(
                title: 'Expiring',
                value: '$expiring',
                icon: Icons.warning_amber_rounded,
                color: Colors.orange,
              ),
              _SummaryCard(
                title: 'Expired',
                value: '$expired',
                icon: Icons.error_outline_rounded,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Wrap(
          spacing: 8.0,
          children: [
            FilterChip(label: const Text('All'), selected: true, onSelected: (_) {}),
            FilterChip(label: const Text('Active'), selected: false, onSelected: (_) {}),
            FilterChip(label: const Text('Expiring'), selected: false, onSelected: (_) {}),
            FilterChip(label: const Text('Expired'), selected: false, onSelected: (_) {}),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountList(BuildContext context, List<Account> accounts) {
    if (accounts.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: Text('No accounts found. Add your first SIM!')),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final account = accounts[index];
            return _AccountListItem(account: account).animate().fadeIn(delay: (index * 100).ms).slideX();
          },
          childCount: accounts.length,
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final dynamic icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon is IconData 
            ? Icon(icon as IconData, color: color, size: 24)
            : FaIcon(icon as FaIconData, color: color, size: 24),
          const SizedBox(height: 12),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: color)),
          Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color.withAlpha(200))),
        ],
      ),
    );
  }
}

class _AccountListItem extends StatelessWidget {
  final Account account;
  const _AccountListItem({required this.account});

  @override
  Widget build(BuildContext context) {
    final statusColor = account.statusColor == 'Red' ? Colors.red : (account.statusColor == 'Yellow' ? Colors.orange : Colors.green);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: statusColor.withAlpha(25),
          child: FaIcon(FontAwesomeIcons.simCard, size: 18, color: statusColor),
        ),
        title: Text(account.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Device: ${account.deviceName} • ${account.simNumber}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${account.daysLeft} Days Left',
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Exp: ${account.expiryDate.day}/${account.expiryDate.month}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}

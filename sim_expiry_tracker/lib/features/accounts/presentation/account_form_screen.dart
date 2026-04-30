import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sim_expiry_tracker/features/accounts/domain/account_model.dart';
import 'package:sim_expiry_tracker/features/accounts/presentation/account_provider.dart';

class AccountFormScreen extends ConsumerStatefulWidget {
  final String? accountId;
  const AccountFormScreen({super.key, this.accountId});

  @override
  ConsumerState<AccountFormScreen> createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends ConsumerState<AccountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _simController = TextEditingController();
  final _deviceController = TextEditingController();
  final _durationController = TextEditingController();
  
  String _packageType = 'Monthly';
  DateTime _activationDate = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _simController.dispose();
    _deviceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final duration = _packageType == 'Weekly' ? 7 : (_packageType == 'Monthly' ? 30 : (int.tryParse(_durationController.text) ?? 30));
      final expiry = _activationDate.add(Duration(days: duration));

      final account = Account()
        ..name = _nameController.text
        ..simNumber = _simController.text
        ..deviceName = _deviceController.text
        ..packageType = _packageType
        ..activationDate = _activationDate
        ..expiryDate = expiry
        ..customDurationDays = _packageType == 'Custom' ? int.tryParse(_durationController.text) : null;

      await ref.read(accountsProvider.notifier).addAccount(account);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.accountId == null ? 'Add Account' : 'Edit Account'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Account Name', prefixIcon: Icon(Icons.person_outline)),
              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _simController,
              decoration: const InputDecoration(labelText: 'SIM Number', prefixIcon: Icon(Icons.phone_android_outlined)),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deviceController,
              decoration: const InputDecoration(labelText: 'Device Name', prefixIcon: Icon(Icons.devices_outlined)),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _packageType,
              decoration: const InputDecoration(labelText: 'Package Type', prefixIcon: Icon(Icons.inventory_2_outlined)),
              items: ['Weekly', 'Monthly', 'Custom'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _packageType = v!),
            ),
            const SizedBox(height: 16),
            if (_packageType == 'Custom')
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duration (Days)', prefixIcon: Icon(Icons.calendar_today_outlined)),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Activation Date'),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(_activationDate)),
              trailing: const Icon(Icons.calendar_month),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _activationDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) setState(() => _activationDate = date);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Save Account'),
            ),
          ],
        ),
      ),
    );
  }
}

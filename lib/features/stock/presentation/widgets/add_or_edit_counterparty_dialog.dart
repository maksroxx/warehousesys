import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warehousesys/core/theme/app_theme.dart';
import 'package:warehousesys/features/stock/data/models/counterparty.dart';
import 'package:warehousesys/features/stock/presentation/providers/stock_providers.dart';
import 'package:warehousesys/l10n/app_localizations.dart';

class AddOrEditCounterpartyDialog extends ConsumerStatefulWidget {
  final Counterparty? counterpartyToEdit;

  const AddOrEditCounterpartyDialog({super.key, this.counterpartyToEdit});

  @override
  ConsumerState<AddOrEditCounterpartyDialog> createState() => _AddOrEditCounterpartyDialogState();
}

class _AddOrEditCounterpartyDialogState extends ConsumerState<AddOrEditCounterpartyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _telegramController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.counterpartyToEdit != null) {
      final cp = widget.counterpartyToEdit!;
      _nameController.text = cp.name;
      _phoneController.text = cp.phone ?? '';
      _emailController.text = cp.email ?? '';
      _telegramController.text = cp.telegram ?? '';
      _addressController.text = cp.address ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _telegramController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final l10n = AppLocalizations.of(context)!;
    
    if (_formKey.currentState?.validate() != true) return;
    
    setState(() => _isLoading = true);

    final isEditMode = widget.counterpartyToEdit != null;
    
    final counterparty = Counterparty(
      id: widget.counterpartyToEdit?.id ?? 0,
      name: _nameController.text,
      phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
      email: _emailController.text.isNotEmpty ? _emailController.text : null,
      telegram: _telegramController.text.isNotEmpty ? _telegramController.text : null,
      address: _addressController.text.isNotEmpty ? _addressController.text : null,
    );

    try {
      if (isEditMode) {
        await ref.read(stockRepositoryProvider).updateCounterparty(counterparty);
      } else {
        await ref.read(stockRepositoryProvider).createCounterparty(counterparty);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditMode 
              ? l10n.counterpartyUpdatedSuccess 
              : l10n.counterpartyCreatedSuccess),
          backgroundColor: Colors.green,
        ),
      );

      // Invalidate providers to refetch data
      ref.invalidate(counterpartiesProvider); 
      if(isEditMode) {
        ref.invalidate(counterpartyDetailsProvider(counterparty.id));
      }

      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // Используем общий ключ ошибки, который мы создали ранее
          content: Text(l10n.generalError(e.toString())), 
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.counterpartyToEdit != null;
    final l10n = AppLocalizations.of(context)!;

    final baseInputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
    );

    return Dialog(
      backgroundColor: cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 550, // Одноколоночный макет, ширина меньше
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEditMode ? l10n.editCounterpartyTitle : l10n.newCounterpartyTitle,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 24),

                        // --- Поля формы ---
                        _FormEntry(
                          label: l10n.nameLabel,
                          isRequired: true,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: baseInputDecoration.copyWith(hintText: l10n.nameHint),
                            validator: (v) => (v?.isEmpty ?? true) ? l10n.requiredField : null,
                          ),
                        ),
                        _FormEntry(
                          label: l10n.phoneLabel,
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: baseInputDecoration.copyWith(hintText: l10n.phoneHint),
                          ),
                        ),
                        _FormEntry(
                          label: l10n.emailLabel,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: baseInputDecoration.copyWith(hintText: l10n.emailHint),
                          ),
                        ),
                         _FormEntry(
                          label: l10n.telegramLabel,
                          child: TextFormField(
                            controller: _telegramController,
                            decoration: baseInputDecoration.copyWith(hintText: l10n.telegramHint),
                          ),
                        ),
                        _FormEntry(
                          label: l10n.addressLabel,
                          child: TextFormField(
                            controller: _addressController,
                            decoration: baseInputDecoration.copyWith(hintText: l10n.addressHint),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildActionsBar(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionsBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: const BoxDecoration(
        color: tableHeaderColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          const SizedBox(width: 16),
          _isLoading
              ? FilledButton.icon(
                  onPressed: null,
                  icon: const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                  label: Text(l10n.save),
                )
              : FilledButton(
                  onPressed: _submitForm,
                  child: Text(l10n.save),
                ),
        ],
      ),
    );
  }
}

class _FormEntry extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;

  const _FormEntry({
    required this.label,
    required this.child,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
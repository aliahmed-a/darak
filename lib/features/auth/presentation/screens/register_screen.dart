import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() => _isSubmitting = true);
    try {
      final registrationMessage = await ref.read(authControllerProvider.notifier).register(
            fullName: _fullNameController.text.trim(),
            email: email,
            password: password,
          );

      // Registration doesn't return a session — sign the resident straight
      // in so they land in the app instead of retyping their credentials.
      await ref.read(authControllerProvider.notifier).login(email: email, password: password);

      final authState = ref.read(authControllerProvider);
      if (authState.hasError) {
        // Most likely the account needs confirmation/provisioning before
        // login is allowed — surface the server's own explanation.
        if (!mounted) return;
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.registerReceivedTitle),
            content: Text(registrationMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.commonOk),
              ),
            ],
          ),
        );
      }
      // Otherwise the router's redirect picks up the new signed-in state
      // and navigates to the home shell automatically.
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.registerTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration:
                      InputDecoration(labelText: l10n.registerFullName, prefixIcon: const Icon(Icons.person_outline)),
                  validator: (value) => (value == null || value.trim().isEmpty) ? l10n.registerEnterFullName : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      InputDecoration(labelText: l10n.loginEmail, prefixIcon: const Icon(Icons.email_outlined)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return l10n.loginEnterEmail;
                    if (!value.contains('@')) return l10n.registerEnterValidEmail;
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: l10n.loginPassword, prefixIcon: const Icon(Icons.lock_outline)),
                  validator: (value) {
                    if (value == null || value.length < 8) return l10n.registerAtLeast8Chars;
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: l10n.registerConfirmPassword, prefixIcon: const Icon(Icons.lock_outline)),
                  validator: (value) =>
                      value != _passwordController.text ? l10n.registerPasswordsDoNotMatch : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l10n.registerSubmit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

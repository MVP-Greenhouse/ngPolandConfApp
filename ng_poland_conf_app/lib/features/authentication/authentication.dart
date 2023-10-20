import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'Sign in',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: const Text('Auth'),
    );
  }
}

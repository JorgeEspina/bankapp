import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/configuration_provider.dart';

class ConfigurationScreen extends ConsumerWidget {
  static const name = 'configuration-screen';

  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configurationProvider);

    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Configuración',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Modo oscuro', style: textStyle),
            value: config.isDarkMode,
            onChanged: (_) {
              ref.read(configurationProvider.notifier).toggleDarkMode();
            },
          ),
          SwitchListTile(
            title: Text('Notificaciones', style: textStyle),
            value: config.notificationsEnabled,
            onChanged: (_) {
              ref.read(configurationProvider.notifier)
                  .toggleNotifications();
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bankapp/core/l10n/locale_provider.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
import '../state/configuration_providers.dart';

class ConfigurationScreen extends ConsumerWidget {
  static const name = 'configuration-screen';

  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(configurationControllerProvider);
    final currentLocale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context);

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
          l10n.configuration,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(l10n.darkMode, style: textStyle),
            value: state.isDarkMode,
            onChanged: (_) {
              ref.read(configurationControllerProvider.notifier).toggleDarkMode();
            },
          ),
          SwitchListTile(
            title: Text(l10n.notifications, style: textStyle),
            value: state.notificationsEnabled,
            onChanged: (_) {
              ref.read(configurationControllerProvider.notifier)
                  .toggleNotifications();
            },
          ),
          const Divider(color: Colors.white24),
          ListTile(
            title: Text(l10n.language, style: textStyle),
            subtitle: Text(
              currentLocale.languageCode == 'es' ? l10n.spanish : l10n.english,
              style: const TextStyle(color: Colors.white60),
            ),
            trailing: const Icon(Icons.language, color: Colors.white60),
            onTap: () => _showLanguageDialog(context, ref, currentLocale),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(
      BuildContext context, WidgetRef ref, Locale currentLocale) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF232533),
        title: Text(
          l10n.selectLanguage,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LanguageOption(
              title: 'Español',
              locale: const Locale('es'),
              isSelected: currentLocale.languageCode == 'es',
              onTap: () {
                ref
                    .read(localeProvider.notifier)
                    .setLocale(const Locale('es'));
                Navigator.of(dialogContext).pop();
              },
            ),
            _LanguageOption(
              title: 'English',
              locale: const Locale('en'),
              isSelected: currentLocale.languageCode == 'en',
              onTap: () {
                ref
                    .read(localeProvider.notifier)
                    .setLocale(const Locale('en'));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final Locale locale;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.locale,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF0066FF) : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF0066FF))
          : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

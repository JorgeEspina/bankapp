import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'BankApp'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get welcome;

  /// No description provided for @accounts.
  ///
  /// In es, this message translates to:
  /// **'Cuentas'**
  String get accounts;

  /// No description provided for @creditCards.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas de crédito'**
  String get creditCards;

  /// No description provided for @dashboard.
  ///
  /// In es, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @products.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get products;

  /// No description provided for @totalBalance.
  ///
  /// In es, this message translates to:
  /// **'Saldo total'**
  String get totalBalance;

  /// No description provided for @savingsAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuenta de Ahorros'**
  String get savingsAccount;

  /// No description provided for @checkingAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuenta Corriente'**
  String get checkingAccount;

  /// No description provided for @creditCard.
  ///
  /// In es, this message translates to:
  /// **'Tarjeta de Crédito'**
  String get creditCard;

  /// No description provided for @investmentFund.
  ///
  /// In es, this message translates to:
  /// **'Fondo de Inversión'**
  String get investmentFund;

  /// No description provided for @balance.
  ///
  /// In es, this message translates to:
  /// **'Saldo'**
  String get balance;

  /// No description provided for @availableCredit.
  ///
  /// In es, this message translates to:
  /// **'Crédito disponible'**
  String get availableCredit;

  /// No description provided for @availableBalance.
  ///
  /// In es, this message translates to:
  /// **'Saldo disponible'**
  String get availableBalance;

  /// No description provided for @marketValue.
  ///
  /// In es, this message translates to:
  /// **'Valor de mercado'**
  String get marketValue;

  /// No description provided for @lastUpdate.
  ///
  /// In es, this message translates to:
  /// **'Última actualización'**
  String get lastUpdate;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @errorLoadingData.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar los datos'**
  String get errorLoadingData;

  /// No description provided for @noProductsAvailable.
  ///
  /// In es, this message translates to:
  /// **'No hay productos disponibles'**
  String get noProductsAvailable;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loading;

  /// No description provided for @cachedData.
  ///
  /// In es, this message translates to:
  /// **'Datos en caché (sin conexión)'**
  String get cachedData;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @transfers.
  ///
  /// In es, this message translates to:
  /// **'Transferencias'**
  String get transfers;

  /// No description provided for @reports.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get reports;

  /// No description provided for @cards.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas'**
  String get cards;

  /// No description provided for @configuration.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get configuration;

  /// No description provided for @darkMode.
  ///
  /// In es, this message translates to:
  /// **'Modo oscuro'**
  String get darkMode;

  /// No description provided for @notifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @spanish.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get english;

  /// No description provided for @selectLanguage.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar idioma'**
  String get selectLanguage;

  /// No description provided for @signIn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @todayTransactions.
  ///
  /// In es, this message translates to:
  /// **'Transacciones de hoy'**
  String get todayTransactions;

  /// No description provided for @yesterdayTransactions.
  ///
  /// In es, this message translates to:
  /// **'Transacciones de Ayer'**
  String get yesterdayTransactions;

  /// No description provided for @history.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get history;

  /// No description provided for @transfer.
  ///
  /// In es, this message translates to:
  /// **'Transferir'**
  String get transfer;

  /// No description provided for @payments.
  ///
  /// In es, this message translates to:
  /// **'Pagos'**
  String get payments;

  /// No description provided for @details.
  ///
  /// In es, this message translates to:
  /// **'Detalles'**
  String get details;

  /// No description provided for @moreOptions.
  ///
  /// In es, this message translates to:
  /// **'Más opciones'**
  String get moreOptions;

  /// No description provided for @httpConsumption.
  ///
  /// In es, this message translates to:
  /// **'Consumo de Cliente HTTP'**
  String get httpConsumption;

  /// No description provided for @testMockApi.
  ///
  /// In es, this message translates to:
  /// **'Probar API Mock'**
  String get testMockApi;

  /// No description provided for @investments.
  ///
  /// In es, this message translates to:
  /// **'Inversiones'**
  String get investments;

  /// No description provided for @financialProducts.
  ///
  /// In es, this message translates to:
  /// **'productos financieros'**
  String get financialProducts;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @mainScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Book your ride'**
  String get mainScreenTitle;

  /// No description provided for @choosePickup.
  ///
  /// In en, this message translates to:
  /// **'Choose a pickup point'**
  String get choosePickup;

  /// No description provided for @chooseDropoff.
  ///
  /// In en, this message translates to:
  /// **'Choose a drop-off point'**
  String get chooseDropoff;

  /// No description provided for @passengersNumber.
  ///
  /// In en, this message translates to:
  /// **'Passengers number'**
  String get passengersNumber;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @bookButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get bookButtonTitle;

  /// No description provided for @confirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking confirmation'**
  String get confirmationTitle;

  /// No description provided for @confirmationText.
  ///
  /// In en, this message translates to:
  /// **'Would you like to confirm your booking?'**
  String get confirmationText;

  /// No description provided for @confirmationConfirmButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmationConfirmButtonTitle;

  /// No description provided for @confirmationCancelButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get confirmationCancelButtonTitle;

  /// No description provided for @chooseLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a Location'**
  String get chooseLocationTitle;

  /// No description provided for @confirmLocationButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm the Location'**
  String get confirmLocationButtonTitle;

  /// No description provided for @confirmLocationMessage.
  ///
  /// In en, this message translates to:
  /// **'Please tap on the map to select a location'**
  String get confirmLocationMessage;

  /// No description provided for @sucessfulBookingMessage.
  ///
  /// In en, this message translates to:
  /// **'Your ride has been booked!'**
  String get sucessfulBookingMessage;

  /// No description provided for @emptyFieldsMessage.
  ///
  /// In en, this message translates to:
  /// **'Some of the fields are empty!'**
  String get emptyFieldsMessage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

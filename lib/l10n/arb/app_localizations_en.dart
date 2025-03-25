import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get mainScreenTitle => 'Book your ride';

  @override
  String get choosePickup => 'Choose a pickup point';

  @override
  String get chooseDropoff => 'Choose a drop-off point';

  @override
  String get passengersNumber => 'Passengers number';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectTime => 'Select Time';

  @override
  String get bookButtonTitle => 'Book';

  @override
  String get confirmationTitle => 'Booking confirmation';

  @override
  String get confirmationText => 'Would you like to confirm your booking?';

  @override
  String get confirmationConfirmButtonTitle => 'Confirm';

  @override
  String get confirmationCancelButtonTitle => 'Cancel';

  @override
  String get chooseLocationTitle => 'Choose a Location';

  @override
  String get confirmLocationButtonTitle => 'Confirm the Location';

  @override
  String get confirmLocationMessage => 'Please tap on the map to select a location';

  @override
  String get sucessfulBookingMessage => 'Your ride has been booked!';

  @override
  String get emptyFieldsMessage => 'Some of the fields are empty!';
}

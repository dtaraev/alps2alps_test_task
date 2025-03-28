import 'package:flutter/widgets.dart';

import 'arb/app_localizations.dart';

export 'arb/app_localizations.dart';

extension AppLocalizationsExtenstion on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

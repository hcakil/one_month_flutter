import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('en'),
    Locale('tr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'30-Day Flutter + Web + AI Development Project'**
  String get appTitle;

  /// Project purpose section title
  ///
  /// In en, this message translates to:
  /// **'Project Purpose'**
  String get projectPurpose;

  /// Main project description
  ///
  /// In en, this message translates to:
  /// **'This project is a comprehensive study repository created to support your 30-day Flutter learning plan.'**
  String get projectDescription;

  /// Week 1 title
  ///
  /// In en, this message translates to:
  /// **'Week 1 - Flutter & Web Modernization'**
  String get week1Title;

  /// Day 1 title
  ///
  /// In en, this message translates to:
  /// **'Day 1: Flutter 3.27+ Updates and Material 3'**
  String get day1Title;

  /// Day 1 description
  ///
  /// In en, this message translates to:
  /// **'What\'s New in Flutter, Material 3 widgets, Impeller Rendering'**
  String get day1Description;

  /// Day 2 title
  ///
  /// In en, this message translates to:
  /// **'Day 2: State Management (Riverpod 3)'**
  String get day2Title;

  /// Day 2 description
  ///
  /// In en, this message translates to:
  /// **'Modern state management with Riverpod'**
  String get day2Description;

  /// Day 3 title
  ///
  /// In en, this message translates to:
  /// **'Day 3: Responsive & Adaptive Layout'**
  String get day3Title;

  /// Day 3 description
  ///
  /// In en, this message translates to:
  /// **'LayoutBuilder, MediaQuery and adaptive design'**
  String get day3Description;

  /// Day 4 title
  ///
  /// In en, this message translates to:
  /// **'Day 4: Web Performance Optimization'**
  String get day4Title;

  /// Day 4 description
  ///
  /// In en, this message translates to:
  /// **'Deferred Components, CanvasKit vs HTML, optimization'**
  String get day4Description;

  /// Day 5 title
  ///
  /// In en, this message translates to:
  /// **'Day 5: SEO and Web Metadata'**
  String get day5Title;

  /// Day 5 description
  ///
  /// In en, this message translates to:
  /// **'seo_renderer, meta tags, route-based titles'**
  String get day5Description;

  /// Day 6 title
  ///
  /// In en, this message translates to:
  /// **'Day 6: Mini Project (Responsive Web App)'**
  String get day6Title;

  /// Day 6 description
  ///
  /// In en, this message translates to:
  /// **'Responsive web + SEO meta + Lazy load'**
  String get day6Description;

  /// Flutter updates section title
  ///
  /// In en, this message translates to:
  /// **'Flutter 3.27+ Updates'**
  String get flutterUpdatesTitle;

  /// Flutter updates description
  ///
  /// In en, this message translates to:
  /// **'In this section, we will explore Flutter\'s latest features and test the Material 3 design system.'**
  String get flutterUpdatesDescription;

  /// Material 3 components section title
  ///
  /// In en, this message translates to:
  /// **'Material 3 Components'**
  String get material3Components;

  /// Buttons section title
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get buttons;

  /// Segmented button section title
  ///
  /// In en, this message translates to:
  /// **'Segmented Button'**
  String get segmentedButton;

  /// Cards and containers section title
  ///
  /// In en, this message translates to:
  /// **'Cards and Containers'**
  String get cardsContainers;

  /// Filled card label
  ///
  /// In en, this message translates to:
  /// **'Filled Card'**
  String get filledCard;

  /// Outlined card label
  ///
  /// In en, this message translates to:
  /// **'Outlined Card'**
  String get outlinedCard;

  /// Impeller rendering engine title
  ///
  /// In en, this message translates to:
  /// **'Impeller Rendering Engine'**
  String get impellerRenderingEngine;

  /// Impeller description
  ///
  /// In en, this message translates to:
  /// **'Impeller is Flutter\'s new rendering engine. It provides better performance and less jank.'**
  String get impellerDescription;

  /// Impeller active label
  ///
  /// In en, this message translates to:
  /// **'Impeller Active'**
  String get impellerActive;

  /// Rendering engine selection subtitle
  ///
  /// In en, this message translates to:
  /// **'Rendering engine selection (demo purpose)'**
  String get renderingEngineSelection;

  /// Impeller active status message
  ///
  /// In en, this message translates to:
  /// **'✅ Impeller: Active - Better performance!'**
  String get impellerActiveStatus;

  /// Skia old engine message
  ///
  /// In en, this message translates to:
  /// **'⚠️ Skia: Old rendering engine'**
  String get skiaOldEngine;

  /// Other new features section title
  ///
  /// In en, this message translates to:
  /// **'Other New Features'**
  String get otherNewFeatures;

  /// Web performance improvements feature title
  ///
  /// In en, this message translates to:
  /// **'Web Performance Improvements'**
  String get webPerformanceImprovements;

  /// Web performance description
  ///
  /// In en, this message translates to:
  /// **'Faster loading and better SEO support'**
  String get webPerformanceDescription;

  /// Security updates feature title
  ///
  /// In en, this message translates to:
  /// **'Security Updates'**
  String get securityUpdates;

  /// Security description
  ///
  /// In en, this message translates to:
  /// **'More secure APIs and dependency updates'**
  String get securityDescription;

  /// Developer experience feature title
  ///
  /// In en, this message translates to:
  /// **'Developer Experience'**
  String get developerExperience;

  /// Developer experience description
  ///
  /// In en, this message translates to:
  /// **'Better hot reload and debugging tools'**
  String get developerDescription;

  /// Platform integration feature title
  ///
  /// In en, this message translates to:
  /// **'Platform Integration'**
  String get platformIntegration;

  /// Platform integration description
  ///
  /// In en, this message translates to:
  /// **'Better native integration for iOS and Android'**
  String get platformDescription;

  /// Day 1 tasks section title
  ///
  /// In en, this message translates to:
  /// **'Day 1 Tasks'**
  String get day1Tasks;

  /// Task 1 description
  ///
  /// In en, this message translates to:
  /// **'Read What\'s New in Flutter'**
  String get task1;

  /// Task 2 description
  ///
  /// In en, this message translates to:
  /// **'Test Material 3 widgets'**
  String get task2;

  /// Task 3 description
  ///
  /// In en, this message translates to:
  /// **'Read Impeller Rendering'**
  String get task3;

  /// Task 4 description
  ///
  /// In en, this message translates to:
  /// **'Enable Material 3 + Impeller in empty project'**
  String get task4;

  /// Complete day 1 button text
  ///
  /// In en, this message translates to:
  /// **'Complete Day 1'**
  String get completeDay1;

  /// Congratulations message
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You have completed Day 1 tasks! 🎉'**
  String get congratulationsMessage;

  /// Filled button clicked message
  ///
  /// In en, this message translates to:
  /// **'FilledButton clicked!'**
  String get filledButtonClicked;

  /// Day label
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// Week label
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// Month label
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// Change language button text
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Turkish language name
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get turkish;

  /// Impeller vs Skia comparison title
  ///
  /// In en, this message translates to:
  /// **'Impeller vs Skia Comparison'**
  String get impellerVsSkia;

  /// Performance label
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// Memory usage label
  ///
  /// In en, this message translates to:
  /// **'Memory Usage'**
  String get memoryUsage;

  /// Battery life label
  ///
  /// In en, this message translates to:
  /// **'Battery Life'**
  String get batteryLife;

  /// Animation smoothness label
  ///
  /// In en, this message translates to:
  /// **'Animation Smoothness'**
  String get animationSmoothness;

  /// Rendering speed label
  ///
  /// In en, this message translates to:
  /// **'Rendering Speed'**
  String get renderingSpeed;

  /// Current engine label
  ///
  /// In en, this message translates to:
  /// **'Current Engine'**
  String get currentEngine;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

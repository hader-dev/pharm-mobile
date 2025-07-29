import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'resources/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'user_name'**
  String get user_name;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @my_cart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get my_cart;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @tva.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get tva;

  /// No description provided for @total_ht_amount.
  ///
  /// In en, this message translates to:
  /// **'Total excl. tax'**
  String get total_ht_amount;

  /// No description provided for @total_ttc_amount.
  ///
  /// In en, this message translates to:
  /// **'Total incl. tax'**
  String get total_ttc_amount;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @phone_mobile.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_mobile;

  /// No description provided for @fax.
  ///
  /// In en, this message translates to:
  /// **'Fax'**
  String get fax;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items ({count})'**
  String items(Object count);

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @total_amount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get total_amount;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @market_place.
  ///
  /// In en, this message translates to:
  /// **'Market Place'**
  String get market_place;

  /// No description provided for @medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get medicines;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @legal_and_policies.
  ///
  /// In en, this message translates to:
  /// **'Legal and Policies'**
  String get legal_and_policies;

  /// No description provided for @help_and_support.
  ///
  /// In en, this message translates to:
  /// **'Help and Support'**
  String get help_and_support;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @show_less.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get show_less;

  /// No description provided for @show_more.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get show_more;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @logout_action.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout_action;

  /// No description provided for @cancel_action.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get cancel_action;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @change_password_title.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password_title;

  /// No description provided for @add_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get add_cart;

  /// No description provided for @similar_products.
  ///
  /// In en, this message translates to:
  /// **'Similar Products'**
  String get similar_products;

  /// No description provided for @no_additional_notes.
  ///
  /// In en, this message translates to:
  /// **'No additional notes for this item.'**
  String get no_additional_notes;

  /// No description provided for @para_pharma.
  ///
  /// In en, this message translates to:
  /// **'Para-Pharma'**
  String get para_pharma;

  /// No description provided for @select_language_description.
  ///
  /// In en, this message translates to:
  /// **'Select the language you prefer to use in the app.'**
  String get select_language_description;

  /// No description provided for @vendors.
  ///
  /// In en, this message translates to:
  /// **'Vendors'**
  String get vendors;

  /// No description provided for @medicines_search_field_hint.
  ///
  /// In en, this message translates to:
  /// **'Search by DCI, brand or SKU'**
  String get medicines_search_field_hint;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @errors_field_required.
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get errors_field_required;

  /// No description provided for @errors_invalid_email_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get errors_invalid_email_format;

  /// No description provided for @passwor_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwor_min_length;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Hi! Welcome back, you’ve been missed'**
  String get welcome_back;

  /// No description provided for @check_email.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get check_email;

  /// No description provided for @password_reset_sent.
  ///
  /// In en, this message translates to:
  /// **'We have sent a password reset link to your email, Please check your inbox.'**
  String get password_reset_sent;

  /// No description provided for @back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get back_to_login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register (Don’t have an account?)'**
  String get register;

  /// No description provided for @login_existing.
  ///
  /// In en, this message translates to:
  /// **'Login (Already have an account!)'**
  String get login_existing;

  /// No description provided for @errors_passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errors_passwords_do_not_match;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @registration_success.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registration_success;

  /// No description provided for @check_email_for_verification.
  ///
  /// In en, this message translates to:
  /// **'Check your email for verification'**
  String get check_email_for_verification;

  /// No description provided for @email_not_verified.
  ///
  /// In en, this message translates to:
  /// **'Your email is not verified. Please check your email for verification'**
  String get email_not_verified;

  /// No description provided for @search_by_name_packaging_sku.
  ///
  /// In en, this message translates to:
  /// **'Search by name, packaging or SKU'**
  String get search_by_name_packaging_sku;

  /// No description provided for @search_filters.
  ///
  /// In en, this message translates to:
  /// **'Search Filters'**
  String get search_filters;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @types.
  ///
  /// In en, this message translates to:
  /// **'Types'**
  String get types;

  /// No description provided for @checkout_process.
  ///
  /// In en, this message translates to:
  /// **'Checkout Process'**
  String get checkout_process;

  /// No description provided for @payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get payment_methods;

  /// No description provided for @invoice_types.
  ///
  /// In en, this message translates to:
  /// **'Invoice Types'**
  String get invoice_types;

  /// No description provided for @order_note.
  ///
  /// In en, this message translates to:
  /// **'Order Note'**
  String get order_note;

  /// No description provided for @type_note_hint.
  ///
  /// In en, this message translates to:
  /// **'type your note here...'**
  String get type_note_hint;

  /// No description provided for @total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get total_price;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm_order.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirm_order;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @initial_date.
  ///
  /// In en, this message translates to:
  /// **'Initial date'**
  String get initial_date;

  /// No description provided for @final_date.
  ///
  /// In en, this message translates to:
  /// **'Final date'**
  String get final_date;

  /// No description provided for @tap_to_select.
  ///
  /// In en, this message translates to:
  /// **'Tap to select'**
  String get tap_to_select;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendor;

  /// No description provided for @deliver_to.
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliver_to;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'confirmed'**
  String get confirmed;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'canceled'**
  String get canceled;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get pending;

  /// No description provided for @track_order.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get track_order;

  /// No description provided for @order_invoice.
  ///
  /// In en, this message translates to:
  /// **'Order Invoice'**
  String get order_invoice;

  /// No description provided for @invoice_type.
  ///
  /// In en, this message translates to:
  /// **'Invoice Type'**
  String get invoice_type;

  /// No description provided for @client_notes.
  ///
  /// In en, this message translates to:
  /// **'Client Notes'**
  String get client_notes;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qty;

  /// No description provided for @order_items.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get order_items;

  /// No description provided for @order_summary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get order_summary;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @total_ht.
  ///
  /// In en, this message translates to:
  /// **'Total HT'**
  String get total_ht;

  /// No description provided for @total_ttc.
  ///
  /// In en, this message translates to:
  /// **'Total TTC'**
  String get total_ttc;

  /// No description provided for @shipping_address.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shipping_address;

  /// No description provided for @order_tracking.
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get order_tracking;

  /// No description provided for @order_details.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_details;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @account_settings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get account_settings;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @app_privacy.
  ///
  /// In en, this message translates to:
  /// **'App Privacy'**
  String get app_privacy;

  /// No description provided for @legal_policies.
  ///
  /// In en, this message translates to:
  /// **'Legal and Policies'**
  String get legal_policies;

  /// No description provided for @help_support.
  ///
  /// In en, this message translates to:
  /// **'Help and Support'**
  String get help_support;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @update_profile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get update_profile;

  /// No description provided for @update_profile_description.
  ///
  /// In en, this message translates to:
  /// **'Update your profile details and upload your profile picture.'**
  String get update_profile_description;

  /// No description provided for @set_new_password.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get set_new_password;

  /// No description provided for @set_new_password_description.
  ///
  /// In en, this message translates to:
  /// **'Create a new password. Ensure it differs from previous ones for security.'**
  String get set_new_password_description;

  /// No description provided for @password_requirements.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.'**
  String get password_requirements;

  /// No description provided for @logout_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Logout Confirmation'**
  String get logout_confirmation;

  /// No description provided for @logout_confirmation_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logout_confirmation_message;

  /// No description provided for @account_not_active.
  ///
  /// In en, this message translates to:
  /// **'Your account is not active.'**
  String get account_not_active;

  /// No description provided for @unit_ht_price.
  ///
  /// In en, this message translates to:
  /// **'Unit HT price'**
  String get unit_ht_price;

  /// No description provided for @unit_ttc_price.
  ///
  /// In en, this message translates to:
  /// **'Unit TTC price'**
  String get unit_ttc_price;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'DZD'**
  String get currency;

  /// No description provided for @errors_network_fetch_error.
  ///
  /// In en, this message translates to:
  /// **'Fetch error'**
  String get errors_network_fetch_error;
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
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

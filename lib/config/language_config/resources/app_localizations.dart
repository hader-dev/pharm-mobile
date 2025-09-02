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

  /// No description provided for @hader_pharm.
  ///
  /// In en, this message translates to:
  /// **'Hader Pharm'**
  String get hader_pharm;

  /// No description provided for @we_wish_you_good_health_welcome.
  ///
  /// In en, this message translates to:
  /// **'We wish you a good experience , your health is our priority.'**
  String get we_wish_you_good_health_welcome;

  /// No description provided for @welcome_to_hader.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Hader Pharmacy'**
  String get welcome_to_hader;

  /// No description provided for @change_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get change_phone_number;

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

  /// No description provided for @feedback_field_required.
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get feedback_field_required;

  /// No description provided for @feedback_invalid_email_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get feedback_invalid_email_format;

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

  /// No description provided for @feedback_passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get feedback_passwords_do_not_match;

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

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @bank_transfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bank_transfer;

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

  /// No description provided for @edit_company.
  ///
  /// In en, this message translates to:
  /// **'Edit Company'**
  String get edit_company;

  /// No description provided for @view_company.
  ///
  /// In en, this message translates to:
  /// **'View Company'**
  String get view_company;

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

  /// No description provided for @feedback_network_fetch_error.
  ///
  /// In en, this message translates to:
  /// **'Fetch error'**
  String get feedback_network_fetch_error;

  /// No description provided for @enter_email_for_password_reset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a link to reset your password.'**
  String get enter_email_for_password_reset;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @feedback_company_created.
  ///
  /// In en, this message translates to:
  /// **'Company created successfully'**
  String get feedback_company_created;

  /// No description provided for @company_name.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get company_name;

  /// No description provided for @company_logo.
  ///
  /// In en, this message translates to:
  /// **'Company Logo'**
  String get company_logo;

  /// No description provided for @company_information.
  ///
  /// In en, this message translates to:
  /// **'Company Information'**
  String get company_information;

  /// No description provided for @feedback_company_updated.
  ///
  /// In en, this message translates to:
  /// **'Company updated successfully'**
  String get feedback_company_updated;

  /// No description provided for @update_company.
  ///
  /// In en, this message translates to:
  /// **'Update Company'**
  String get update_company;

  /// No description provided for @feedback_email_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Email is not valid'**
  String get feedback_email_not_valid;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @full_address.
  ///
  /// In en, this message translates to:
  /// **'Full Address'**
  String get full_address;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @view_company_description.
  ///
  /// In en, this message translates to:
  /// **'View your company information and details.'**
  String get view_company_description;

  /// No description provided for @create_company_profile_required.
  ///
  /// In en, this message translates to:
  /// **'You need to create a company profile first.'**
  String get create_company_profile_required;

  /// No description provided for @no_company_associated.
  ///
  /// In en, this message translates to:
  /// **'No company is associated with this account.'**
  String get no_company_associated;

  /// No description provided for @go_back.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get go_back;

  /// No description provided for @city_commune_no.
  ///
  /// In en, this message translates to:
  /// **'City/Commune No.'**
  String get city_commune_no;

  /// No description provided for @logo.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get logo;

  /// No description provided for @nis.
  ///
  /// In en, this message translates to:
  /// **'NIS'**
  String get nis;

  /// No description provided for @rc.
  ///
  /// In en, this message translates to:
  /// **'RC'**
  String get rc;

  /// No description provided for @ai.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get ai;

  /// No description provided for @nis_expanded.
  ///
  /// In en, this message translates to:
  /// **'Static Identification Number'**
  String get nis_expanded;

  /// No description provided for @rc_expanded.
  ///
  /// In en, this message translates to:
  /// **'Commercial Registration Number'**
  String get rc_expanded;

  /// No description provided for @ai_expanded.
  ///
  /// In en, this message translates to:
  /// **'Article of Incorporation'**
  String get ai_expanded;

  /// No description provided for @what_you_distribute.
  ///
  /// In en, this message translates to:
  /// **'What do you distribute?'**
  String get what_you_distribute;

  /// No description provided for @select_category.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get select_category;

  /// No description provided for @bank_account.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get bank_account;

  /// No description provided for @fiscal_id.
  ///
  /// In en, this message translates to:
  /// **'Fiscal ID'**
  String get fiscal_id;

  /// No description provided for @feedback_not_provided.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get feedback_not_provided;

  /// No description provided for @feedback_fill_missing_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the missing fields'**
  String get feedback_fill_missing_fields;

  /// No description provided for @feedback_select_company_type.
  ///
  /// In en, this message translates to:
  /// **'Please select a company type'**
  String get feedback_select_company_type;

  /// No description provided for @company_type_title.
  ///
  /// In en, this message translates to:
  /// **'Company Type'**
  String get company_type_title;

  /// No description provided for @company_type_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the type of your company.'**
  String get company_type_subtitle;

  /// No description provided for @general_info_title.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get general_info_title;

  /// No description provided for @general_info_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Provide your company’s basic details.'**
  String get general_info_subtitle;

  /// No description provided for @legal_info_title.
  ///
  /// In en, this message translates to:
  /// **'Legal Information'**
  String get legal_info_title;

  /// No description provided for @legal_info_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your registration and license details.'**
  String get legal_info_subtitle;

  /// No description provided for @company_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Company Profile'**
  String get company_profile_title;

  /// No description provided for @company_profile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add branding and business overview.'**
  String get company_profile_subtitle;

  /// No description provided for @review_submit_title.
  ///
  /// In en, this message translates to:
  /// **'Review & Submit'**
  String get review_submit_title;

  /// No description provided for @review_submit_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Review all information before submitting.'**
  String get review_submit_subtitle;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @validate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validate;

  /// No description provided for @feedback_invalid_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get feedback_invalid_number;

  /// No description provided for @feedback_invalid_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number'**
  String get feedback_invalid_mobile_number;

  /// No description provided for @feedback_invalid_fax_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid fax number'**
  String get feedback_invalid_fax_number;

  /// No description provided for @verification_successful_for.
  ///
  /// In en, this message translates to:
  /// **'Verification successful for'**
  String get verification_successful_for;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @by_signing_up_you_agree_to_our.
  ///
  /// In en, this message translates to:
  /// **'By signing up, you agree to our'**
  String get by_signing_up_you_agree_to_our;

  /// No description provided for @terms_of_services.
  ///
  /// In en, this message translates to:
  /// **'Terms of Services'**
  String get terms_of_services;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @wilaya.
  ///
  /// In en, this message translates to:
  /// **'Wilaya'**
  String get wilaya;

  /// No description provided for @town.
  ///
  /// In en, this message translates to:
  /// **'Town'**
  String get town;

  /// No description provided for @select_wilaya.
  ///
  /// In en, this message translates to:
  /// **'Select Wilaya'**
  String get select_wilaya;

  /// No description provided for @select_town.
  ///
  /// In en, this message translates to:
  /// **'Select Town'**
  String get select_town;

  /// No description provided for @filters_clinincal.
  ///
  /// In en, this message translates to:
  /// **'Clinical'**
  String get filters_clinincal;

  /// No description provided for @filter_items_dci.
  ///
  /// In en, this message translates to:
  /// **'DCI'**
  String get filter_items_dci;

  /// No description provided for @filter_items_dosage.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get filter_items_dosage;

  /// No description provided for @filter_items_form.
  ///
  /// In en, this message translates to:
  /// **'Form'**
  String get filter_items_form;

  /// No description provided for @filter_items_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get filter_items_status;

  /// No description provided for @filter_items_register_date.
  ///
  /// In en, this message translates to:
  /// **'Registration Date'**
  String get filter_items_register_date;

  /// No description provided for @filter_items_country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get filter_items_country;

  /// No description provided for @filter_items_patent.
  ///
  /// In en, this message translates to:
  /// **'Patent'**
  String get filter_items_patent;

  /// No description provided for @filters_commercial.
  ///
  /// In en, this message translates to:
  /// **'Commercial'**
  String get filters_commercial;

  /// No description provided for @filter_items_brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get filter_items_brand;

  /// No description provided for @filter_items_condition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get filter_items_condition;

  /// No description provided for @filter_items_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get filter_items_type;

  /// No description provided for @filters_regulatory.
  ///
  /// In en, this message translates to:
  /// **'Regulatory'**
  String get filters_regulatory;

  /// No description provided for @filters_logisctics.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get filters_logisctics;

  /// No description provided for @filter_items_stability_duration.
  ///
  /// In en, this message translates to:
  /// **'Stability Duration'**
  String get filter_items_stability_duration;

  /// No description provided for @filter_items_origin_country.
  ///
  /// In en, this message translates to:
  /// **'Country of Origin'**
  String get filter_items_origin_country;

  /// No description provided for @filter_items_packaging_format.
  ///
  /// In en, this message translates to:
  /// **'Packaging Format'**
  String get filter_items_packaging_format;

  /// No description provided for @filters_others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get filters_others;

  /// No description provided for @filter_items_code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get filter_items_code;

  /// No description provided for @filter_items_reimbursement.
  ///
  /// In en, this message translates to:
  /// **'Reimbursement'**
  String get filter_items_reimbursement;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// No description provided for @medicine_overview.
  ///
  /// In en, this message translates to:
  /// **'Medicine overview'**
  String get medicine_overview;

  /// No description provided for @about_distributor.
  ///
  /// In en, this message translates to:
  /// **'About distributor'**
  String get about_distributor;

  /// No description provided for @feedback_failed_to_load_medicine_details.
  ///
  /// In en, this message translates to:
  /// **'Failed to load medicine details'**
  String get feedback_failed_to_load_medicine_details;

  /// No description provided for @product_overview.
  ///
  /// In en, this message translates to:
  /// **'Product overview'**
  String get product_overview;

  /// No description provided for @feedback_failed_to_load_para_pharma_details.
  ///
  /// In en, this message translates to:
  /// **'Failed to load para-pharmaceutical details'**
  String get feedback_failed_to_load_para_pharma_details;

  /// No description provided for @buy_now.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buy_now;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @feedback_loading_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load'**
  String get feedback_loading_failed;

  /// No description provided for @in_stock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get in_stock;

  /// No description provided for @out_stock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get out_stock;

  /// No description provided for @feedback_error_loading_cart.
  ///
  /// In en, this message translates to:
  /// **'Failed to load cart ,please refresh'**
  String get feedback_error_loading_cart;

  /// No description provided for @make_order.
  ///
  /// In en, this message translates to:
  /// **'Make Order'**
  String get make_order;

  /// No description provided for @unit_total_price.
  ///
  /// In en, this message translates to:
  /// **'Unit Total Price'**
  String get unit_total_price;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @distributor_sku.
  ///
  /// In en, this message translates to:
  /// **'Distributor SKU'**
  String get distributor_sku;

  /// No description provided for @image_not_available.
  ///
  /// In en, this message translates to:
  /// **'Image not available'**
  String get image_not_available;

  /// No description provided for @feedback_failed_to_load_announcements.
  ///
  /// In en, this message translates to:
  /// **'Failed to load announcements'**
  String get feedback_failed_to_load_announcements;

  /// No description provided for @vendors_search_field_hint.
  ///
  /// In en, this message translates to:
  /// **'Search vendors by name'**
  String get vendors_search_field_hint;

  /// No description provided for @learn_more.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learn_more;

  /// No description provided for @brands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get brands;

  /// No description provided for @top_vendors.
  ///
  /// In en, this message translates to:
  /// **'Top Vendors'**
  String get top_vendors;

  /// No description provided for @announcement_details.
  ///
  /// In en, this message translates to:
  /// **'Announcement Details'**
  String get announcement_details;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @are_you_sure_cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the order?'**
  String get are_you_sure_cancel_order;

  /// No description provided for @order_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Order cancelled'**
  String get order_cancelled;

  /// No description provided for @feedback_server_error.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get feedback_server_error;

  /// No description provided for @filter_items_distributor_sku.
  ///
  /// In en, this message translates to:
  /// **'Distributor SKU'**
  String get filter_items_distributor_sku;

  /// No description provided for @filter_items_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get filter_items_name;

  /// No description provided for @filter_items_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get filter_items_description;

  /// No description provided for @filter_items_sku.
  ///
  /// In en, this message translates to:
  /// **'SKU'**
  String get filter_items_sku;

  /// No description provided for @price_range.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get price_range;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @lteUnitPriceHt.
  ///
  /// In en, this message translates to:
  /// **'Min Price'**
  String get lteUnitPriceHt;

  /// No description provided for @gteUnitPriceHt.
  ///
  /// In en, this message translates to:
  /// **'Max Price'**
  String get gteUnitPriceHt;

  /// No description provided for @price_range_ht.
  ///
  /// In en, this message translates to:
  /// **'Price Range (HT)'**
  String get price_range_ht;

  /// No description provided for @currency_symbol.
  ///
  /// In en, this message translates to:
  /// **'DA'**
  String get currency_symbol;

  /// No description provided for @order_complaint.
  ///
  /// In en, this message translates to:
  /// **'Order Complaint'**
  String get order_complaint;

  /// No description provided for @item_complaint.
  ///
  /// In en, this message translates to:
  /// **'Item Complaint'**
  String get item_complaint;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @claim_status_history.
  ///
  /// In en, this message translates to:
  /// **'Claim Status History'**
  String get claim_status_history;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @unfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get unfollow;

  /// No description provided for @mark_all_as_read.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get mark_all_as_read;

  /// No description provided for @feedback_session_expired_please_login.
  ///
  /// In en, this message translates to:
  /// **'Session expired, please login again'**
  String get feedback_session_expired_please_login;

  /// No description provided for @search_by_dci_brand_sku.
  ///
  /// In en, this message translates to:
  /// **'Search by DCI, Brand, SKU'**
  String get search_by_dci_brand_sku;

  /// No description provided for @policy.
  ///
  /// In en, this message translates to:
  /// **'Policy'**
  String get policy;

  /// No description provided for @just_now.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get just_now;

  /// No description provided for @minute_ago.
  ///
  /// In en, this message translates to:
  /// **'1 minute ago'**
  String get minute_ago;

  /// No description provided for @minutes_ago.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutes_ago(Object minutes);

  /// No description provided for @hour_ago.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get hour_ago;

  /// No description provided for @hours_ago.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hours_ago(Object hours);

  /// No description provided for @day_ago.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get day_ago;

  /// No description provided for @days_ago.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String days_ago(Object days);

  /// No description provided for @month_ago.
  ///
  /// In en, this message translates to:
  /// **'1 month ago'**
  String get month_ago;

  /// No description provided for @months_ago.
  ///
  /// In en, this message translates to:
  /// **'{months} months ago'**
  String months_ago(Object months);

  /// No description provided for @year_ago.
  ///
  /// In en, this message translates to:
  /// **'1 year ago'**
  String get year_ago;

  /// No description provided for @years_ago.
  ///
  /// In en, this message translates to:
  /// **'{years} years ago'**
  String years_ago(Object years);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get yesterday;

  /// No description provided for @last_week.
  ///
  /// In en, this message translates to:
  /// **'last week'**
  String get last_week;

<<<<<<< Updated upstream
  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Hader Pharma'**
  String get app_name;

  /// No description provided for @no_items_found.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get no_items_found;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;
=======
  /// No description provided for @week_ago.
  ///
  /// In en, this message translates to:
  /// **'One week ago'**
  String get week_ago;

  /// No description provided for @weeks_ago.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks ago'**
  String weeks_ago(Object weeks);
>>>>>>> Stashed changes

  /// No description provided for @announcements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcements;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get see_all;

  /// No description provided for @all_announcements.
  ///
  /// In en, this message translates to:
  /// **'All Announcements'**
  String get all_announcements;

  /// No description provided for @main_features.
  ///
  /// In en, this message translates to:
  /// **'Main Features'**
  String get main_features;

  /// No description provided for @pharmaceutical_form.
  ///
  /// In en, this message translates to:
  /// **'Pharmaceutical Form'**
  String get pharmaceutical_form;

  /// No description provided for @dosage.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get dosage;

  /// No description provided for @packaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging'**
  String get packaging;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @lifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get lifetime;

  /// No description provided for @laboratory.
  ///
  /// In en, this message translates to:
  /// **'Laboratory'**
  String get laboratory;

  /// No description provided for @country_of_origin.
  ///
  /// In en, this message translates to:
  /// **'Country of Origin'**
  String get country_of_origin;

<<<<<<< Updated upstream
  /// No description provided for @week_ago.
  ///
  /// In en, this message translates to:
  /// **'1 week ago'**
  String get week_ago;

  /// No description provided for @weeks_ago.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks ago'**
  String weeks_ago(Object weeks);

=======
>>>>>>> Stashed changes
  /// No description provided for @no_description_available.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get no_description_available;

  /// No description provided for @specifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get specifications;

  /// No description provided for @specialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get specialty;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @no_address_available.
  ///
  /// In en, this message translates to:
  /// **'No address available'**
  String get no_address_available;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @no_phone_available.
  ///
  /// In en, this message translates to:
  /// **'No phone number available'**
  String get no_phone_available;

  /// No description provided for @no_email_available.
  ///
  /// In en, this message translates to:
  /// **'No email available'**
  String get no_email_available;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get ready;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @returned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get returned;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @proforma.
  ///
  /// In en, this message translates to:
  /// **'Proforma Invoice'**
  String get proforma;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @order_placed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully'**
  String get order_placed_successfully;

  /// No description provided for @password_reset_success.
  ///
  /// In en, this message translates to:
  /// **'Password reset success'**
  String get password_reset_success;

  /// No description provided for @make_complaint_success.
  ///
  /// In en, this message translates to:
  /// **'Complaint made successfully'**
  String get make_complaint_success;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get read_more;

  /// No description provided for @password_changed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get password_changed_successfully;

  /// No description provided for @hint_please_enter_otp_sent_to_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter the OTP sent to your email'**
  String get hint_please_enter_otp_sent_to_email;

  /// No description provided for @unauthorized_distributor_login.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized distributor login'**
  String get unauthorized_distributor_login;
<<<<<<< Updated upstream

  /// No description provided for @feedback_no_changes_to_update.
  ///
  /// In en, this message translates to:
  /// **'No changes to update'**
  String get feedback_no_changes_to_update;

  /// No description provided for @feedback_failed_to_load_company_details.
  ///
  /// In en, this message translates to:
  /// **'Failed to load company details'**
  String get feedback_failed_to_load_company_details;

  /// No description provided for @feedback_failed_to_load_company_products.
  ///
  /// In en, this message translates to:
  /// **'Failed to load company products'**
  String get feedback_failed_to_load_company_products;

  /// No description provided for @feedback_failed_to_load_company_categories.
  ///
  /// In en, this message translates to:
  /// **'Failed to load company categories'**
  String get feedback_failed_to_load_company_categories;

  /// No description provided for @update_your_company_information_and_branding.
  ///
  /// In en, this message translates to:
  /// **'Update your company information and branding'**
  String get update_your_company_information_and_branding;

  /// No description provided for @no_company_found.
  ///
  /// In en, this message translates to:
  /// **'No company found'**
  String get no_company_found;

  /// No description provided for @update_company_description.
  ///
  /// In en, this message translates to:
  /// **'Update your company information and branding'**
  String get update_company_description;

  /// No description provided for @create_company_description.
  ///
  /// In en, this message translates to:
  /// **'Create or join a company (pharmacies, distributors, ...) and explore our marketplace and many more Features.'**
  String get create_company_description;

  /// No description provided for @create_company_profile_btn.
  ///
  /// In en, this message translates to:
  /// **'Create a company profile'**
  String get create_company_profile_btn;

  /// No description provided for @already_member_btn.
  ///
  /// In en, this message translates to:
  /// **'Already a member of a company'**
  String get already_member_btn;

  /// No description provided for @create_company.
  ///
  /// In en, this message translates to:
  /// **'Create Company'**
  String get create_company;

  /// No description provided for @no_company_data_available.
  ///
  /// In en, this message translates to:
  /// **'No company data available'**
  String get no_company_data_available;

  /// No description provided for @phone_2.
  ///
  /// In en, this message translates to:
  /// **'Phone 2'**
  String get phone_2;

  /// No description provided for @rc_number.
  ///
  /// In en, this message translates to:
  /// **'RC Number'**
  String get rc_number;

  /// No description provided for @nis_number.
  ///
  /// In en, this message translates to:
  /// **'NIS Number'**
  String get nis_number;

  /// No description provided for @ai_number.
  ///
  /// In en, this message translates to:
  /// **'AI Number'**
  String get ai_number;

  /// No description provided for @companyLogo.
  ///
  /// In en, this message translates to:
  /// **'Company Logo'**
  String get companyLogo;

  /// No description provided for @no_company_is_associated_with_this_account.
  ///
  /// In en, this message translates to:
  /// **'No company is associated with this account.'**
  String get no_company_is_associated_with_this_account;

  /// No description provided for @create_company_action.
  ///
  /// In en, this message translates to:
  /// **'Create Company'**
  String get create_company_action;

  /// No description provided for @loading_text.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading_text;

  /// No description provided for @feedback_profile_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get feedback_profile_updated;

  /// No description provided for @vendor_added_to_favorites.
  ///
  /// In en, this message translates to:
  /// **'Vendor added to your favorites list'**
  String get vendor_added_to_favorites;
=======
>>>>>>> Stashed changes
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

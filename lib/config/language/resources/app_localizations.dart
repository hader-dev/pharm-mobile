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

  /// No description provided for @login_header.
  ///
  /// In en, this message translates to:
  /// **'Login Account'**
  String get login_header;

  /// No description provided for @login_header2.
  ///
  /// In en, this message translates to:
  /// **'Please login to your account'**
  String get login_header2;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get userName;

  /// No description provided for @userNameValidationMsg0.
  ///
  /// In en, this message translates to:
  /// **'Please enter username'**
  String get userNameValidationMsg0;

  /// No description provided for @userNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get userNameHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @passWordValidationMsg0.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get passWordValidationMsg0;

  /// No description provided for @passWordValidationMsg1.
  ///
  /// In en, this message translates to:
  /// **'password should be at least 6 characters'**
  String get passWordValidationMsg1;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'login'**
  String get login;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'none'**
  String get none;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'discount'**
  String get discount;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi,{username}'**
  String greeting(Object username);

  /// No description provided for @sub_greeting.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go Shopping'**
  String get sub_greeting;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @section_brands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get section_brands;

  /// No description provided for @section_new_arrivals.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals 🔥'**
  String get section_new_arrivals;

  /// No description provided for @section_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get section_categories;

  /// No description provided for @all_products.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get all_products;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get see_all;

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

  /// No description provided for @select_all.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get select_all;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @tva.
  ///
  /// In en, this message translates to:
  /// **'TVA'**
  String get tva;

  /// No description provided for @total_ht_amount.
  ///
  /// In en, this message translates to:
  /// **'Total Ht amount'**
  String get total_ht_amount;

  /// No description provided for @total_ttc_amount.
  ///
  /// In en, this message translates to:
  /// **'Total TTC amount'**
  String get total_ttc_amount;

  /// No description provided for @checkout_button.
  ///
  /// In en, this message translates to:
  /// **'Checkout({count})'**
  String checkout_button(Object count);

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
  /// **'Phone / Mobile'**
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
  /// **'qty'**
  String get quantity;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @deliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliverTo;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @onGoing.
  ///
  /// In en, this message translates to:
  /// **'onGoing'**
  String get onGoing;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noReference.
  ///
  /// In en, this message translates to:
  /// **'no ref yet'**
  String get noReference;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @orderRef.
  ///
  /// In en, this message translates to:
  /// **'Order Ref'**
  String get orderRef;

  /// No description provided for @orderNote.
  ///
  /// In en, this message translates to:
  /// **'Order Note'**
  String get orderNote;

  /// No description provided for @orderItemNote.
  ///
  /// In en, this message translates to:
  /// **'Order Item Note'**
  String get orderItemNote;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItems;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentMethodElectronicBanking.
  ///
  /// In en, this message translates to:
  /// **'Eletronic Banking'**
  String get paymentMethodElectronicBanking;

  /// No description provided for @currencyAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'dzd'**
  String get currencyAbbreviation;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @legalAndPolicies.
  ///
  /// In en, this message translates to:
  /// **'Legal and Policies'**
  String get legalAndPolicies;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @changePasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password and new password to change your password'**
  String get changePasswordDescription;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'context.translate!.show_less'**
  String get showLess;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'show More'**
  String get showMore;

  /// No description provided for @noAdditionalNotes.
  ///
  /// In en, this message translates to:
  /// **'No additional notes for this order item.'**
  String get noAdditionalNotes;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @tack_order.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get tack_order;

  /// No description provided for @noSearchHistory.
  ///
  /// In en, this message translates to:
  /// **'No Search History'**
  String get noSearchHistory;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search History'**
  String get searchHistory;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @popularSearches.
  ///
  /// In en, this message translates to:
  /// **'Popular Searches'**
  String get popularSearches;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

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

  /// No description provided for @isService.
  ///
  /// In en, this message translates to:
  /// **'is service'**
  String get isService;

  /// No description provided for @select_brand.
  ///
  /// In en, this message translates to:
  /// **'Select Brand'**
  String get select_brand;

  /// No description provided for @select_category.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get select_category;

  /// No description provided for @all_brands.
  ///
  /// In en, this message translates to:
  /// **'All Brands'**
  String get all_brands;

  /// No description provided for @all_categories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get all_categories;

  /// No description provided for @price_range.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get price_range;

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

  /// No description provided for @order_success_title.
  ///
  /// In en, this message translates to:
  /// **'Order Successfully'**
  String get order_success_title;

  /// No description provided for @order_success_description.
  ///
  /// In en, this message translates to:
  /// **'Your order will be packed by the clerk, will arrive at your house in 3 to 4 days'**
  String get order_success_description;

  /// No description provided for @order_tracking.
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get order_tracking;

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

  /// No description provided for @enterOrderNotes.
  ///
  /// In en, this message translates to:
  /// **'Enter any instructions or notes for this order'**
  String get enterOrderNotes;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

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

  /// No description provided for @option.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get option;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'articles'**
  String get articles;

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

  /// No description provided for @show_more.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get show_more;

  /// No description provided for @show_less.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get show_less;

  /// No description provided for @please_select_article.
  ///
  /// In en, this message translates to:
  /// **'Please select an article'**
  String get please_select_article;

  /// No description provided for @article_added_success.
  ///
  /// In en, this message translates to:
  /// **'Article added to cart successfully'**
  String get article_added_success;

  /// No description provided for @article_added_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add article to cart'**
  String get article_added_failed;

  /// No description provided for @please_select_shipping_address.
  ///
  /// In en, this message translates to:
  /// **'Please select shipping address'**
  String get please_select_shipping_address;

  /// No description provided for @please_select_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Please select Payment Method'**
  String get please_select_payment_method;

  /// No description provided for @clear_cart.
  ///
  /// In en, this message translates to:
  /// **'Clear Cart'**
  String get clear_cart;

  /// No description provided for @clear_cart_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear cart?'**
  String get clear_cart_confirmation;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear!'**
  String get clear;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout'**
  String get logoutConfirmation;

  /// No description provided for @logoutAction.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get cancelAction;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @how_we_can_help.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get how_we_can_help;

  /// No description provided for @topQuestions.
  ///
  /// In en, this message translates to:
  /// **'Top Questions'**
  String get topQuestions;

  /// No description provided for @searchPrompt.
  ///
  /// In en, this message translates to:
  /// **'Write what you are seeking for'**
  String get searchPrompt;

  /// No description provided for @see_more.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get see_more;

  /// No description provided for @updateClientTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Client Details'**
  String get updateClientTitle;

  /// No description provided for @updateClientDescription.
  ///
  /// In en, this message translates to:
  /// **'You can send this order to another client'**
  String get updateClientDescription;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @updateClientButton.
  ///
  /// In en, this message translates to:
  /// **'Update Client'**
  String get updateClientButton;

  /// No description provided for @addressTitle.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressTitle;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get selectLocation;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @updateAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Address Details'**
  String get updateAddressTitle;

  /// No description provided for @updateAddressDescription.
  ///
  /// In en, this message translates to:
  /// **'This address will be used for order placement'**
  String get updateAddressDescription;

  /// No description provided for @addressField.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressField;

  /// No description provided for @cityField.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityField;

  /// No description provided for @wilaya.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get wilaya;

  /// No description provided for @town.
  ///
  /// In en, this message translates to:
  /// **'Town'**
  String get town;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get editAddress;

  /// No description provided for @field_required.
  ///
  /// In en, this message translates to:
  /// **'Field Required'**
  String get field_required;

  /// No description provided for @trade_name.
  ///
  /// In en, this message translates to:
  /// **'Trade Name'**
  String get trade_name;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @no_shipping_address.
  ///
  /// In en, this message translates to:
  /// **'No Shipping Address'**
  String get no_shipping_address;

  /// No description provided for @please_fill_trade_name.
  ///
  /// In en, this message translates to:
  /// **'Please fill the trade name'**
  String get please_fill_trade_name;

  /// No description provided for @please_provide_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please provide the phone number'**
  String get please_provide_phone_number;

  /// No description provided for @phone_min_length.
  ///
  /// In en, this message translates to:
  /// **'Phone must be at least 10 characters.'**
  String get phone_min_length;

  /// No description provided for @fax_max_length.
  ///
  /// In en, this message translates to:
  /// **'Fax must be less than 15 characters.'**
  String get fax_max_length;

  /// No description provided for @mobile_min_length.
  ///
  /// In en, this message translates to:
  /// **'Mobile must be at least 10 characters.'**
  String get mobile_min_length;

  /// No description provided for @mobile_max_length.
  ///
  /// In en, this message translates to:
  /// **'Mobile must be at most 15 characters.'**
  String get mobile_max_length;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @select_language_description.
  ///
  /// In en, this message translates to:
  /// **'Choose the language you prefer for the app.'**
  String get select_language_description;

  /// No description provided for @wait_for_approval.
  ///
  /// In en, this message translates to:
  /// **'wait for approval'**
  String get wait_for_approval;

  /// No description provided for @wait_for_approval_desc.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed and is awaiting confirmation.'**
  String get wait_for_approval_desc;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'confirmed'**
  String get confirmed;

  /// No description provided for @confirmed_desc.
  ///
  /// In en, this message translates to:
  /// **'Your order has been confirmed and is being prepared.'**
  String get confirmed_desc;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @completed_desc.
  ///
  /// In en, this message translates to:
  /// **'Your order has been completed and delivered.'**
  String get completed_desc;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'canceled'**
  String get canceled;

  /// No description provided for @canceled_desc.
  ///
  /// In en, this message translates to:
  /// **'Your order was canceled.'**
  String get canceled_desc;
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

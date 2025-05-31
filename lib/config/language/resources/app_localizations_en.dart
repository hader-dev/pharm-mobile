// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_header => 'Login Account';

  @override
  String get login_header2 => 'Please login to your account';

  @override
  String get signIn => 'Sign In';

  @override
  String get userName => 'Username';

  @override
  String get userNameValidationMsg0 => 'Please enter username';

  @override
  String get userNameHint => 'Enter username';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter password';

  @override
  String get passWordValidationMsg0 => 'Please enter password';

  @override
  String get passWordValidationMsg1 =>
      'password should be at least 6 characters';

  @override
  String get login => 'login';

  @override
  String get count => 'Count';

  @override
  String get none => 'none';

  @override
  String get discount => 'discount';

  @override
  String greeting(Object username) {
    return 'Hi,$username';
  }

  @override
  String get sub_greeting => 'Let\'s go Shopping';

  @override
  String get search => 'Search';

  @override
  String get notifications => 'Notifications';

  @override
  String get section_brands => 'Brands';

  @override
  String get section_new_arrivals => 'New Arrivals 🔥';

  @override
  String get section_categories => 'Categories';

  @override
  String get all_products => 'All Products';

  @override
  String get see_all => 'See All';

  @override
  String get my_cart => 'My Cart';

  @override
  String get summary => 'Summary';

  @override
  String get select_all => 'Select All';

  @override
  String get delete => 'Delete';

  @override
  String get tva => 'TVA';

  @override
  String get total_ht_amount => 'Total Ht amount';

  @override
  String get total_ttc_amount => 'Total TTC amount';

  @override
  String checkout_button(Object count) {
    return 'Checkout($count)';
  }

  @override
  String get payment => 'Payment';

  @override
  String get client => 'Client';

  @override
  String get edit => 'Edit';

  @override
  String get full_name => 'Full Name';

  @override
  String get phone_mobile => 'Phone / Mobile';

  @override
  String get fax => 'Fax';

  @override
  String items(Object count) {
    return 'Items ($count)';
  }

  @override
  String get quantity => 'qty';

  @override
  String get checkout => 'Checkout';

  @override
  String get myOrders => 'My Orders';

  @override
  String get status => 'Status';

  @override
  String get deliverTo => 'Deliver to';

  @override
  String get note => 'Note';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get viewDetails => 'View details';

  @override
  String get onGoing => 'onGoing';

  @override
  String get history => 'History';

  @override
  String get noReference => 'no ref yet';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get orderRef => 'Order Ref';

  @override
  String get orderNote => 'Order Note';

  @override
  String get orderItemNote => 'Order Item Note';

  @override
  String get orderItems => 'Order Items';

  @override
  String get shippingAddress => 'Shipping Address';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get paymentMethodElectronicBanking => 'Eletronic Banking';

  @override
  String get currencyAbbreviation => 'dzd';

  @override
  String get profile => 'Profile';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get preferences => 'Preferences';

  @override
  String get changePassword => 'Change Password';

  @override
  String get language => 'Language';

  @override
  String get legalAndPolicies => 'Legal and Policies';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get logout => 'Logout';

  @override
  String get changePasswordDescription =>
      'Please enter your current password and new password to change your password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get showLess => 'context.translate!.show_less';

  @override
  String get showMore => 'show More';

  @override
  String get noAdditionalNotes => 'No additional notes for this order item.';

  @override
  String get gotIt => 'Got it';

  @override
  String get tack_order => 'Track Order';

  @override
  String get noSearchHistory => 'No Search History';

  @override
  String get searchHistory => 'Search History';

  @override
  String get clearAll => 'Clear All';

  @override
  String get popularSearches => 'Popular Searches';

  @override
  String get searchHint => 'Search...';

  @override
  String get filters => 'Filters';

  @override
  String get reset => 'Reset';

  @override
  String get apply => 'Apply';

  @override
  String get isService => 'is service';

  @override
  String get select_brand => 'Select Brand';

  @override
  String get select_category => 'Select Category';

  @override
  String get all_brands => 'All Brands';

  @override
  String get all_categories => 'All Categories';

  @override
  String get price_range => 'Price Range';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get order_success_title => 'Order Successfully';

  @override
  String get order_success_description =>
      'Your order will be packed by the clerk, will arrive at your house in 3 to 4 days';

  @override
  String get order_tracking => 'Order Tracking';

  @override
  String get close => 'Close';

  @override
  String get save => 'Save';

  @override
  String get home => 'Home';

  @override
  String get cart => 'Cart';

  @override
  String get enterOrderNotes =>
      'Enter any instructions or notes for this order';

  @override
  String get selectPaymentMethod => 'Select Payment Method';

  @override
  String get add_cart => 'Add to Cart';

  @override
  String get similar_products => 'Similar Products';

  @override
  String get option => 'Option';

  @override
  String get articles => 'articles';

  @override
  String get description => 'Description';

  @override
  String get price => 'Price';

  @override
  String get show_more => 'Show more';

  @override
  String get show_less => 'Show less';

  @override
  String get please_select_article => 'Please select an article';

  @override
  String get article_added_success => 'Article added to cart successfully';

  @override
  String get article_added_failed => 'Failed to add article to cart';

  @override
  String get please_select_shipping_address => 'Please select shipping address';

  @override
  String get please_select_payment_method => 'Please select Payment Method';

  @override
  String get clear_cart => 'Clear Cart';

  @override
  String get clear_cart_confirmation => 'Are you sure you want to clear cart?';

  @override
  String get clear => 'Clear!';

  @override
  String get cancel => 'Cancel';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout';

  @override
  String get logoutAction => 'Logout';

  @override
  String get cancelAction => 'No';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get how_we_can_help => 'How can we help you?';

  @override
  String get topQuestions => 'Top Questions';

  @override
  String get searchPrompt => 'Write what you are seeking for';

  @override
  String get see_more => 'See More';

  @override
  String get updateClientTitle => 'Update Client Details';

  @override
  String get updateClientDescription =>
      'You can send this order to another client';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get phone => 'Phone';

  @override
  String get mobile => 'Mobile';

  @override
  String get updateClientButton => 'Update Client';

  @override
  String get addressTitle => 'Address';

  @override
  String get selectLocation => 'Select location';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get updateAddressTitle => 'Update Address Details';

  @override
  String get updateAddressDescription =>
      'This address will be used for order placement';

  @override
  String get addressField => 'Address';

  @override
  String get cityField => 'City';

  @override
  String get wilaya => 'State';

  @override
  String get town => 'Town';

  @override
  String get position => 'Position';

  @override
  String get editAddress => 'Edit Address';

  @override
  String get field_required => 'Field Required';

  @override
  String get trade_name => 'Trade Name';

  @override
  String get unknown => 'Unknown';

  @override
  String get no_shipping_address => 'No Shipping Address';

  @override
  String get please_fill_trade_name => 'Please fill the trade name';

  @override
  String get please_provide_phone_number => 'Please provide the phone number';

  @override
  String get phone_min_length => 'Phone must be at least 10 characters.';

  @override
  String get fax_max_length => 'Fax must be less than 15 characters.';

  @override
  String get mobile_min_length => 'Mobile must be at least 10 characters.';

  @override
  String get mobile_max_length => 'Mobile must be at most 15 characters.';

  @override
  String get select_language => 'Select Language';

  @override
  String get select_language_description =>
      'Choose the language you prefer for the app.';

  @override
  String get wait_for_approval => 'wait for approval';

  @override
  String get wait_for_approval_desc =>
      'Your order has been placed and is awaiting confirmation.';

  @override
  String get confirmed => 'confirmed';

  @override
  String get confirmed_desc =>
      'Your order has been confirmed and is being prepared.';

  @override
  String get completed => 'completed';

  @override
  String get completed_desc => 'Your order has been completed and delivered.';

  @override
  String get canceled => 'canceled';

  @override
  String get canceled_desc => 'Your order was canceled.';
}

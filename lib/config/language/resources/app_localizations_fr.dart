// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get login_header => 'Connexion au compte';

  @override
  String get login_header2 => 'Veuillez vous connecter à votre compte';

  @override
  String get signIn => 'Se connecter';

  @override
  String get userName => 'Nom d\'utilisateur';

  @override
  String get userNameValidationMsg0 => 'Veuillez entrer le nom d\'utilisateur';

  @override
  String get userNameHint => 'Entrez le nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordHint => 'Entrez le mot de passe';

  @override
  String get passWordValidationMsg0 => 'Veuillez entrer le mot de passe';

  @override
  String get passWordValidationMsg1 =>
      'Le mot de passe doit comporter au moins 6 caractères';

  @override
  String get login => 'Connexion';

  @override
  String get count => 'Compte';

  @override
  String get none => 'Aucun';

  @override
  String get discount => 'Remise';

  @override
  String greeting(Object username) {
    return 'Salut, $username';
  }

  @override
  String get sub_greeting => 'Allons faire du shopping';

  @override
  String get search => 'Recherche';

  @override
  String get notifications => 'Notifications';

  @override
  String get section_brands => 'Marques';

  @override
  String get section_new_arrivals => 'Nouveautés 🔥';

  @override
  String get section_categories => 'Catégories';

  @override
  String get all_products => 'Tous les produits';

  @override
  String get see_all => 'Voir tout';

  @override
  String get my_cart => 'Mon panier';

  @override
  String get summary => 'Résumé';

  @override
  String get select_all => 'Tout sélectionner';

  @override
  String get delete => 'Supprimer';

  @override
  String get tva => 'TVA';

  @override
  String get total_ht_amount => 'Montant total HT';

  @override
  String get total_ttc_amount => 'Montant total TTC';

  @override
  String checkout_button(Object count) {
    return 'Commander ($count)';
  }

  @override
  String get payment => 'Paiement';

  @override
  String get client => 'Client';

  @override
  String get edit => 'Modifier';

  @override
  String get full_name => 'Nom complet';

  @override
  String get phone_mobile => 'Téléphone / Mobile';

  @override
  String get fax => 'Fax';

  @override
  String items(Object count) {
    return 'Articles ($count)';
  }

  @override
  String get quantity => 'Qté';

  @override
  String get checkout => 'Commander';

  @override
  String get myOrders => 'Mes commandes';

  @override
  String get status => 'Statut';

  @override
  String get deliverTo => 'Livrer à';

  @override
  String get note => 'Note';

  @override
  String get totalAmount => 'Montant total';

  @override
  String get viewDetails => 'Voir les détails';

  @override
  String get onGoing => 'En cours';

  @override
  String get history => 'Historique';

  @override
  String get noReference => 'aucune référence pour le moment';

  @override
  String get orderDetails => 'Détails de la commande';

  @override
  String get orderRef => 'Référence de commande';

  @override
  String get orderNote => 'Note de commande';

  @override
  String get orderItemNote => 'Note d\'article';

  @override
  String get orderItems => 'Articles commandés';

  @override
  String get shippingAddress => 'Adresse de livraison';

  @override
  String get orderSummary => 'Résumé de la commande';

  @override
  String get paymentMethod => 'Méthode de paiement';

  @override
  String get paymentMethodElectronicBanking => 'Banque électronique';

  @override
  String get currencyAbbreviation => 'dzd';

  @override
  String get profile => 'Profil';

  @override
  String get accountSettings => 'Paramètres du compte';

  @override
  String get preferences => 'Préférences';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get language => 'Langue';

  @override
  String get legalAndPolicies => 'Mentions légales et politiques';

  @override
  String get helpAndSupport => 'Aide et support';

  @override
  String get logout => 'Déconnexion';

  @override
  String get changePasswordDescription =>
      'Veuillez entrer votre mot de passe actuel et le nouveau mot de passe pour modifier votre mot de passe';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get showLess => 'Montrer moins';

  @override
  String get showMore => 'Montrer plus';

  @override
  String get noAdditionalNotes =>
      'Aucune note supplémentaire pour cet article.';

  @override
  String get gotIt => 'Compris';

  @override
  String get tack_order => 'Suivi de commande';

  @override
  String get noSearchHistory => 'Aucun historique de recherche';

  @override
  String get searchHistory => 'Historique de recherche';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get popularSearches => 'Recherches populaires';

  @override
  String get searchHint => 'Rechercher...';

  @override
  String get filters => 'Filtres';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get apply => 'Appliquer';

  @override
  String get isService => 'Est un service';

  @override
  String get select_brand => 'Sélectionner une marque';

  @override
  String get select_category => 'Sélectionner une catégorie';

  @override
  String get all_brands => 'Toutes les marques';

  @override
  String get all_categories => 'Toutes les catégories';

  @override
  String get price_range => 'Plage de prix';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get order_success_title => 'Commande réussie';

  @override
  String get order_success_description =>
      'Votre commande sera emballée par le commis et arrivera chez vous dans 3 à 4 jours';

  @override
  String get order_tracking => 'Suivi de commande';

  @override
  String get close => 'Fermer';

  @override
  String get save => 'Enregistrer';

  @override
  String get home => 'Accueil';

  @override
  String get cart => 'Panier';

  @override
  String get enterOrderNotes =>
      'Entrez des instructions ou des remarques pour cette commande';

  @override
  String get selectPaymentMethod => 'Sélectionnez le mode de paiement';

  @override
  String get add_cart => 'Ajouter au panier';

  @override
  String get similar_products => 'Produits similaires';

  @override
  String get option => 'Option';

  @override
  String get articles => 'Articles';

  @override
  String get description => 'Description';

  @override
  String get price => 'Prix';

  @override
  String get show_more => 'Show more';

  @override
  String get show_less => 'Show less';

  @override
  String get please_select_article => 'Veuillez sélectionner un article';

  @override
  String get article_added_success => 'Article ajouté au panier avec succès';

  @override
  String get article_added_failed =>
      'Échec de l\'ajout de l\'article au panier';

  @override
  String get please_select_shipping_address =>
      'Veuillez sélectionner l\'adresse de livraison';

  @override
  String get please_select_payment_method =>
      'Veuillez sélectionner le mode de paiement';

  @override
  String get clear_cart => 'Vider le panier';

  @override
  String get clear_cart_confirmation =>
      'Êtes-vous sûr de vouloir vider le panier ?';

  @override
  String get clear => 'Vider !';

  @override
  String get cancel => 'Annuler';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout';

  @override
  String get logoutAction => 'Logout';

  @override
  String get cancelAction => 'No';

  @override
  String get changePasswordTitle => 'Modifier le mot de passe';

  @override
  String get how_we_can_help => 'Comment pouvons-nous vous aider ?';

  @override
  String get topQuestions => 'Questions fréquentes';

  @override
  String get searchPrompt => 'Écrivez ce que vous recherchez';

  @override
  String get see_more => 'Voir plus';

  @override
  String get updateClientTitle => 'Mettre à jour les détails du client';

  @override
  String get updateClientDescription =>
      'Vous pouvez envoyer cette commande à un autre client';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom de famille';

  @override
  String get phone => 'Téléphone';

  @override
  String get mobile => 'Portable';

  @override
  String get updateClientButton => 'Mettre à jour le client';

  @override
  String get addressTitle => 'Adresse';

  @override
  String get selectLocation => 'Sélectionner un lieu';

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get updateAddressTitle => 'Mettre à jour les détails de l\'adresse';

  @override
  String get updateAddressDescription =>
      'Cette adresse sera utilisée pour passer des commandes';

  @override
  String get addressField => 'Adresse';

  @override
  String get cityField => 'Ville';

  @override
  String get wilaya => 'Wilaya';

  @override
  String get town => 'Ville';

  @override
  String get position => 'Position';

  @override
  String get editAddress => 'Modifier l\'adresse';

  @override
  String get field_required => 'Champ requis';

  @override
  String get trade_name => 'Nom commercial';

  @override
  String get unknown => 'Inconnu';

  @override
  String get no_shipping_address => 'Aucune adresse de livraison';

  @override
  String get please_fill_trade_name => 'Veuillez renseigner le nom commercial';

  @override
  String get please_provide_phone_number =>
      'Veuillez fournir le numéro de téléphone';

  @override
  String get phone_min_length =>
      'Le numéro de téléphone doit comporter au moins 10 caractères.';

  @override
  String get fax_max_length => 'Le fax doit comporter moins de 15 caractères.';

  @override
  String get mobile_min_length =>
      'Le mobile doit comporter au moins 10 caractères.';

  @override
  String get mobile_max_length =>
      'Le mobile doit comporter au maximum 15 caractères.';

  @override
  String get select_language => 'Choisir la langue';

  @override
  String get select_language_description =>
      'Choisissez la langue que vous préférez pour l\'application.';

  @override
  String get wait_for_approval => 'en attente d\'approbation';

  @override
  String get wait_for_approval_desc =>
      'Votre commande a été passée et est en attente de confirmation.';

  @override
  String get confirmed => 'confirmée';

  @override
  String get confirmed_desc =>
      'Votre commande a été confirmée et est en cours de préparation.';

  @override
  String get completed => 'terminée';

  @override
  String get completed_desc => 'Votre commande a été livrée avec succès.';

  @override
  String get canceled => 'annulée';

  @override
  String get canceled_desc => 'Votre commande a été annulée.';
}

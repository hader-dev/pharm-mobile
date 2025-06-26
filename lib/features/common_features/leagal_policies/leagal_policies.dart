import 'package:flutter/material.dart';

import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';

class LegalPoliciesScreen extends StatelessWidget {
  const LegalPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Theme(
          data: ThemeData(
              scrollbarTheme:
                  ScrollbarThemeData(thumbColor: WidgetStatePropertyAll(context.theme.primaryColor.withAlpha(170)))),
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSizesManager.p8,
              right: AppSizesManager.p8,
              bottom: AppSizesManager.p8,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                    child: Scrollbar(
                      radius: const Radius.circular(AppSizesManager.commonWidgetsRadius),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: AppSizesManager.p8),
                              Text('''📝 Terms & Conditions (Algérie)
Date d’effet : [Insérer la date]
Dernière mise à jour : [Insérer la date]

Bienvenue sur [Nom de l’application]. En utilisant notre application, vous acceptez nos conditions générales ci-dessous.

1. Utilisation de l’application
Vous devez avoir au moins 18 ans ou l’autorisation d’un tuteur légal.

Vous vous engagez à ne pas utiliser notre plateforme à des fins illégales ou abusives.

2. Comptes utilisateurs
Vous êtes responsable de la confidentialité de vos identifiants.

Informez-nous immédiatement en cas d’utilisation non autorisée de votre compte.

3. Commandes
Toute commande est soumise à disponibilité et confirmation du prix.

Nous nous réservons le droit de refuser toute commande pour des raisons justifiées.

4. Tarification
Les prix peuvent changer sans préavis.

En cas d’erreur typographique ou technique, nous nous réservons le droit de corriger le prix.

5. Propriété intellectuelle
Tous les contenus, logos, et marques sont la propriété de [Nom de l’app] ou de ses partenaires.

6. Droit applicable
Ces conditions sont régies par la loi algérienne.

Tout litige sera soumis à la juridiction des tribunaux compétents en Algérie.

🔐 Politique de Confidentialité (Algérie)
Date d’effet : [Insérer la date]

Chez [Nom de l’application], nous respectons votre vie privée et vos données personnelles conformément à la loi algérienne sur la protection des données.

Informations collectées
Nom, adresse, numéro de téléphone, adresse email.

Informations de paiement (via prestataires sécurisés).

Données d’utilisation de l’application.

Utilisation des données
Pour traiter vos commandes et livraisons.

Pour personnaliser votre expérience.

Pour améliorer notre service.

Pour vous contacter en cas de besoin.

Partage des données
Nous ne vendons pas vos données.

Certaines données peuvent être partagées avec des partenaires logistiques ou de paiement uniquement pour le traitement de votre commande.

Vos droits
Vous avez le droit d’accéder, de corriger ou de supprimer vos données à tout moment en nous contactant.

🔄 Politique de Retour & Remboursement (Algérie)
Date d’effet : [Insérer la date]

Votre satisfaction est notre priorité.

Retours
Vous pouvez retourner un article dans un délai de [7/14/30] jours après réception.

L’article doit être non utilisé, dans son emballage d’origine, avec le reçu ou preuve d’achat.

Remboursements
Le remboursement sera effectué par le même mode de paiement utilisé.

Délai : 5 à 10 jours ouvrables après approbation.

Articles non remboursables
Produits périssables.

Produits d’hygiène ou de soins personnels.

Cartes cadeaux.

🚚 Politique de Livraison (Algérie)
Date d’effet : [Insérer la date]

Délais de livraison
Livraison standard : 3 à 7 jours ouvrables.

Livraison express (si disponible) : 1 à 3 jours ouvrables.

Zones desservies
Nous livrons dans toutes les wilayas d’Algérie (selon disponibilité).

Suivi de commande
Un numéro de suivi vous sera communiqué par email ou SMS après l’expédition.

Frais de livraison
Les frais varient selon la wilaya et le poids du colis.

Partenaires
Nous travaillons avec des transporteurs locaux fiables pour assurer un service rapide et sécurisé.
                                  ''',
                                  softWrap: true,
                                  style: AppTypography.bodySmallStyle
                                      .copyWith(color: TextColors.primary.color, height: 1.5)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

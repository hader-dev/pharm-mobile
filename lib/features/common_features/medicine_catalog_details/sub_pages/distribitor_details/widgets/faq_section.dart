import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../../config/theme/colors_manager.dart';
import '../../../../../../utils/constants.dart';
import 'question_widget.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppSizesManager.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Questions & Réponses',
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.accent1Shade1),
            ),
            QuestionWidget(
              question: "How to add restaurant food to cart ?",
              answer: Text(
                "I'm ayoub larbaoui a flutter apps devoloper",
                style: context.responsiveTextTheme.current.bodySmall
                    .copyWith(color: TextColors.secondary.color),
              ),
            ),
            QuestionWidget(
              question: "How to pass order ?",
              answer: Text(
                "I'm ayoub larbaoui a flutter apps devoloper",
                style: context.responsiveTextTheme.current.bodySmall
                    .copyWith(color: TextColors.secondary.color),
              ),
            ),
            QuestionWidget(
              question: "How to cancel order  ?",
              answer: Text(
                "I'm ayoub larbaoui a flutter apps devoloper",
                style: context.responsiveTextTheme.current.bodySmall
                    .copyWith(color: TextColors.secondary.color),
              ),
            ),
            QuestionWidget(
              question: "How to add new delivery address ?",
              answer: Text(
                "I'm ayoub larbaoui a flutter apps devoloper",
                style: context.responsiveTextTheme.current.bodySmall
                    .copyWith(color: TextColors.secondary.color),
              ),
            ),
            QuestionWidget(
              question: "How to add new delivery address ?",
              answer: Text(
                "I'm ayoub larbaoui a flutter apps devoloper",
                style: context.responsiveTextTheme.current.bodySmall
                    .copyWith(color: TextColors.secondary.color),
              ),
            ),
          ],
        ));
  }
}

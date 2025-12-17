import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ConfirmOrderButton extends StatefulWidget {
  const ConfirmOrderButton({super.key});

  @override
  State<ConfirmOrderButton> createState() => _ConfirmOrderButtonState();
}

class _ConfirmOrderButtonState extends State<ConfirmOrderButton> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DelegateCreateOrderCubit>();
    final translation = context.translation!;
    return BlocBuilder<DelegateCreateOrderCubit, DelegateCreateOrderState>(builder: (context, state) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: cubit.submitOrder,
          child: state is DeligateOrderLoading
              ? SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(translation.confirm),
        ),
      );
    });
  }
}

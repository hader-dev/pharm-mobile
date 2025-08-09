


import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';

void makeComplaint(OrderComplaintsCubit cubit,GlobalKey<FormState> formKey) {
  if (!formKey.currentState!.validate()) return;
  cubit.makeComplaint();
}
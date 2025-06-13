import 'package:flutter/material.dart';

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => _MedicineProductsPageState();
}

class _MedicineProductsPageState extends State<MedicineProductsPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  bool get wantKeepAlive => true;
}

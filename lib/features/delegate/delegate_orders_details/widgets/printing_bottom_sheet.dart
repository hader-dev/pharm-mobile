import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_thermal_printer/utils/printer.dart' show Printer;
import 'package:go_router/go_router.dart';

import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/cubit/order_details/orders_details_cubit.dart'
    show DelegateOrderDetails2Cubit;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/cubit/printing/cubit/print_order_cubit.dart'
    show
        BlueToothTurnedOff,
        PairedPrintersLoaded,
        PairedPrintersLoading,
        PrintDelegateOrderCubit,
        PrintDelegateOrderState,
        PrintersLoaded,
        PrintersLoading,
        PrintersScanStarted,
        PrintersScanStopped;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/delegate_orders_details.dart'
    show DelegateOrdersDetailsScreen;

import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../config/theme/colors_manager.dart' show AppColors, SystemColors, TextColors;
import '../../../../utils/thermal_printer/ble_thermal_printer_helper.dart' show BLEThermalPrintersHelper;
import '../../../common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import '../../../common/spacers/responsive_gap.dart' show ResponsiveGap;

class DelegatePrintingBottomSheet extends StatelessWidget {
  const DelegatePrintingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit =
        DelegateOrdersDetailsScreen.delegateOrdersDetailsScaffoldKey.currentContext!.read<DelegateOrderDetails2Cubit>();

    return BlocProvider(
      create: (context) => PrintDelegateOrderCubit(
        thermalPrintingHelper: BLEThermalPrintersHelper(),
      )..init(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Print order receipt", style: context.responsiveTextTheme.current.headLine2),
          const ResponsiveGap.s16(),
          Text("Paired printers : ", style: context.responsiveTextTheme.current.headLine4SemiBold),
          const ResponsiveGap.s16(),
          ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: BlocBuilder<PrintDelegateOrderCubit, PrintDelegateOrderState>(
                // buildWhen: (previous, current) => current is
                builder: (context, state) {
                  PrintDelegateOrderCubit printCubit = context.read<PrintDelegateOrderCubit>();
                  if (state is BlueToothTurnedOff) {
                    Center(
                      child: Column(
                        children: [
                          Text("Bluethooth is turned off",
                              style: context.responsiveTextTheme.current.body1Medium
                                  .copyWith(color: TextColors.ternary.color)),
                          const ResponsiveGap.s12(),
                          PrimaryTextButton(
                            label: 'turn on bluethooth',
                            labelColor: AppColors.accent1Shade1,
                            borderColor: AppColors.accent1Shade1,
                            isOutLined: true,
                            onTap: () => context.pop(),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is PairedPrintersLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is PairedPrintersLoaded && printCubit.pairedDevices.isEmpty) {
                    return Center(
                      child: Text("No printers available",
                          style: context.responsiveTextTheme.current.body1Medium
                              .copyWith(color: TextColors.ternary.color)),
                    );
                  }
                  return ListView(
                      shrinkWrap: true,
                      children: printCubit.pairedDevices
                          .map((device) => ListTile(
                                leading: Icon(Iconsax.printer,
                                    size: context.responsiveAppSizeTheme.current.iconSize20,
                                    color: AppColors.accent1Shade1),
                                trailing: TextButton(
                                    onPressed: () {
                                      printCubit.connectPrinter(Printer(address: device.address, name: device.name));
                                    },
                                    child: Text("print",
                                        style: context.responsiveTextTheme.current.body3Medium
                                            .copyWith(color: AppColors.accent1Shade1))),
                                title: Text("${device.name}" ?? 'Unknown printer'),
                                onTap: () {
                                  //printCubit.printOrder(printer: printer);

                                  context.pop();
                                },
                              ))
                          .toList());
                },
              )),
          ResponsiveGap.s24(),
          ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: BlocBuilder<PrintDelegateOrderCubit, PrintDelegateOrderState>(
                // buildWhen: (previous, current) => current is
                builder: (context, state) {
                  PrintDelegateOrderCubit printCubit = context.read<PrintDelegateOrderCubit>();
                  if (state is BlueToothTurnedOff) {
                    Center(
                      child: Column(
                        children: [
                          Text("Bluethooth is turned off",
                              style: context.responsiveTextTheme.current.body1Medium
                                  .copyWith(color: TextColors.ternary.color)),
                          const ResponsiveGap.s12(),
                          PrimaryTextButton(
                            label: 'turn on bluethooth',
                            labelColor: AppColors.accent1Shade1,
                            borderColor: AppColors.accent1Shade1,
                            isOutLined: true,
                            onTap: () => context.pop(),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is PrintersLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is PrintersLoaded && printCubit.blePrinters.isEmpty) {
                    return Center(
                      child: Text("No printers available",
                          style: context.responsiveTextTheme.current.body1Medium
                              .copyWith(color: TextColors.ternary.color)),
                    );
                  }
                  return ListView(
                      shrinkWrap: true,
                      children: printCubit.blePrinters
                          .map((printer) => ListTile(
                                title: Text(printer.name ?? 'Unknown printer'),
                                onTap: () {
                                  //printCubit.printOrder(printer: printer);
                                  context.pop();
                                },
                              ))
                          .toList());
                },
              )),
          const ResponsiveGap.s16(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
            child: BlocBuilder<PrintDelegateOrderCubit, PrintDelegateOrderState>(
              buildWhen: (previous, current) => current is PrintersScanStarted || current is PrintersScanStopped,
              builder: (context, state) {
                return PrimaryTextButton(
                  label: state is PrintersScanStarted ? "Stop scanning" : "Start scanning",
                  onTap: state is PrintersScanStarted
                      ? () => context.read<PrintDelegateOrderCubit>().stopPrintersScan()
                      : () => context.read<PrintDelegateOrderCubit>().startPrintersScan(),
                  color: state is PrintersScanStarted ? SystemColors.red.primary : SystemColors.green.primary,
                );
              },
            ),
          ),
          const ResponsiveGap.s12(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
            child: PrimaryTextButton(
              label: translation.cancel,
              labelColor: AppColors.accent1Shade1,
              borderColor: AppColors.accent1Shade1,
              isOutLined: true,
              onTap: () {
                context.pop();
              },
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

part of 'print_order_cubit.dart';

sealed class PrintDelegateOrderState {}

final class PrintOrderInitial extends PrintDelegateOrderState {}

final class PrintersScanStarted extends PrintDelegateOrderState {}

final class PrintersScanStopped extends PrintDelegateOrderState {}

final class PrintersLoading extends PrintDelegateOrderState {}

final class PrintersLoaded extends PrintDelegateOrderState {}

final class PairedPrintersLoading extends PrintDelegateOrderState {}

final class PairedPrintersLoaded extends PrintDelegateOrderState {}

final class ConnectingPrinter extends PrintDelegateOrderState {}

final class ConnectingPrinterSuccess extends PrintDelegateOrderState {}

final class ConnectingPrinterFailed extends PrintDelegateOrderState {}

final class BlueToothTurnedOff extends PrintDelegateOrderState {}

final class BlueToothTurnedOn extends PrintDelegateOrderState {}

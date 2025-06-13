part of 'app_layout_cubit.dart';

sealed class AppLayoutState {}

final class AppLayoutInitial extends AppLayoutState {}

final class PageChanged extends AppLayoutState {}

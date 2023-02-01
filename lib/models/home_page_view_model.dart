import 'package:flutter/material.dart';

class HomePageViewModel {
  final String title;
  final IconData iconData;
  final num count;

  const HomePageViewModel({
    required this.title,
    required this.iconData,
    required this.count,
  });
}

const List<HomePageViewModel> homePageViewModelList = [
  HomePageViewModel(
      title: 'Today Service',
      iconData: Icons.settings_rounded,
      count: 5),
  HomePageViewModel(
      title: 'All Service',
      iconData: Icons.settings_rounded,
      count: 10),
  HomePageViewModel(
      title: 'Total Employee',
      iconData: Icons.people,
      count: 6),
  HomePageViewModel(
      title: 'Total Offer',
      iconData: Icons.card_giftcard,
      count: 15),
  HomePageViewModel(
      title: 'Income',
      iconData: Icons.monetization_on,
      count: 200000),
  HomePageViewModel(
      title: 'Expenses',
      iconData: Icons.monetization_on,
      count: 100000),
];
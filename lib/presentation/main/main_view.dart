import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/main/pages/home/view/home_page.dart';
import 'package:flutter_advanced/presentation/main/pages/notifications/view/notifications_page.dart';
import 'package:flutter_advanced/presentation/main/pages/search/view/search_page.dart';
import 'package:flutter_advanced/presentation/main/pages/settings/view/settings_page.dart';
import 'package:flutter_advanced/presentation/resources/color_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];
  var _title = AppStrings.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: AppStrings.home),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: AppStrings.notifications),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_suggest_outlined), label: AppStrings.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}

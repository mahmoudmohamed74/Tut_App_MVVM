import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/data/data_source/local_data_source.dart';
import 'package:flutter_advanced/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced/presentation/resources/routes_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.changeLangIc),
            title: Text(AppStrings.changeLanguage, style: Theme.of(context).textTheme.bodyLarge),
            trailing: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.contactUsIc),
            title: Text(AppStrings.contactUs, style: Theme.of(context).textTheme.bodyLarge),
            trailing: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
            title: Text(AppStrings.inviteYourFriends, style: Theme.of(context).textTheme.bodyLarge),
            trailing: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logoutIc),
            title: Text(AppStrings.logout, style: Theme.of(context).textTheme.bodyLarge),
            trailing: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  _logout() {
    // app prefs user logged out
    _appPreferences.logout();
    // clear cache
    _localDataSource.clearCache();
    // navigate to login
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}

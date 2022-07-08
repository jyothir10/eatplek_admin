import 'package:eatplek_admin/Components/BottomBar.dart';
import 'package:eatplek_admin/Components/SettingsCard.dart';
import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:eatplek_admin/Screens/EditProfileScreen.dart';
import 'package:eatplek_admin/Screens/MenuChangeScreen.dart';
import 'package:eatplek_admin/Screens/NotificationScreen.dart';
import 'package:eatplek_admin/Screens/TimeChangeScreen.dart';
import 'package:flutter/material.dart';

class SettingsSCreen extends StatefulWidget {
  static const String id = '/settings';
  const SettingsSCreen({Key? key}) : super(key: key);

  @override
  State<SettingsSCreen> createState() => _SettingsSCreenState();
}

class _SettingsSCreenState extends State<SettingsSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        index: 3,
      ),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * .11),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff042e60),
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, DashboardScreen.id);
            },
          ),
          title: const Text(
            "Settings",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, DashboardScreen.id);
          return false;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, bottom: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Account Setting',
                        style: TextStyle(
                          color: Color(0x91000000),
                          fontSize: 12,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                SettingsCard(
                  text: 'Edit Profile',
                  onTap: () {
                    Navigator.pushNamed(context, EditProfileScreen.id);
                  },
                ),
                SettingsCard(
                  text: 'Request for menu change',
                  onTap: () {
                    Navigator.pushNamed(context, MenuChangeScreen.id);
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Account Setting',
                        style: TextStyle(
                          color: Color(0x91000000),
                          fontSize: 12,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                SettingsCard(
                  text: "Time change",
                  onTap: () {
                    Navigator.pushNamed(context, TimeChangeScreen.id);
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'App Setting',
                        style: TextStyle(
                          color: Color(0x91000000),
                          fontSize: 12,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                SettingsCard(
                  text: "Notifications",
                  onTap: () {
                    Navigator.pushNamed(context, NotificationScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

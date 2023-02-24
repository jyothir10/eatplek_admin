import 'dart:convert';

import 'package:eatplek_admin/Components/EditProfileTextField.dart';
import 'package:eatplek_admin/Components/ProfileButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Exceptions/api_exception.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const String id = '/editprofile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  bool showSpinner = false;
  String msg = "";
  String? id, token;
  static const except = {'exc': 'An error occured'};
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getProfile() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    id = sharedpreferences.getString("id");
    token = sharedpreferences.getString("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/$id');

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  updateRes() async {
    showSpinner = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    Map body1 = {
      "name": nameController.text.trim(),
      "location": locationController.text.trim(),
      "phone": phoneController.text.trim(),
    };

    final body = jsonEncode(body1);
    var urlfinal = Uri.https(URL_Latest, '/restaurant/profile');

    http.Response response =
        await http.put(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      msg = await jsonData['message'];
      if (msg == "profile updated") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text("Restaurant profile updated successfully")));
        nameController.clear();
        phoneController.clear();
        locationController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text("Could not update restaurant")));
      }

      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    phoneController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 39),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff1A191A),
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? Stack(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xffefeeee),
                            radius: 51.2,
                            child: Text(
                              "S",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.826087951660156,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 65,
                            left: 65,
                            child: InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "images/edit_profile.png",
                                height: 45,
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(),
                EditProfileTextField(
                  myController: nameController,
                  text: 'Name',
                  type: TextInputType.name,
                ),
                EditProfileTextField(
                  myController: phoneController,
                  text: 'Phone',
                  type: TextInputType.number,
                ),
                EditProfileTextField(
                  myController: locationController,
                  text: 'Location',
                  type: TextInputType.streetAddress,
                ),
                ProfileButton(
                    text: "       Save       ",
                    onTap: () {
                      updateRes();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vepay_app/common/common_dialog.dart';
import 'package:vepay_app/common/common_method.dart';
import 'package:vepay_app/common/global_values.dart';
import 'package:vepay_app/common/responsive_utils.dart';
import 'package:vepay_app/maintenance.dart';
import 'package:vepay_app/models/member_model.dart';
import 'package:vepay_app/screens/auth/intro.dart';
import 'package:vepay_app/screens/dashboard.dart';
import 'package:vepay_app/services/app_info_service.dart';
import 'package:vepay_app/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  @override
  void initState() {
    _startDelay();

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<bool> _checkUserLoginStatus() async {
    WidgetsFlutterBinding.ensureInitialized();
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loginStatus") ?? false;
  }

  _goNext() async {
    await AppInfoService().getAppInfo().then((value) async {
      setState(() {
        appInfoGlobal.value = value;
      });

      if (AppInfoService().getValueByKey('web_maintenance_mode') == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => const Maintenance(),
          ),
        );
      } else {
        await _checkUserLoginStatus().then((value) async {
          if (value) {
            var prefs = await SharedPreferences.getInstance();

            String? email = prefs.getString("email");
            String? password = prefs.getString("password") ?? "";
            bool? isGoogle = prefs.getBool("isGoogle") ?? false;

            await AuthService().getFcmTokenByEmail(email!).then((value) async {
              String? fcmFromDb = value;

              print("fcm from db: ${fcmFromDb ?? ""}");

              var prefs1 = SharedPreferences.getInstance();

              String currentToken = await prefs1
                  .then((value) => value.getString("fcmToken") ?? "");

              String fcmToken = "";

              if (fcmFromDb != null) {
                if (currentToken.isEmpty || currentToken == fcmFromDb) {
                  fcmToken = fcmFromDb;
                } else if (currentToken != fcmFromDb) {
                  fcmToken = currentToken;
                }
              } else {
                fcmToken = currentToken;
              }

              Map<String, dynamic> data;

              if (isGoogle) {
                data = {
                  'is_google': isGoogle,
                  'email': email,
                  'fcm_token': fcmToken,
                };
              } else {
                data = {
                  'is_google': isGoogle,
                  'email': email,
                  'password': password,
                  'fcm_token': fcmToken,
                };
              }

              await AuthService().login(data).then((value) {
                MemberModel? res = value;

                CommonMethods().saveUserLoginsDetails(
                  res.userId!,
                  res.name ?? res.email!,
                  res.email!,
                  password,
                  true,
                  isGoogle,
                  fcmToken,
                );

                currentMemberGlobal.value = res;

                _goToPage(Dashboard(member: currentMemberGlobal.value));
              }).onError((error, stackTrace) {
                buildError(error);
              });
            });
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => const Intro(),
              ),
            );
          }
        });
      }
    });
  }

  buildError(var e) {
    CommonDialog.buildWrongWithAuth(context, false, e.toString());
  }

  _goToPage(Widget name) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * (ResponsiveBreakpoints.of(context).isMobile ? (CommonResponsiveUtils.isLandscape(context) ? 0.35 : 0.35) : (CommonResponsiveUtils.isLandscape(context) ? 0.2 : 0.3))),

              Image(
                width: MediaQuery.of(context).size.width * 0.35,
                image: const AssetImage('assets/logo_main.png'),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // Text(
              //   "v 0.0.1",
              //   style: Theme.of(context).textTheme.caption,
              // ),
              const Spacer(),
              Text(
                "PT. Vepay Multipayment Internasional",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

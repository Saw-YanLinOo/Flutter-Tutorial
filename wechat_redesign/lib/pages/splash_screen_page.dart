import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/pages/get_otp_page.dart';
import 'package:wechat_redesign/pages/home_page.dart';
import 'package:wechat_redesign/pages/login_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/utils/extensions.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Text your friends and share moments',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TEXT_REGULAR_2X,
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_SMALL,
                  ),
                  Text(
                    'End-to-end secured messaging app with Social Elements',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TEXT_SMALL,
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_LARGE_3,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          navigateToScreen(context, const GetOtpPage());
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2,
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: TEXT_REGULAR_2X,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MARGIN_LARGE,
                      ),
                      TextButton(
                        onPressed: () {
                          navigateToScreen(context, const LoginPage());
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: TEXT_REGULAR_2X,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MARGIN_LARGE_3,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

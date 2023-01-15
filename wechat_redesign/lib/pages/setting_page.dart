import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/setting_bloc.dart';
import 'package:wechat_redesign/pages/splash_screen_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingBloc(),
      builder: (context, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  // var bloc = Provider.of<SettingBloc>(context, listen: false);
                  // bloc.onTapLogout();
                  context.read<SettingBloc>().onTapLogout().then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplashScreenPage(),
                        ),
                        (route) => false);
                  });
                },
                child: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

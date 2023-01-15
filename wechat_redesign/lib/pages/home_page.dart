import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/home_bloc.dart';
import 'package:wechat_redesign/resources/colors.dart';

enum BottomNavItem {
  Moment,
  Chat,
  Contant,
  Me,
  Setting,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) {
          return Scaffold(
            body: bloc.pages[bloc.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                bloc.changeIndex(value);
              },
              showUnselectedLabels: true,
              selectedItemColor: PRIMARY_COLOR,
              unselectedItemColor: Colors.grey,
              currentIndex: bloc.currentIndex,
              items: BottomNavItem.values.map((navigationBar) {
                return BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/${navigationBar.name}.png',
                    color: bloc.currentIndex == navigationBar.index
                        ? PRIMARY_COLOR
                        : Colors.grey,
                  ),
                  label: navigationBar.name,
                );
              }).toList(),
              // items: [
              //   BottomNavigationBarItem(
              //     icon: Image.asset(
              //       'assets/icons/moment.png',
              //       color: bloc.currentIndex == 0 ? PRIMARY_COLOR : Colors.grey,
              //     ),
              //     label: "Moment",
              //   ),
              //   BottomNavigationBarItem(
              //     icon: Image.asset(
              //       'assets/icons/chat.png',
              //       color: bloc.currentIndex == 1 ? PRIMARY_COLOR : Colors.grey,
              //     ),
              //     label: "Chat",
              //   ),
              //   BottomNavigationBarItem(
              //     icon: Image.asset(
              //       'assets/icons/contant.png',
              //       color: bloc.currentIndex == 2 ? PRIMARY_COLOR : Colors.grey,
              //     ),
              //     label: "Contant",
              //   ),
              //   BottomNavigationBarItem(
              //     icon: Image.asset(
              //       'assets/icons/me.png',
              //       color: bloc.currentIndex == 3 ? PRIMARY_COLOR : Colors.grey,
              //     ),
              //     label: "Me",
              //   ),
              //   BottomNavigationBarItem(
              //     icon: Image.asset(
              //       'assets/icons/setting.png',
              //       color: bloc.currentIndex == 4 ? PRIMARY_COLOR : Colors.grey,
              //     ),
              //     label: "Setting",
              //   ),
              // ],
            ),
          );
        },
      ),
    );
  }
}

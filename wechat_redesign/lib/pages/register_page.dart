import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/pages/splash_screen_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/blocs/register_bloc.dart';
import 'package:wechat_redesign/utils/extensions.dart';
import 'package:wechat_redesign/widgets/loading_view.dart';

enum GenderItem {
  Male,
  Female,
  Other,
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    Key? key,
    this.phone,
  }) : super(key: key);

  final String? phone;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterBloc(phoneNumber: phone),
      child: Selector<RegisterBloc, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) {
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: true,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MARGIN_LARGE_2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_LARGE_3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi !',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: TEXT_BIG,
                                ),
                              ),
                              SizedBox(
                                height: MARGIN_SMALL,
                              ),
                              Text(
                                'Create a new Account',
                                style: TextStyle(
                                  fontSize: TEXT_REGULAR,
                                  color: PRIMARY_COLOR.withOpacity(
                                    0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MARGIN_LARGE_2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_LARGE_3),
                          child: TextFieldNameView(),
                        ),
                        SizedBox(
                          height: MARGIN_LARGE_2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_LARGE_3),
                          child: Consumer<RegisterBloc>(
                              builder: (context, bloc, child) {
                            return DateOfBirthSection(
                              onTapDate: () {
                                _selectDate(context, bloc);
                              },
                              day: bloc.day,
                              month: bloc.month,
                              year: bloc.year,
                            );
                          }),
                        ),
                        SizedBox(
                          height: MARGIN_LARGE_2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_LARGE_3),
                          child: GenderSection(),
                        ),
                        SizedBox(
                          height: MARGIN_LARGE_2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_LARGE_3),
                          child: TextFieldEmailView(),
                        ),
                        SizedBox(
                          height: MARGIN_LARGE_2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_LARGE_3),
                          child: TextFieldPasswordView(),
                        ),
                        SizedBox(
                          height: MARGIN_LARGE_2,
                        ),
                        Selector<RegisterBloc, bool>(
                            selector: (context, bloc) => bloc.agreeTerm,
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: MARGIN_LARGE_3),
                                child: TermAndServiceView(
                                  value: value,
                                  onTapCheckBox: (value) {
                                    context.read<RegisterBloc>().setAgreeTerm();
                                  },
                                ),
                              );
                            }),
                        SizedBox(
                          height: MARGIN_LARGE_3,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                // navigateToScreen(context, const GetOtpPage());
                                var bloc = Provider.of<RegisterBloc>(context,
                                    listen: false);
                                bloc.onTapSignUp().then((value) {
                                  navigateToNextScreen(context);
                                }).onError((error, stackTrace) {
                                  showSnackBar(context, '$error');
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: PRIMARY_COLOR,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: MARGIN_LARGE,
                                  vertical: MARGIN_MEDIUM,
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: TEXT_REGULAR_2X,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MARGIN_LARGE,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 0,
                  child: Image.asset('assets/path.png'),
                ),
                Visibility(
                  visible: isLoading,
                  child: const LoadingView(),
                ),
              ],
            );
          }),
    );
  }

  void _selectDate(BuildContext context, RegisterBloc bloc) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      bloc.setDay('${picked.day}');
      bloc.setMonth('${picked.month}');
      bloc.setYear('${picked.year}');
    }
  }
}

void navigateToNextScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SplashScreenPage()),
      (route) => false);
}

class DateOfBirthSection extends StatelessWidget {
  const DateOfBirthSection({
    Key? key,
    this.day,
    this.month,
    this.year,
    required this.onTapDate,
  }) : super(key: key);

  final String? day;
  final String? month;
  final String? year;
  final Function onTapDate;
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterBloc>(builder: (context, bloc, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date of Birth"),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  onTapDate();
                },
                child: DateItemView(date: day),
              ),
              GestureDetector(
                onTap: () {
                  onTapDate();
                },
                child: DateItemView(date: month),
              ),
              GestureDetector(
                onTap: () {
                  onTapDate();
                },
                child: DateItemView(date: year),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class GenderSection extends StatelessWidget {
  const GenderSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterBloc>(builder: (context, bloc, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gender"),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Row(
            children: GenderItem.values.map((gender) {
              return GenderItemView(
                gender: gender,
                groupValue: bloc.groupValue,
                onTap: (value) {
                  bloc.setGroupValue(value);
                },
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}

class TextFieldPasswordView extends StatelessWidget {
  const TextFieldPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterBloc>(builder: (context, bloc, child) {
      return TextField(
        decoration: InputDecoration(
          labelText: 'Enter Your Password',
        ),
        onChanged: bloc.setPassword,
      );
    });
  }
}

class TextFieldNameView extends StatelessWidget {
  const TextFieldNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterBloc>(builder: (context, bloc, child) {
      return TextField(
        decoration: InputDecoration(
          labelText: 'Enter your Name',
        ),
        onChanged: bloc.setName,
      );
    });
  }
}

class TextFieldEmailView extends StatelessWidget {
  const TextFieldEmailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterBloc>(builder: (context, bloc, child) {
      return TextField(
        decoration: InputDecoration(
          labelText: 'Enter your Email',
        ),
        onChanged: bloc.setEmail,
      );
    });
  }
}

class TermAndServiceView extends StatelessWidget {
  const TermAndServiceView({
    Key? key,
    required this.value,
    required this.onTapCheckBox,
  }) : super(key: key);

  final bool value;
  final Function(bool) onTapCheckBox;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: value,
            onChanged: (value) {
              onTapCheckBox(value ?? true);
            }),
        Text(
          'Agree To Term And Service',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

class GenderItemView extends StatelessWidget {
  const GenderItemView({
    Key? key,
    required this.gender,
    required this.groupValue,
    required this.onTap,
  }) : super(key: key);

  final GenderItem gender;
  final int groupValue;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(gender.index);
      },
      child: Row(
        children: [
          Radio(
              value: gender.index,
              groupValue: groupValue,
              onChanged: (value) {
                onTap(gender.index);
              }),
          Text(
            '${gender.name}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ],
      ),
    );
  }
}

class DateItemView extends StatelessWidget {
  const DateItemView({
    Key? key,
    this.date,
  }) : super(key: key);

  final String? date;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        width: 80,
        padding: EdgeInsets.all(MARGIN_SMALL),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$date'),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

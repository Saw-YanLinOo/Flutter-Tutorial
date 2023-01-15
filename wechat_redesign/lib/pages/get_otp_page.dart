import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/get_otp_bloc.dart';
import 'package:wechat_redesign/pages/register_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/utils/extensions.dart';
import 'package:wechat_redesign/widgets/loading_view.dart';

class GetOtpPage extends StatelessWidget {
  const GetOtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetOtpBloc(),
      child: Selector<GetOtpBloc, bool>(
        selector: (p0, p1) => p1.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: true,
              ),
              body: Consumer<GetOtpBloc>(builder: (context, bloc, child) {
                return SingleChildScrollView(
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
                            const Text(
                              'Hi !',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: TEXT_BIG,
                              ),
                            ),
                            const SizedBox(
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
                        height: MARGIN_LARGE,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Image.asset('assets/get_otp.png')),
                      ),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_LARGE_3),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Enter your Phone Number',
                                    ),
                                    onChanged: bloc.onChangedPhone,
                                  ),
                                ),
                                SizedBox(
                                  width: MARGIN_MEDIUM,
                                ),
                                TextButton(
                                  onPressed: () {
                                    //navigateToScreen(context, const GetOtpPage());
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: PRIMARY_COLOR,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: MARGIN_MEDIUM,
                                      vertical: MARGIN_MEDIUM,
                                    ),
                                    child: Text(
                                      'Get OTP',
                                      style: TextStyle(
                                        fontSize: TEXT_REGULAR,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MARGIN_LARGE,
                            ),
                            SizedBox(
                              width: 200,
                              child: PinCodeTextField(
                                appContext: context,
                                length: 4,
                                onChanged: bloc.onChangedCode,
                                enableActiveFill: true,
                                cursorColor: Colors.grey,
                                cursorHeight: 10,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 40,
                                  fieldWidth: 30,
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  activeFillColor: Colors.white,
                                  inactiveColor: Colors.white,
                                  selectedColor: Colors.white,
                                  activeColor: Colors.white,
                                ),
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MARGIN_MEDIUM_2,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't received the OTP?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: MARGIN_SMALL,
                                ),
                                Text(
                                  "Resend Code",
                                  style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_LARGE_3,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              bloc.onTapVerify().then((value) {
                                navigateToScreen(
                                    context, RegisterPage(phone: bloc.phone));
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
                                'Verify',
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
                    ],
                  ),
                );
              }),
            ),
            Visibility(
              visible: isLoading,
              child: const LoadingView(),
            ),
          ],
        ),
      ),
    );
  }
}

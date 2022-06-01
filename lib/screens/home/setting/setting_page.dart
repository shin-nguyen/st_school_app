import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/account_menu_json.dart';
import 'package:st_school_app/providers/auth_notifier.dart';
import 'package:st_school_app/providers/password_repository.dart';
import 'package:st_school_app/screens/home/setting/components/licenses_custom_page.dart';
import 'package:st_school_app/widgets/custom_button.dart';
import 'package:st_school_app/widgets/custom_button_box.dart';
import 'package:st_school_app/widgets/custom_place_holder.dart';
import 'package:st_school_app/widgets/custom_title.dart';
import 'package:st_school_app/widgets/input_field.dart';
import 'package:st_school_app/widgets/password_bloc.dart';
import 'package:st_school_app/widgets/password_event.dart';
import 'package:st_school_app/widgets/password_state.dart';

class SettingPage extends StatefulWidget {
  static String routeName = "/setting";

  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  Future<void> _showAlertDialog(
      BuildContext context, String title, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearPasswordFields() {
    _currentPasswordController.text = '';
    _newPasswordController.text = '';
    _repeatPasswordController.text = '';
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    var passwordBloc = PasswordBloc(passwordRepository: PasswordRepository());

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34), topRight: Radius.circular(34)),
        ),
        builder: (BuildContext context) => BlocProvider<PasswordBloc>(
              create: (context) => passwordBloc,
              child: BlocBuilder<PasswordBloc, PasswordState>(
                  bloc: passwordBloc,
                  builder: (context, state) {
                    if (state is PasswordChangedState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // close bottom sheet
                        Navigator.pop(context);

                        _showAlertDialog(context, 'Success',
                            'Password changed successfully');

                        clearPasswordFields();
                      });
                    } else if (state is ChangePasswordErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showAlertDialog(context, 'Error', state.errorMessage);
                      });
                    }

                    return Container(
                      height: 472,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(34),
                              topRight: Radius.circular(34)),
                          boxShadow: []),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 6,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Color(0xFF9B9B9B),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Password Change',
                              style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            OpenFlutterInputField(
                              controller: _currentPasswordController,
                              hint: 'Old Password',
                              error: state is EmptyCurrentPasswordState
                                  ? 'field cannot be empty'
                                  : state is IncorrectCurrentPasswordState
                                      ? 'incorrect current password'
                                      : null,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Color(0xFF9B9B9B)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            OpenFlutterInputField(
                              controller: _newPasswordController,
                              hint: 'New Password',
                              error: state is EmptyNewPasswordState
                                  ? 'field cannot be empty'
                                  : state is InvalidNewPasswordState
                                      ? 'password should be at least 6 characters'
                                      : null,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            OpenFlutterInputField(
                              controller: _repeatPasswordController,
                              hint: 'Repeat New Password',
                              error: state is EmptyRepeatPasswordState
                                  ? 'field cannot be empty'
                                  : state is PasswordMismatchState
                                      ? 'password mismatch'
                                      : null,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            OpenFlutterButton(
                                title: 'Save Password',
                                height: 48,
                                onPressed: () => passwordBloc.add(
                                    ChangePasswordEvent(
                                        currentPassword:
                                            _currentPasswordController.text
                                                .trim(),
                                        newPassword:
                                            _newPasswordController.text.trim(),
                                        repeatNewPassword:
                                            _repeatPasswordController.text
                                                .trim())))
                          ],
                        ),
                      ),
                    );
                  }),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        children: [
          const SizedBox(height: spacer - 1.0),
          Column(
            children: List.generate(accountMenuJson.length, (indexTitle) {
              List data = accountMenuJson[indexTitle]['categories'];
              return Padding(
                padding: const EdgeInsets.only(bottom: spacer),
                child: Column(
                  children: [
                    CustomTitle(
                      title: accountMenuJson[indexTitle]['title'],
                      extend: false,
                    ),
                    const SizedBox(height: smallSpacer),
                    Column(
                      children: List.generate(data.length, (indexSubTitle) {
                        return CunstomPlaceHolder(
                          title: data[indexSubTitle]['title'],
                          isSwitch: data[indexSubTitle]['isSwitch'],
                          onTap: () {
                            if (accountMenuJson[indexTitle]['title'] ==
                                'Support') {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LicensesCustomPage(
                                    title: data[indexSubTitle]['title'],
                                    file: data[indexSubTitle]['file']),
                              ));
                            }
                          },
                        );
                      }),
                    )
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: miniSpacer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () {
                  _showChangePasswordBottomSheet(context);
                },
                child: Text(
                  'Change',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9B9B9B),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: miniSpacer),
          GestureDetector(
            onTap: () {
              final auth = Provider.of<AuthNotifier>(context, listen: false);
              auth.logout();

              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const CustomButtonBox(title: 'Log out'),
          ),
        ],
      ),
    );
  }
}

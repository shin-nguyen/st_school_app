import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/widgets/custom_surfix_icon.dart';
import 'package:st_school_app/widgets/default_button.dart';
import 'package:st_school_app/widgets/form_error.dart';

import '../../../providers/auth.dart';
import '../../../providers/user.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

  User _editedUser = new User(
    id: 0,
    address: '',
    firstName: '',
    lastName: '',
    phone: '',
  );

  var _initValues = {
    'address': '',
    'firstName': '',
    'lastName': '',
    'phone': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      String? token = Provider.of<Auth>(context, listen: false).token;

      Provider.of<User>(context).getInfoByToken(token!).then((_) {
        setState(() {
          _isLoading = false;
        });

        _editedUser = Provider.of<User>(context).user!;

        _initValues = {
          'address': _editedUser.address,
          'firstName': _editedUser.firstName,
          'lastName': _editedUser.lastName,
          'phone': _editedUser.phone,
        };
      });

      // _imageUrlController.text = _editedProduct.imageUrl;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    String? token = Provider.of<Auth>(context, listen: false).token;

    await Provider.of<User>(context, listen: false).updateProduct(
        token!,
        User(
            id: 0,
            firstName: firstName!,
            lastName: lastName!,
            phone: phoneNumber!,
            address: address!));
    setState(() {
      _isLoading = false;
    });
    // Navigator.of(context).pop();
    // // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: Column(
              children: [
                buildFirstNameFormField(),
                SizedBox(height: (30)),
                buildLastNameFormField(),
                SizedBox(height: (30)),
                buildPhoneNumberFormField(),
                SizedBox(height: (30)),
                buildAddressFormField(),
                FormError(errors: errors),
                SizedBox(height: (40)),
                DefaultButton(
                  text: "continue",
                  press: () {
                    _saveForm();
                  },
                ),
              ],
            ),
          );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      initialValue: _initValues['address'],
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      initialValue: _initValues['phone'],
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      initialValue: _initValues['lastName'],
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      initialValue: _initValues['firstName'],
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}

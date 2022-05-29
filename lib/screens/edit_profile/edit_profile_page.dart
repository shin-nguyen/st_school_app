import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/user.dart';
import 'package:st_school_app/providers/user_notifier.dart';
import 'package:st_school_app/utils/valid.dart';
import 'package:st_school_app/widgets/large_buttons.dart';
import 'package:st_school_app/widgets/text_field.dart';
import 'package:st_school_app/widgets/profile_image.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static const routeName = '/edit-profile';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _aboutFocusNode = FocusNode();

  // final _imageUrlController = TextEditingController();
  // final _imageUrlFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;

  var _editedProfile = User(
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    address: '',
    about: '',
    avatar: '',
    id: -1,
  );

  var _initValues = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'phone': '',
    'address': '',
    'about': '',
    'avatar': '',
  };

  //  @override
  // void initState() {
  //   _imageUrlFocusNode.addListener(_updateImageUrl);
  //   super.initState();
  // }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _editedProfile =
          Provider.of<UserNotifier>(context, listen: false).getUser;
      _initValues = {
        'firstName': _editedProfile.firstName,
        'lastName': _editedProfile.lastName,
        'email': _editedProfile.email,
        'phone': _editedProfile.phone,
        'address': _editedProfile.address,
        'about': _editedProfile.about,
        'avatar': _editedProfile.avatar,
      };

      final LostData response = await _picker.getLostData();
      if (response.isEmpty) {
        return;
      }
      if (response.file != null) {
        debugPrint('Set Image File');
        setState(() {
          _imageFile = response.file;
        });
      } else {
        debugPrint('Retrieve error ' + response.exception!.code);
      }

      // _imageUrlController.text = _editedProduct.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _imageUrlFocusNode.removeListener(_updateImageUrl);
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    _aboutFocusNode.dispose();
    // _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<UserNotifier>(context, listen: false)
          .updateInfo(_editedProfile, _imageFile?.path);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occurred!'),
          content: const Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      // print("Image picker error " + e);
    }
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserNotifier>(context);
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(appPadding),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: spacer),
                    Center(
                      child: Stack(
                        children: [
                          ClipOval(
                            child: _imageFile == null
                                ? Material(
                                    color: Colors.transparent,
                                    child: Ink.image(
                                      image: NetworkImage(user.getUser.avatar),
                                      fit: BoxFit.cover,
                                      width: 128,
                                      height: 128,
                                      child: InkWell(
                                        onTap: _pickImage,
                                      ),
                                    ),
                                  )
                                : Material(
                                    color: Colors.transparent,
                                    child: Ink.image(
                                      image: FileImage(File(_imageFile!.path)),
                                      fit: BoxFit.cover,
                                      width: 128,
                                      height: 128,
                                      child: InkWell(
                                        onTap: _pickImage,
                                      ),
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: buildEditIcon(color),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "First Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _initValues['firstName'],
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 10.0,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_firstNameFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProfile = User(
                              firstName: value!,
                              about: _editedProfile.about,
                              address: _editedProfile.address,
                              email: _editedProfile.email,
                              lastName: _editedProfile.lastName,
                              avatar: _editedProfile.avatar,
                              phone: _editedProfile.phone,
                              id: _editedProfile.id,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Last Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _initValues['lastName'],
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 10.0,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_firstNameFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedProfile = User(
                              firstName: _editedProfile.firstName,
                              about: _editedProfile.about,
                              address: _editedProfile.address,
                              email: _editedProfile.email,
                              lastName: value!,
                              avatar: _editedProfile.avatar,
                              phone: _editedProfile.phone,
                              id: _editedProfile.id,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Email',
                      text: user.getUser.email,
                      onChanged: (email) {},
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Phone",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _initValues['phone'],
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 10.0,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_firstNameFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            if (!isValidPhoneNumber(value)) {
                              return 'Please provide phone number';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedProfile = User(
                              firstName: _editedProfile.firstName,
                              about: _editedProfile.about,
                              address: _editedProfile.address,
                              email: _editedProfile.email,
                              lastName: _editedProfile.lastName,
                              avatar: _editedProfile.avatar,
                              phone: value!,
                              id: _editedProfile.id,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _initValues['about'],
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: null,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 10.0,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_firstNameFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProfile = User(
                                firstName: _editedProfile.firstName,
                                about: value!,
                                address: _editedProfile.address,
                                email: _editedProfile.email,
                                lastName: _editedProfile.lastName,
                                avatar: _editedProfile.avatar,
                                phone: _editedProfile.phone,
                                id: _editedProfile.id);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AppLargeButton(
                      text: "Done",
                      backgroundColor: Colors.white,
                      textColor: secondary,
                      onTap: _saveForm,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// form key for [FormBuilder]
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;
  bool _isRegister = false;
  bool _isOnBoarding = true;

  @override
  void initState() {
    _isPasswordVisible = false;
    _isRegister = false;
    _isOnBoarding = true;
    super.initState();
  }

  @override
  void dispose() {
    _isPasswordVisible = false;
    _isRegister = false;
    _isOnBoarding = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// onboarding ui
        if (_isOnBoarding)
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              // color: BrandColors.kBGreenColor,
              color: BrandColors.kBrandGreenColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Assets.imagesBus,
                  width: 250.0,
                ),
                const Gap(50.0),
                CustomButton(
                  text: "Login".toUpperCase(),
                  width: MediaQuery.of(context).size.width * 0.57,
                  letterSpacing: 1.5,
                  buttonColor: BrandColors.kBlue,
                  onPressed: () {
                    setState(() {
                      _isOnBoarding = false;
                      _isRegister = false;
                    });
                  },
                ),
                const Gap(15.0),
                CustomButton(
                  text: "Register".toUpperCase(),
                  width: MediaQuery.of(context).size.width * 0.57,
                  letterSpacing: 1.5,
                  buttonColor: BrandColors.menuBackground,
                  onPressed: () {
                    setState(() {
                      _isOnBoarding = false;
                      _isRegister = true;
                    });
                  },
                ),
              ],
            ),
          ),

        /// authentication flow ui
        if (!_isOnBoarding)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesBusOne),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        if (!_isOnBoarding)
          AnimatedContainer(
            duration: const Duration(
              seconds: 5,
            ),
            curve: Curves.easeIn,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.27,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: _isRegister ? _registerForm() : _loginForm(),
          )
      ],
    );
  }

  /// [Register] form
  Widget _registerForm() {
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Gap(10.0),
              CustomText(
                "Register".toUpperCase(),
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
              const Gap(8.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.38),
                child: const BrandDivider(),
              ),
              const Gap(20.0),
              FormBuilderTextField(
                name: 'first_name',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const Gap(10.0),
              FormBuilderTextField(
                name: 'last_name',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const Gap(10.0),
              FormBuilderTextField(
                name: 'email',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const Gap(10.0),
              FormBuilderTextField(
                name: 'password',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible ? LineAwesomeIcons.eye_slash : LineAwesomeIcons.eye,
                    ),
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              const Gap(10.0),
              FormBuilderTextField(
                name: 'confirm_password',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: (_formKey.currentState?.fields['confirm_password']?.hasError ?? false)
                      ? const Icon(LineAwesomeIcons.info_circle, color: Colors.red)
                      : const Icon(LineAwesomeIcons.check_circle, color: Colors.green),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) => _formKey.currentState?.fields['password']?.value != value ? 'No coinciden' : null,
              ),
              const Gap(10.0),
              FormBuilderFieldDecoration<bool>(
                name: 'agree_terms',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.equal(true),
                ]),
                // initialValue: true,
                decoration: const InputDecoration(
                  labelText: 'Accept Terms?',
                  border: InputBorder.none,
                ),
                builder: (FormFieldState<bool?> field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      errorText: field.errorText,
                      border: InputBorder.none,
                    ),
                    child: SwitchListTile(
                      title: const Text('I have read and accepted the terms of service.'),
                      onChanged: field.didChange,
                      value: field.value ?? false,
                    ),
                  );
                },
              ),
              const Gap(20.0),

              /// register button
              CustomButton(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.38,
                buttonColor: Theme.of(context).colorScheme.primary,
                onPressed: () async {
                  // debugPrint("Hello world");

                  bool? isFormValid = _formKey.currentState?.saveAndValidate();
                  if (isFormValid == true) {
                    // debugPrint("Variables >>>>>> ${_formKey.currentState?.value.toString()}");
                    Map<String, dynamic> variables = {
                      "firstName": _formKey.currentState?.fields['first_name']?.value,
                      "lastName": _formKey.currentState?.fields['last_name']?.value,
                      "email": _formKey.currentState?.fields['email']?.value,
                      "password": _formKey.currentState?.fields['password']?.value,
                      "avatar": ProjectVariables.defaultUserIcon,
                    };

                    /// authentication logic
                    final UserModel user = UserModel.fromJson(variables);

                    /// create Database reference
                    final Database db = await DatabaseHelper.instance.database;
                    int id = await db.insert('users', user.toJson());

                    // debugPrint("new entry id >>>>>>>>>>> $id");

                    final List<Map<String, Object?>> userMapList = await db.query(
                      'users',
                      where: 'id = ?',
                      whereArgs: [id],
                    );

                    if (!mounted) return;
                    if (userMapList.isEmpty) {
                      showCustomFlushBar(
                        context: context,
                        messageText: "There was an error setting things up for you",
                      );
                      return;
                    }
                    final UserModel userModel = UserModel.fromJson(userMapList.first);
                    userController.updateUser(userModel);

                    // debugPrint("response id >>> : $id");
                    FocusScope.of(context).unfocus();
                    // clear form
                    _formKey.currentState?.reset();
                    context.go(routerHomeLocation);
                  } else {
                    debugPrint("Some value is not provided");
                  }
                },
                child: CustomText(
                  'Signup'.toUpperCase(),
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),

              /// login button
              const Gap(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // already have an account
                  CustomText(
                    'Already have an account?',
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),

                  /// [Login] button
                  InkWell(
                    onTap: () {
                      /// clear form
                      _formKey.currentState?.reset();
                      setState(() {
                        _isRegister = false;
                      });
                    },
                    child: CustomText(
                      'Login'.toUpperCase(),
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const Gap(20.0),
            ],
          ),
        ),
      ),
    );
  }

  /// [Login] form
  Widget _loginForm() {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Gap(10.0),
              CustomText(
                "Login".toUpperCase(),
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
              const Gap(8.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.38),
                child: const BrandDivider(),
              ),
              const Gap(20.0),
              FormBuilderTextField(
                name: 'email',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const Gap(10.0),
              FormBuilderTextField(
                name: 'password',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible ? LineAwesomeIcons.eye_slash : LineAwesomeIcons.eye,
                    ),
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              const Gap(30.0),
              CustomButton(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.38,
                buttonColor: Theme.of(context).colorScheme.primary,
                onPressed: () async {
                  bool? isFormValid = _formKey.currentState?.saveAndValidate();
                  if (isFormValid == true) {
                    // debugPrint(_formKey.currentState?.value.toString());
                    Map<String, dynamic> variables = {
                      "email": _formKey.currentState?.fields['email']?.value,
                      "password": _formKey.currentState?.fields['password']?.value,
                    };

                    /// authentication logic

                    /// create Database reference
                    final Database db = await DatabaseHelper.instance.database;
                    final List<Map<String, Object?>> userMapList = await db.query(
                      'users',
                      where: 'email = ?',
                      whereArgs: [variables['email']],
                    );

                    if (!mounted) return;

                    if (userMapList.isEmpty) {
                      showCustomFlushBar(
                        context: context,
                        messageText: "No record found for this email",
                      );
                      return;
                    }
                    final UserModel user = UserModel.fromJson(userMapList.first);
                    userController.updateUser(user);

                    debugPrint("response: ${userController.currentUser}");
                    FocusScope.of(context).unfocus();
                    // clear form
                    _formKey.currentState?.reset();
                    userController.getLoggedInUserId();
                    context.go(routerHomeLocation);
                  }
                },
                child: CustomText(
                  'Sign In'.toUpperCase(),
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),

              /// register button
              const Gap(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // already have an account
                  CustomText(
                    "Don't have an account?",
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),

                  /// [Login] button
                  InkWell(
                    onTap: () {
                      /// clear form
                      _formKey.currentState?.reset();
                      setState(() {
                        _isRegister = true;
                      });
                    },
                    child: CustomText(
                      'Register'.toUpperCase(),
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

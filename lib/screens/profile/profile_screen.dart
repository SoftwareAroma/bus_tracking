import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDataLoading = true;

  /// form key for [FormBuilder]
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    _isDataLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userController.getLoggedInUserId(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          _isDataLoading = false;
          return Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: <Widget>[
                        Obx(
                          () => OpaqueImage(
                            imageUrl: userController.currentUser?.avatar ?? ProjectVariables.defaultUserIcon,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                AppStrings.profileTitle.toUpperCase(),
                                fontSize: 22.0,
                                textAlign: TextAlign.center,
                                color: BrandColors.kColorWhiteAccent,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                              const Gap(10.0),
                              const PersonalInfo(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// details
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(top: 70.0),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CustomText(
                                        AppStrings.eventsTitle.toUpperCase(),
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.6,
                                      ),

                                      /// add event button
                                      CustomButton(
                                        width: 120.0,
                                        text: "add event".capitalize,
                                        fontSize: 16.0,
                                        buttonColor: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                                elevation: 0.0,
                                                backgroundColor: Colors.white,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 15.0,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        const CustomText(
                                                          "Add Event",
                                                          fontSize: 22.0,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                        const Gap(15.0),
                                                        FormBuilder(
                                                          key: _formKey,
                                                          child: Column(
                                                            children: <Widget>[
                                                              FormBuilderTextField(
                                                                name: 'title',
                                                                textInputAction: TextInputAction.next,
                                                                keyboardType: TextInputType.text,
                                                                decoration: const InputDecoration(
                                                                  labelText: 'Event Title',
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
                                                                name: 'description',
                                                                maxLines: 15,
                                                                minLines: 3,
                                                                textInputAction: TextInputAction.next,
                                                                keyboardType: TextInputType.text,
                                                                decoration: const InputDecoration(
                                                                  labelText: 'Event Description',
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
                                                              FormBuilderDateTimePicker(
                                                                name: 'time',
                                                                textInputAction: TextInputAction.next,
                                                                keyboardType: TextInputType.text,
                                                                decoration: const InputDecoration(
                                                                  labelText: 'Event Time',
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
                                                              const Gap(20.0),

                                                              /// add button
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
                                                                      "title": _formKey.currentState?.fields['title']?.value,
                                                                      "description": _formKey.currentState?.fields['description']?.value,
                                                                      "time": _formKey.currentState?.fields['time']?.value.toString(),
                                                                    };

                                                                    /// authentication logic
                                                                    final EventModel event = EventModel.fromJson(variables);

                                                                    /// create Database reference
                                                                    final Database db = await DatabaseHelper.instance.database;
                                                                    int id = await db.insert('events', event.toJson());
                                                                    debugPrint("new entry id >>>>>>>>>>> $id");

                                                                    userController.getEvents();

                                                                    if (!mounted) return;

                                                                    // debugPrint("response id >>> : $id");
                                                                    FocusScope.of(context).unfocus();
                                                                    // clear form
                                                                    _formKey.currentState?.reset();
                                                                    context.pop();
                                                                  } else {
                                                                    debugPrint("Some value is not provided");
                                                                  }
                                                                },
                                                                child: CustomText(
                                                                  'Submit'.toUpperCase(),
                                                                  color: Theme.of(context).colorScheme.onPrimary,
                                                                  fontSize: 16.0,
                                                                  fontWeight: FontWeight.w600,
                                                                  letterSpacing: 1.5,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  BrandDivider(color: BrandColors.kColorDefaultDivider),
                                  const SizedBox(height: 20.0),
                                  Expanded(
                                    child: Obx(
                                      () => ListView.separated(
                                        itemCount: userController.currentUser?.events?.length ?? 0,
                                        itemBuilder: (BuildContext context, int index) {
                                          EventModel eventModel = userController.currentUser!.events![index];
                                          if (userController.currentUser == null) {
                                            return Container();
                                          }
                                          return _isDataLoading
                                              ? const SkeletonLoader(isEnabled: true)
                                              : Card(
                                                  shadowColor: Colors.black12,
                                                  margin: EdgeInsets.zero,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Dismissible(
                                                            key: Key(index.toString()),

                                                            /// on dismissed
                                                            onDismissed: (direction) async {
                                                              // Remove the item from the data source.
                                                              final Database db = await DatabaseHelper.instance.database;
                                                              int resp = await db.delete(
                                                                'events',
                                                                where: 'id = ?',
                                                                whereArgs: [eventModel.id!],
                                                              );

                                                              debugPrint("resp $resp");
                                                              if (!mounted) return;

                                                              /// show a flushbar
                                                              showCustomFlushBar(
                                                                context: context,
                                                                messageText: "Event Deleted",
                                                              );
                                                              userController.getEvents();
                                                              setState(() {});
                                                            },
                                                            child: ListTile(
                                                              title: CustomText(
                                                                eventModel.title ?? "",
                                                                fontWeight: FontWeight.w800,
                                                                fontSize: 18.0,
                                                              ),
                                                              subtitle: CustomText(
                                                                eventModel.description ?? "",
                                                                maxLines: 15,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              trailing: CustomText(
                                                                HelperFunctions.getTimeFromString(eventModel.time.toString()),
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return const Gap(10.0);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              /// progress fill
              Positioned(
                top: MediaQuery.of(context).size.height * (3 / 8) - 130 / 2,
                left: 16.0,
                right: 16.0,
                child: SizedBox(
                  height: 80.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ProfileInfoCard(
                        firstText: "84%",
                        secondText: AppStrings.successTitle.toUpperCase(),
                      ),
                      const Gap(10.0),
                      const ProfileInfoCard(
                        hasImage: true,
                        imagePath: Assets.imagesPulse,
                      ),
                      const Gap(10.0),
                      Obx(
                        () => ProfileInfoCard(
                          firstText: userController.currentUser?.events?.length.toString() ?? "0",
                          secondText: AppStrings.eventsTitle.toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CustomText(
                  'No user logged in',
                  fontSize: 22.0,
                ),
                const Gap(10.0),
                CustomButton(
                  text: 'log in'.toUpperCase(),
                  height: 50.0,
                  width: 200.0,
                  buttonColor: Theme.of(context).primaryColor,
                  fontSize: 22.0,
                  onPressed: () {
                    context.go(routerAuthLocation);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

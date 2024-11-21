import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/helpers/image_processors.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/utils/urls.dart';
import 'package:parish_aid_admin/core/widgets/general_widgets.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_state.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_event.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_state.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../../../group/data/model/group_model.dart';
import '../../../home/data/model/parish_model.dart' as pModel;
import '../../../lga/app/bloc/lga_bloc.dart';
import '../../../lga/app/bloc/lga_event.dart';
import '../../../lga/app/bloc/lga_state.dart';
import '../../../lga/data/models/lga_model.dart';
import '../../../state/app/bloc/state_bloc.dart';
import '../../../state/app/bloc/state_event.dart';
import '../../../state/app/bloc/state_state.dart';
import '../../../state/data/models/state_model.dart';
import '../widget/my_input_field.dart';

class CreateParishionerPage extends StatefulWidget {
  const CreateParishionerPage({Key? key, this.profilePicture})
      : super(key: key);

  final String? profilePicture;

  @override
  State<CreateParishionerPage> createState() => _CreateParishionerPageState();
}

class _CreateParishionerPageState extends State<CreateParishionerPage> {
  StateModel? data;
  StateData? selectedState;
  LgaData? selectedLga;
  LgaModel? lgaModel;
  GroupModel? groupModel;
  pModel.ParishModel? parishModel;
  pModel.ParishData? selectedParish;
  GroupData? selectedGroup;

  bool fetchStateLoading = false;
  bool fetchParishLoading = false;
  bool fetchGroupsLoading = false;
  bool fetchLgaLoading = false;
  bool fetchStateError = false;
  bool fetchParishError = false;
  bool fetchGroupsError = false;
  bool fetchLgaError = false;

  bool createParishionerLoading = false;
  bool createParishionerError = false;

  //error message
  String errorText = "";

  //Success message
  String msg = "";

  String stateValue = "Select a State";
  String groupValue = "Select your Group";
  String parishValue = "Select your Parish";
  String lgaValue = 'Select a Local Government Area';
  String _selectedGender = "Select your gender";

  final List<String> _selectedGenderList = [
    "Select your gender",
    "Male",
    "Female",
  ];
  DateFormat df = DateFormat("yyyy-MM-dd");
  DateTime _selectedDate = DateTime.now();

  String? profileImage;
  String name = "";
  String email = "";
  String phoneNo = "";
  String whatsAppNo = "";
  String employmentStatus = "";
  String address = "";
  String employerName = "";
  String school = "";
  int? stateId;
  int? lgaId;
  String town = "";
  String parishId = "";
  String groupId = "";

  @override
  void initState() {
    super.initState();
    profileImage = widget.profilePicture;
    getStates();
    fetchAllParish();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<StateBloc, StateState>(builder: (context, state) {
      if (state is GetStatesLoading) {
        fetchStateLoading = true;
        fetchStateError = false;
        errorText = "";
      } else if (state is GetStatesLoaded) {
        data = state.stateModel;
        if (data != null) {
          fetchStateError = false;
          fetchStateLoading = false;
        }
      } else if (state is GetStatesError) {
        fetchStateLoading = false;
        fetchStateError = false;
        errorText = state.failure.message;
        Navigator.pop(context);
      }
      return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is GetParishesLoading) {
          fetchParishLoading = true;
          fetchParishError = false;
          errorText = "";
        } else if (state is GetParishesLoaded) {
          parishModel = state.parishModel;
          if (parishModel != null) {
            fetchParishError = false;
            fetchParishLoading = false;
          }
        } else if (state is GetParishesError) {
          fetchParishLoading = false;
          fetchParishError = true;
          errorText = state.failure.message;
          Navigator.pop(context);
        }
        return BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
          if (state is GetGroupsLoading) {
            fetchGroupsLoading = true;
            fetchGroupsError = false;
          } else if (state is GetGroupsLoaded) {
            groupModel = state.groupModel;
            fetchGroupsLoading = false;
            fetchGroupsError = false;
          } else if (state is GetGroupsError) {
            fetchGroupsError = true;
            fetchGroupsLoading = false;
            errorText = state.failure.message;
          }
          return BlocBuilder<LgaBloc, LgaState>(builder: (context, state) {
            if (state is LgaLoading) {
              fetchLgaLoading = true;
              fetchLgaError = false;
            } else if (state is LgaLoaded) {
              lgaModel = state.lgaModel;
              fetchLgaLoading = false;
              fetchLgaError = false;
            } else if (state is LgaError) {
              fetchLgaError = true;
              fetchLgaLoading = false;
              errorText = state.failure.message;
            }

            return BlocBuilder<ParishionerBloc, ParishionerState>(
                builder: (context, state) {
              if (state is CreateParishionerLoading) {
                createParishionerLoading = true;
                createParishionerError = false;
                errorText = "";
              } else if (state is CreateParishionerLoaded) {
                createParishionerLoading = false;
                createParishionerError = false;
                errorText = "";
                toastInfo(msg: state.parishionerModel.response!.message!);
                if (context.mounted) {
                  Future.delayed(const Duration(seconds: 1))
                      .then((value) => {Navigator.pop(context)});
                }
              } else if (state is CreateParishionerError) {
                createParishionerLoading = false;
                createParishionerError = true;
                errorText = state.failure.message;
              }
              return fetchStateLoading || fetchParishLoading
                  ? Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900.withOpacity(0.8),
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Scaffold(
                        //appBar: appBar(''),

                        body: buildRegisterWidget(size),
                      ),
                    );
            });
          });
        });
      });
    });
  }

  Widget buildRegisterWidget(Size size) {
    return SafeArea(
        child: SizedBox(
            height: size.height,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Urls.defaultBackgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.blue.shade900.withOpacity(0.6),
              ),
              const SizedBox(height: 65),
              //card and footer ui
              Center(
                  child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          alignment: Alignment.center,
                          width: size.width * 0.9,
                          height: size.height * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          CircleAvatar(
                                            radius: 60.0,
                                            backgroundColor: Colors.white,
                                            child: !profileImage.isEmptyOrNull
                                                ? loadCircularImageWidget(
                                                    profileImage!,
                                                  )
                                                : const Icon(
                                                    Icons.person,
                                                    color: Colors.grey,
                                                    size: 80,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //logo & text
                                  logo(size.height / 10, size.height / 6),
                                  SizedBox(
                                    height: size.height * 0.00,
                                  ),
                                  buildInputFields(
                                      size, false, "", "Enter your name", false,
                                      (value) {
                                    name = value;
                                  }),
                                  //const SizedBox(height: ,),
                                  buildInputFields(size, false, "",
                                      "Enter your email", false, (value) {
                                    email = value;
                                  }),
                                  buildInputFields(
                                      size,
                                      false,
                                      "",
                                      "Enter your phone number",
                                      false, (value) {
                                    phoneNo = value;
                                  }),
                                  buildInputFields(
                                      size,
                                      false,
                                      "",
                                      "Enter your whatsApp number",
                                      false, (value) {
                                    whatsAppNo = value;
                                  }),
                                  buildInputFields(
                                      size,
                                      false,
                                      "",
                                      "Enter your employer status",
                                      false, (value) {
                                    employmentStatus = value;
                                  }),
                                  buildInputFields(
                                      size,
                                      false,
                                      "",
                                      "Enter your employer name",
                                      false, (value) {
                                    employerName = value;
                                  }),
                                  buildInputFields(size, false, "",
                                      "Enter your address", false, (value) {
                                    address = value;
                                  }),
                                  buildInputFields(
                                      size, false, "", "Enter your town", false,
                                      (value) {
                                    town = value;
                                  }),
                                  buildInputFields(size, false, "",
                                      "Enter your school name", false, (value) {
                                    school = value;
                                  }),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  buildParishesDropDownButton(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  groupModel == null
                                      ? const Center()
                                      : buildGroupDropDownButton(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  buildStateDropDownButton(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  lgaModel == null
                                      ? const SizedBox()
                                      : buildLgaDropDownButton(),
                                  lgaModel !=null?
                                      const SizedBox(height: 16):const SizedBox(),
                                  MyInputField(
                                    title: "Dob",
                                    hint: df.format(_selectedDate),
                                    widget: IconButton(
                                        onPressed: () {
                                          _getDateFromUser();
                                        },
                                        icon: const Icon(
                                            Icons.calendar_today_outlined),
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 22),
                                  buildGenderDropDownButton(),
                                  const SizedBox(height: 16),
                                  buildFooter(size),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),

                                  //sign in button
                                  Visibility(
                                    visible: true,
                                    child: GestureDetector(
                                      onTap: () {
                                        createParishioner();
                                      },
                                      child: Stack(
                                        children: [
                                          triggerActionButtonBlue(
                                              size, "Register"),
                                          Positioned(
                                            bottom: 15,
                                            left: 90,
                                            child: Visibility(
                                              visible: createParishionerLoading,
                                              child: buildLoadingIndicator(
                                                  color: Colors.grey
                                                      .withOpacity(0.8)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.04,
                                  ),
                                ]),
                          ))
                    ]),
              ))
            ])));
  }

  Widget buildStateDropDownButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black.withOpacity(0.1))),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton2<StateData>(
                      onChanged: (stateData) {
                        setState(() {
                          stateId = stateData!.id;
                          stateValue = stateData.name!;
                        });
                        getLgas(stateId!);

                        BlocBuilder<LgaBloc, LgaState>(
                            builder: (context, state) {
                          if (state is LgaLoading) {
                            fetchLgaLoading = true;
                            fetchLgaError = false;
                          } else if (state is LgaLoaded) {
                            lgaModel = state.lgaModel;
                            fetchLgaLoading = false;
                            fetchLgaError = false;
                          } else if (state is LgaError) {
                            fetchLgaError = true;
                            fetchLgaLoading = false;
                            errorText = state.failure.message;
                          }
                          return Container();
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        isOverButton: true,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3))
                            ]),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      key: const ValueKey('States'),
                      value: selectedState,
                      isExpanded: true,
                      hint: Text(stateValue),
                      items: [
                    ...data!.response!.data!
                        .map((e) => DropdownMenuItem<StateData>(
                              value: e,
                              child: Text(e.name!,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    color: Colors.black87,
                                    height: 1.0,
                                  )),
                            ))
                  ])))
        ]);
  }

  Widget buildParishesDropDownButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black.withOpacity(0.1))),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton2<pModel.ParishData>(
                      onChanged: (parishData) {
                        setState(() {
                          parishId = parishData!.id.toString();
                          parishValue = parishData.name!;
                          pp("The parish id is $parishId");
                          pp("The parish name is $parishValue");
                        });
                        fetchAllGroups(parishId);

                        BlocBuilder<GroupBloc, GroupState>(
                            builder: (context, state) {
                          if (state is GetGroupsLoading) {
                            fetchGroupsLoading = true;
                            fetchGroupsError = false;
                          } else if (state is GetGroupsLoaded) {
                            groupModel = state.groupModel;
                            fetchGroupsLoading = false;
                            fetchGroupsError = false;
                          } else if (state is GetGroupsError) {
                            fetchGroupsError = true;
                            fetchGroupsLoading = false;
                            errorText = state.failure.message;
                          }
                          return Container();
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        isOverButton: true,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3))
                            ]),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      key: const ValueKey('Parishes'),
                      value: selectedParish,
                      isExpanded: true,
                      hint: Text(parishValue),
                      items: [
                    ...parishModel!.response!.data!
                        .map((e) => DropdownMenuItem<pModel.ParishData>(
                              value: e,
                              child: Text(e.name!,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    color: Colors.black87,
                                    height: 1.0,
                                  )),
                            ))
                  ])))
        ]);
  }

  Widget buildLgaDropDownButton() {
    return Visibility(
      visible: true,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: 40,
                margin: const EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withOpacity(0.1))),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2<LgaData>(
                        onChanged: (lgaData) {
                          setState(() {
                            lgaId = lgaData!.id;
                            lgaValue = lgaData.name!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          isOverButton: true,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3))
                              ]),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        key: const ValueKey('Lgas'),
                        value: selectedLga,
                        isExpanded: true,
                        hint: Text(
                          lgaValue,
                        ),
                        items: [
                      ...lgaModel!.response!.data!
                          .map((e) => DropdownMenuItem<LgaData>(
                                value: e,
                                child: Text(e.name!,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.0,
                                      color: Colors.black87,
                                      height: 1.0,
                                    )),
                              ))
                    ])))
          ]),
    );
  }

  Widget buildGroupDropDownButton() {
    return Visibility(
      visible: true,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: 40,
                margin: const EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withOpacity(0.1))),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2<GroupData>(
                        onChanged: (groupData) {
                          setState(() {
                            groupId = groupData!.id.toString();
                            groupValue = groupData.name!;
                            pp("The group id is $groupId");
                            pp("The group name is $groupValue");
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          isOverButton: true,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3))
                              ]),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        key: const ValueKey('Groups'),
                        value: selectedGroup,
                        isExpanded: true,
                        hint: Text(
                          groupValue,
                        ),
                        items: [
                      ...groupModel!.response!.data!
                          .map((e) => DropdownMenuItem<GroupData>(
                                value: e,
                                child: Text(e.name!,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.0,
                                      color: Colors.black87,
                                      height: 1.0,
                                    )),
                              ))
                    ])))
          ]),
    );
  }

  Widget buildGenderDropDownButton() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 18, right: 18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3))
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          iconStyleData: const IconStyleData(iconSize: 30),
          items: _selectedGenderList
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ))
              .toList(),
          value: _selectedGender,
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value!;
            });
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 140,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            isOverButton: true,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3))
                ]),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            _getImage(ImageSource.camera);
          },
          child: Text(
            AppStrings.takePictureTxt,
            style: GoogleFonts.inter(
                fontSize: 16.0,
                color: Colors.blue.shade900.withOpacity(0.8),
                fontWeight: FontWeight.w500),
          ),
        ),
        GestureDetector(
          onTap: () {
            _getImage(ImageSource.gallery);
          },
          child: Text(
            AppStrings.pickFromGallary,
            style: GoogleFonts.inter(
                fontSize: 16.0,
                color: Colors.blue.shade900.withOpacity(0.8),
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Future _getImage(ImageSource source) async {
    final path = await uploadImage(source);
    if (path != null) {
      setState(() {
        profileImage = path;
      });
      print("The image path is $profileImage");
    }
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2020));

    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
      print("Date of birth is $_selectedDate");
    } else {
      print("The date is null");
    }
  }

  void getStates() {
    BlocProvider.of<StateBloc>(context).add(GetStatesByCountryIdEvent(161));
  }

  void getLgas(int state_id) {
    BlocProvider.of<LgaBloc>(context).add(GetLgaEvent(161, state_id));
  }

  void fetchAllParish() {
    BlocProvider.of<HomeBloc>(context).add(GetParishesEvent());
  }

  void fetchAllGroups(String parish_id) {
    BlocProvider.of<GroupBloc>(context)
        .add(GetGroupsEvent(parishId: parish_id));
  }

  void createParishioner() {
    if (name.isEmpty) {
      toastInfo(msg: "Name is required");
    } else if (email.isEmpty) {
      toastInfo(msg: "Email is required");
    } else if (phoneNo.isEmpty) {
      toastInfo(msg: "Phone number is required");
    } else if (_selectedGender.isEmpty) {
      toastInfo(msg: "Please select your gender");
    } else if (_selectedDate.toString().isEmpty) {
      toastInfo(msg: "Date of birth required");
    } else if (address.isEmpty) {
      toastInfo(msg: "Address is required");
    } else if (stateId == null) {
      toastInfo(msg: "Please select your state");
    } else if (lgaId == null) {
      toastInfo(msg: "Please select your lga");
    } else if (town.isEmpty) {
      toastInfo(msg: "Town name is required");
    } else if (parishId.isEmpty) {
      toastInfo(msg: "Parish Id is required");
    } else {
      BlocProvider.of<ParishionerBloc>(context).add(CreateParishionerEvent(
          name,
          email,
          phoneNo,
          _selectedGender,
          whatsAppNo,
          _selectedDate.toString(),
          employmentStatus,
          address,
          employerName,
          school,
          stateId,
          lgaId,
          town,
          parishId,
          groupId,
          profileImage));
    }
  }
}

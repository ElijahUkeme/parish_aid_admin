import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_state.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/app/widgets/parish_and_group_common_widgets.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart'
    as pModel;
import 'package:parish_aid_admin/features/state/app/bloc/state_bloc.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_event.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_state.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';
import '../../../../core/helpers/image_processors.dart';
import '../../../../core/utils/urls.dart';
import '../../../../injection_container.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../../../lga/app/bloc/lga_bloc.dart';
import '../../../lga/app/bloc/lga_event.dart';
import '../../../lga/app/bloc/lga_state.dart';
import '../../../lga/data/models/lga_model.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage(
      {Key? key,
      this.coverPhoto,
      this.logoPhoto,
      this.stateModel,
      this.parishId})
      : super(key: key);

  final String? coverPhoto;
  final String? logoPhoto;
  final StateModel? stateModel;
  final String? parishId;

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  String errorText = "";

  StateModel? data;
  StateData? selectedState;
  LgaData? selectedLga;
  LgaModel? lgaModel;
  pModel.ParishModel? parishModel;
  pModel.ParishData? selectedParish;

  //Success message
  String msg = "";

  //the states
  bool createGroupIn = false;
  bool createGroupError = false;
  bool fetchStateLoading = false;
  bool fetchStateError = false;
  bool fetchLgaLoading = false;
  bool fetchLgaError = false;
  bool fetchParishLoading = false;
  bool fetchParishError = false;

  String stateValue = "Select a State";
  String lgaValue = 'Select a Local Government Area';
  String parishValue = "Select your Parish";

  //final homeBloc = sl<HomeBloc>();
  final stateBloc = sl<StateBloc>();

  //create parish data
  String name = "";
  String acronym = "";
  String email = "";
  String phoneNo = "";
  String address = "";
  String category = "";
  String parishId = "";
  int? stateId;
  int? lgaId;
  String town = "";
  String parishPriestName = "";
  String password = "";
  String registrarEmail = "";
  String? groupLogo;
  String? groupCoverImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupLogo = widget.logoPhoto;
    groupCoverImage = widget.coverPhoto;
    getStates();
    fetchAllParish();
    print("The parish Id is ${widget.parishId}");
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
        fetchStateError = false;
        fetchStateLoading = false;
        data = state.stateModel;
      } else if (state is GetStatesError) {
        fetchStateLoading = false;
        fetchStateError = false;
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
        return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is GetParishesLoading) {
            fetchParishLoading = true;
            fetchParishError = false;
            errorText = "";
          } else if (state is GetParishesLoaded) {
            fetchParishError = false;
            fetchParishLoading = false;
            parishModel = state.parishModel;
          } else if (state is GetParishesError) {
            fetchParishLoading = false;
            fetchParishError = true;
            errorText = state.failure.message;
          }

          return BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
            if (state is CreateGroupLoading) {
              createGroupIn = true;
              createGroupError = false;
              errorText = "";
            } else if (state is CreateGroupLoaded) {
              createGroupIn = false;
              createGroupError = false;
              errorText = "";
              toastInfo(msg: state.groupModel.response!.message!);
              //clearFields();
              if (context.mounted) {
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => {Navigator.pop(context)});
              }
            } else if (state is CreateGroupError) {
              createGroupIn = false;
              createGroupError = true;
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
                : Scaffold(
                    resizeToAvoidBottomInset: false,
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      toolbarHeight: 40,
                      elevation: 0.0,
                      iconTheme: const IconThemeData(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue.shade900.withOpacity(0.8),
                    body: Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  child: !groupCoverImage.isEmptyOrNull
                                      ? loadImageWidget(groupCoverImage!)
                                      : Image.asset(
                                          Urls.defaultBackgroundImage,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                buildCard(size)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          });
        });
      });
    });
  }

  Widget buildCard(Size size) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 35,
                height: 4.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ),

            //logo section & getting started text here
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //logo and text here
                  logo(size.height / 12, size.height / 12),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  commonRichText(16, "CREATE", "GROUP"),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),

            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //email textField here
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputFields(
                          size * 1.2, true, "Name", "Enter your name", false,
                          (value) {
                        name = value;
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      buildInputFields(
                          size * 1.2, true, "Acronym", "Acronym", false,
                          (value) {
                        acronym = value;
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      buildInputFields(
                          size * 1.2, true, "Email", "Email", false, (value) {
                        email = value;
                      }),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  buildInputFields(
                      size * 1.2, true, "Password", "Password", true, (value) {
                    password = value;
                  }),
                  const SizedBox(
                    height: 16,
                  ),

                  buildInputFields(size * 1.2, true, "Phone", "Phone", false,
                      (value) {
                    phoneNo = value;
                  }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildInputFields(
                      size * 1.2, true, "Address", "Address", false, (value) {
                    address = value;
                  }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildInputFields(
                      size * 1.2, true, "Category", "Category", false, (value) {
                    category = value;
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  buildParishesDropDownButton(),
                  const SizedBox(
                    height: 16,
                  ),
                  buildStateDropDownButton(),
                  const SizedBox(
                    height: 16,
                  ),
                  lgaModel == null ? const Center() : buildLgaDropDownButton(),
                  const SizedBox(
                    height: 16,
                  ),

                  buildInputFields(size * 1.2, true, "Town", "Town", false,
                      (value) {
                    town = value;
                  }),

                  const SizedBox(
                    height: 16,
                  ),
                  buildInputFields(size * 1.2, true, "Priest Name",
                      "Parish Priest Name", false, (value) {
                    parishPriestName = value;
                  }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildInputFields(size * 1.2, true, "Registrar Email",
                      "Registrar Email", false, (value) {
                    registrarEmail = value;
                  }),

                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            buildFooter(size),
            const SizedBox(
              height: 25,
            ),

            //sign in button
            GestureDetector(
              onTap: () {
                //createGroup();
                getStates();
              },
              child: Stack(
                children: [
                  commonActionButton(size, "Create"),
                  Visibility(
                    visible: createGroupIn,
                    child: Positioned(
                        left: 100,
                        bottom: 20,
                        child: buildLoadingIndicator(
                            color: Colors.grey.withOpacity(0.8))),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildParishesDropDownButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Parish',
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: Colors.black87,
              height: 1.0,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              //margin: EdgeInsets.only(left: 15, right: 15),
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
                          print("The parish id is $parishId");
                          print("The parish name is $parishValue");
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

  Widget buildStateDropDownButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('State',
              style: GoogleFonts.inter(
                fontSize: 12.0,
                color: Colors.black87,
                height: 1.0,
              )),
          const SizedBox(
            height: 8,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
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
                          print("The state id is $stateId");
                          print("The state name is $stateValue");
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

  Widget buildLgaDropDownButton() {
    return Visibility(
      visible: true,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Lga',
              style: GoogleFonts.inter(
                fontSize: 12.0,
                color: Colors.black87,
                height: 1.0,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
                height: 50,
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
                            pp("The state id is $lgaId");
                            pp("The state name is $lgaValue");
                          });
                          getLgas(lgaId!);
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                        dropdownStyleData:  DropdownStyleData(
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
                        hint: Text(lgaValue),
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

  Widget logo(double height_, double width_) {
    return SizedBox(
        child: !groupLogo.isEmptyOrNull
            ? SizedBox(
                height: 50, width: 250, child: loadImageWidget(groupLogo!))
            : Image.asset(
                Urls.defaultBackgroundLogo,
                height: 50,
                width: 250,
              ));
  }

  Widget buildFooter(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _getCoverImage(ImageSource.gallery);
          },
          child: Text(
            "Pick a Cover Image",
            style: GoogleFonts.inter(
                fontSize: 16.0,
                color: Colors.blue.shade900.withOpacity(0.8),
                fontWeight: FontWeight.w500),
          ),
        ),
        GestureDetector(
          onTap: () {
            _getLogo(ImageSource.gallery);
          },
          child: Text(
            "Pick a Logo",
            style: GoogleFonts.inter(
                fontSize: 16.0,
                color: Colors.blue.shade900.withOpacity(0.8),
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Future _getLogo(ImageSource source) async {
    final path = await uploadImage(source);
    if (path != null) {
      setState(() {
        groupLogo = path;
      });
    }
  }

  // Widget buildStateAndLgaDropDownButton(){
  //   return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Text(
  //           'Select a state',
  //           style: GoogleFonts.inter(
  //             fontSize: 14.0,
  //             color: Colors.black,
  //             height: 1.0,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 8,
  //         ),
  //         Container(
  //
  //           height: 50,
  //           width: MediaQuery.of(context).size.width,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(color: Colors.black.withOpacity(0.6))
  //           ),
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton2<String>(
  //               key: const ValueKey('States'),
  //               value: stateValue,
  //               isExpanded: true,
  //               hint: const Text('Select a state'),
  //               items: NigerianStatesAndLGA.allStates
  //                   .map<DropdownMenuItem<String>>((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value,
  //                       style: GoogleFonts.inter(
  //                         fontSize: 14.0,
  //                         color: Colors.black,
  //                         height: 1.0,
  //                       )),
  //                 );
  //               }).toList(),
  //               onChanged: (val) {
  //                 lgaValue = 'Select a Local Government Area';
  //                 statesLga.clear();
  //                 statesLga.add(lgaValue);
  //                 statesLga.addAll(NigerianStatesAndLGA.getStateLGAs(val!));
  //                 setState(() {
  //                   stateValue = val;
  //                 });
  //               },
  //
  //               buttonStyleData:  ButtonStyleData(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 height: 50,
  //                 width: MediaQuery.of(context).size.width,
  //               ),
  //               dropdownStyleData: DropdownStyleData(
  //                 maxHeight: 200,
  //                 isOverButton: true,
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     boxShadow: [
  //                       BoxShadow(
  //                           color: Colors.black.withOpacity(0.05),
  //                           spreadRadius: 2,
  //                           blurRadius: 3,
  //                           offset: Offset(0, 3))
  //                     ]),
  //               ),
  //               menuItemStyleData: const MenuItemStyleData(
  //                 height: 40,
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Container(
  //           height: 50,
  //           width: MediaQuery.of(context).size.width,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(color: Colors.black.withOpacity(0.6))
  //           ),
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton2<String>(
  //               key: const ValueKey('Local governments'),
  //               value: lgaValue,
  //               isExpanded: true,
  //               hint: const Text('Select a Lga'),
  //               items:
  //               statesLga.map<DropdownMenuItem<String>>((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value,
  //                     style: GoogleFonts.inter(
  //                       fontSize: 14.0,
  //                       color: Colors.black,
  //                       height: 1.0,
  //                     ),),
  //                 );
  //               }).toList(),
  //               onChanged: (val) {
  //                 setState(() {
  //                   lgaValue = val!;
  //                 });
  //               },
  //
  //               buttonStyleData:  ButtonStyleData(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 height: 50,
  //                 width: MediaQuery.of(context).size.width,
  //               ),
  //               dropdownStyleData: DropdownStyleData(
  //                 maxHeight: 200,
  //                 isOverButton: true,
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     boxShadow: [
  //                       BoxShadow(
  //                           color: Colors.black.withOpacity(0.05),
  //                           spreadRadius: 2,
  //                           blurRadius: 3,
  //                           offset: Offset(0, 3))
  //                     ]),
  //               ),
  //               menuItemStyleData: const MenuItemStyleData(
  //                 height: 40,
  //               ),
  //
  //             ),
  //           ),
  //         ),
  //
  //       ]);
  // }

  Future _getCoverImage(ImageSource source) async {
    final path = await uploadImage(source);

    if (path != null) {
      setState(() {
        groupCoverImage = path;
      });
    }
  }

  void createGroup() {
    if (name.isEmpty) {
      toastInfo(msg: "Name required");
    } else if (acronym.isEmpty) {
      toastInfo(msg: "Acronym required");
    } else if (email.isEmpty) {
      toastInfo(msg: "Email required");
    } else if (address.isEmpty) {
      toastInfo(msg: "Address required");
    } else if (phoneNo.isEmpty) {
      toastInfo(msg: "Phone Number required");
    } else if (parishPriestName.isEmpty) {
      toastInfo(msg: "Parish Priest name required");
    } else if (registrarEmail.isEmpty) {
      toastInfo(msg: "Registrar email required");
    } else if (town.isEmpty) {
      toastInfo(msg: "Town required");
    } else if (password.isEmpty) {
      toastInfo(msg: "Password required");
    } else {
      BlocProvider.of<GroupBloc>(context).add(CreateGroupEvent(
          name: name,
          acronym: acronym,
          email: email,
          phoneNo: phoneNo,
          address: address,
          category: category,
          stateId: stateId,
          lgaId: lgaId,
          parishId: parishId,
          town: town,
          password: password,
          registrarEmail: registrarEmail,
          logo: groupLogo,
          coverImage: groupCoverImage));
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
}

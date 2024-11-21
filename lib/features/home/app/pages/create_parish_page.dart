import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parish_aid_admin/core/helpers/image_processors.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/auth/app/widgets/auth_page_widgets.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/app/widgets/parish_and_group_common_widgets.dart';
import 'package:parish_aid_admin/features/lga/data/models/lga_model.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_bloc.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_event.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_state.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';

import '../../../../core/helpers/custom_widgets.dart';
import '../../../../core/utils/urls.dart';
import '../../../lga/app/bloc/lga_bloc.dart';
import '../../../lga/app/bloc/lga_event.dart';
import '../../../lga/app/bloc/lga_state.dart';

class CreateParishPage extends StatefulWidget {
  const CreateParishPage({Key? key, this.coverPhoto, this.logoPhoto})
      : super(key: key);

  final String? coverPhoto;
  final String? logoPhoto;

  @override
  State<CreateParishPage> createState() => _CreateParishPageState();
}

class _CreateParishPageState extends State<CreateParishPage> {
  String errorText = "";

  //Success message
  String msg = "";

  StateModel? data;
  StateData? selectedState;
  LgaData? selectedLga;
  LgaModel? lgaModel;

  //the states
  bool createParishIn = false;
  bool createParishError = false;
  bool fetchStateLoading = false;
  bool fetchStateError = false;
  bool fetchLgaLoading = false;
  bool fetchLgaError = false;

  String stateValue = "Select a State";
  String lgaValue = 'Select a Local Government Area';

  //final homeBloc = sl<HomeBloc>();

  //create parish data
  String name = "";
  String acronym = "";
  String email = "";
  String phoneNo = "";
  String address = "";
  String dioceseId = "";
  String town = "";
  int? stateId;
  int? lgaId;
  String parishPriestName = "";
  String password = "";
  String registrarEmail = "";
  String? parishLogo;
  String? parishCoverImage;

  @override
  void initState() {
    super.initState();
    parishLogo = widget.logoPhoto;
    parishCoverImage = widget.coverPhoto;
    getStates();
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
      return BlocBuilder<LgaBloc,LgaState>(builder: (context,state){
        if(state is LgaLoading){
          fetchLgaLoading = true;
          fetchLgaError = false;
        }else if(state is LgaLoaded){
          lgaModel = state.lgaModel;
          fetchLgaLoading = false;
          fetchLgaError = false;
        }else if(state is LgaError){
          fetchLgaError = true;
          fetchLgaLoading = false;
          errorText = state.failure.message;
        }
            return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is CreateParishLoading) {
                createParishIn = true;
                createParishError = false;
                errorText = "";
              } else if (state is CreateParishLoaded) {
                createParishIn = false;
                createParishError = false;
                errorText = "";
                toastInfo(msg: state.parishModel.response!.message!);
                clearFields();
                if (context.mounted) {
                  Future.delayed(const Duration(seconds: 1))
                      .then((value) => {Navigator.pop(context)});
                }
              } else if (state is CreateParishError) {
                createParishIn = false;
                createParishError = true;
                errorText = state.failure.message;
              }
              return fetchStateLoading
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
                              child: !parishCoverImage.isEmptyOrNull
                                  ? loadImageWidget(parishCoverImage!)
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
                  commonRichText(16, "CREATE", "PARISH"),
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
                  buildStateDropDownButton(),
                  const SizedBox(
                    height: 16,
                  ),
                  lgaModel ==null?const Center():buildLgaDropDownButton(),

                  const SizedBox(
                    height: 16,
                  ),
                  buildInputFields(
                      size * 1.2, true, "Diocese Id", "Diocese Id", false,
                      (value) {
                    dioceseId = value;
                  }),
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
                createParish();
              },
              child: Stack(
                children: [
                  commonActionButton(size, "Create"),
                  Visibility(
                    visible: createParishIn,
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

            //footer section
            //Flexible(fit: FlexFit.loose, child: buildFooter(size)),
          ],
        ),
      ),
    );
  }

  Widget buildStateDropDownButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'State',
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
                  child: DropdownButton2<StateData>(
                      onChanged: (stateData) {
                        setState(() {
                          stateId = stateData!.id;
                          stateValue = stateData.name!;
                          pp("The state id is $stateId");
                          pp("The state name is $stateValue");
                        });
                        getLgas(stateId!);

                        BlocBuilder<LgaBloc,LgaState>(builder: (context,state){
                          if(state is LgaLoading){
                            fetchLgaLoading = true;
                            fetchLgaError = false;
                          }else if(state is LgaLoaded){
                            lgaModel = state.lgaModel;
                            fetchLgaLoading = false;
                            fetchLgaError = false;
                          }else if(state is LgaError){
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
        child: !parishLogo.isEmptyOrNull
            ? SizedBox(
                height: 50, width: 250, child: loadImageWidget(parishLogo!))
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
        parishLogo = path;
      });
      pp("the logo path is $path");
      pp("The path assign is $parishLogo");
    }
  }

  Future _getCoverImage(ImageSource source) async {
    final path = await uploadImage(source);

    if (path != null) {
      setState(() {
        parishCoverImage = path;
      });
      pp("The cover image path is $path");
      pp("The path assign is $parishCoverImage");
    }
  }

  void createParish() {
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
      BlocProvider.of<HomeBloc>(context).add(CreateParishEvent(
          name: name,
          acronym: acronym,
          email: email,
          phoneNo: phoneNo,
          address: address,
          dioceseId: dioceseId,
          stateId: stateId,
          lgaId: lgaId,
          town: town,
          parishPriestName: parishPriestName,
          password: password,
          registrarEmail: registrarEmail,
          logo: parishLogo,
          coverImage: parishCoverImage));
    }
  }

  void getStates() {
    BlocProvider.of<StateBloc>(context).add(GetStatesByCountryIdEvent(161));
  }
  void getLgas(int state_id){
    BlocProvider.of<LgaBloc>(context).add(GetLgaEvent(161,state_id));
  }

  clearFields() {
    email = "";
    acronym = "";
    name = "";
    phoneNo = "";
    address = "";
    dioceseId = "";
    town = "";
    parishPriestName = "";
    password = "";
    registrarEmail = "";
  }
}

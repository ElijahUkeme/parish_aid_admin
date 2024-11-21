
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/widgets/parish_and_group_common_widgets.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';

import '../../../../core/helpers/image_processors.dart';
import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class UpdateParishPage extends StatefulWidget {
  const UpdateParishPage({Key? key,this.coverPhoto, this.logoPhoto,required this.parish}) : super(key: key);
  final Parish parish;

  final String? coverPhoto;
  final String? logoPhoto;

  @override
  State<UpdateParishPage> createState() => _UpdateParishPageState();
}

class _UpdateParishPageState extends State<UpdateParishPage> {

  String errorText = "";

  //Success message
  String msg = "";

  //the states
  bool updateParishIn = false;
  bool updateParishError = false;

  String name = "";
  String acronym = "";
  String email = "";
  String phoneNo = "";
  String address = "";
  int? parishId;
  int? stateId;
  int? lgaId;
  int? dioceseId;
  String town = "";
  String parishPriestName = "";
  String registrarEmail = "";
  String? parishLogo;
  String? parishCoverImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parishLogo = widget.logoPhoto;
    parishCoverImage = widget.coverPhoto;

    name = widget.parish.name!;
    acronym = widget.parish.acronym!;
    email = widget.parish.email!;
    phoneNo = widget.parish.phoneNo!;
    address = widget.parish.address!;
    parishId = widget.parish.id;
    stateId = widget.parish.state!.id!;
    lgaId = widget.parish.lgaData!.id!;
    dioceseId = widget.parish.diocese!.id!;
    town = widget.parish.town!.name!;
    parishPriestName = widget.parish.parishPriestName!;
    registrarEmail = widget.parish.email!;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state){

      if (state is UpdateParishLoading) {
        updateParishIn = true;
        updateParishError = false;
        errorText = "";
      } else if (state is UpdateParishLoaded) {
        updateParishIn = false;
        updateParishError = false;
        errorText = "";
        toastInfo(msg: state.parishModel.response!.message!);
        if (context.mounted) {
          Future.delayed(const Duration(seconds: 1)).then((value) => {
          Navigator.pop(context)
          });
        }
      } else if (state is UpdateParishError) {
        updateParishIn = false;
        updateParishError = true;
        errorText = state.failure.message;
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 40,
          elevation: 0.0,
          iconTheme: const IconThemeData(
              color: Colors.white
          ),

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
                  commonRichText(16, "UPDATE", "PARISH"),
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

                      buildUpdateInputFields(size: size *1.2,isParish: true, input: "Name", textHint: "Enter the name" , isObscured: false,initialText: name,
                              func: (value) {
                        name = value;
                          }),

                      const SizedBox(
                        height: 16,
                      ),


                      buildUpdateInputFields(
                          size: size *1.2,isParish: true, input: "Acronym", textHint: "Acronym" ,isObscured: false,initialText: acronym,
                              func: (value) {
                            acronym = value;
                          }),

                      const SizedBox(
                        height: 16,
                      ),

                      buildUpdateInputFields(size: size *1.2,isParish: true, input: "Email", textHint: "Email" ,isObscured: false,initialText: email,
                              func: (value) {
                            email = value;
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(size: size *1.2,isParish: true, input: "Phone", textHint: "Phone" ,isObscured: false,initialText: phoneNo,
                          func: (value) {
                        phoneNo = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(
                      size: size *1.2,isParish: true, input: "Address", textHint: "Address" ,isObscured: false, initialText: address,
                          func: (value) {
                        address = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),
                  buildUpdateInputFields(
                      size: size *1.2,isParish: true, input: "Parish Id", textHint: "Parish Id" ,isObscured: false,
                      initialText: parishId.toString(),
                         func:  (value) {
                        parishId = value as int?;
                      }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(
                      size: size *1.2,isParish: true, input: "State Id", textHint: "State Id" ,isObscured: false, initialText:  stateId.toString(),
                          func: (value) {
                         stateId = value as int?;
                      }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(
                      size: size *1.2,isParish: true, input: "Lga Id", textHint: "Lga Id" ,isObscured: false,initialText:  lgaId.toString(),
                          func: (value) {
                        lgaId = value as int?;
                      }),


                  const SizedBox(
                    height: 16,
                  ),
                  buildUpdateInputFields(
                      size: size *1.2,isParish: true, input: "Diocese Id", textHint: "Diocese Id" ,isObscured: false,initialText:  dioceseId.toString(),
                          func: (value) {
                        dioceseId = value as int?;
                      }),
                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(size: size *1.2,isParish: true, input: "Town", textHint: "Town" ,isObscured: false,initialText: town,
                          func: (value) {
                        town = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),
                  buildUpdateInputFields(
                      size: size *1.2,isParish: true, input: "Priest Name", textHint: "Parish Priest Name" ,isObscured: false,initialText: parishPriestName,
                          func: (value) {
                        parishPriestName = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(size: size *1.2,isParish: true, input: "Registrar Email", textHint: "Registrar Email" ,isObscured: false,initialText: registrarEmail,
                          func: (value) {
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
                updateParish();
              },
              child: Stack(
                children: [
                  commonActionButton(size, "Update"),
                  Visibility(
                    visible: updateParishIn,
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

  Widget logo(double height_, double width_) {
    return SizedBox(
        child: !parishLogo.isEmptyOrNull
            ? SizedBox(
            height:50, width: 250, child: loadImageWidget(parishLogo!))
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
      print("the logo path is $path");
      print("The path assign is $parishLogo");
    }
  }

  Future _getCoverImage(ImageSource source) async {
    final path = await uploadImage(source);

    if (path != null) {
      setState(() {
        parishCoverImage = path;
      });
      print("The cover image path is $path");
      print("The path assign is $parishCoverImage");
    }
  }

  void updateParish(){
    BlocProvider.of<HomeBloc>(context).add(UpdateParishEvent(
      name: name,
      acronym: acronym,
      email: email,
      phoneNo: phoneNo,
      address: address,
      parishId: parishId.toString(),
      dioceseId: dioceseId.toString(),
      stateId: stateId.toString(),
      lgaId: lgaId.toString(),
      town: town,
      parishPriestName: parishPriestName,
      registrarEmail: registrarEmail,
      logo: parishLogo,
      coverImage: parishCoverImage
    ));
  }
}

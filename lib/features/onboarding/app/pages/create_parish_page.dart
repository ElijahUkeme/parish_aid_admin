import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parish_aid_admin/core/helpers/image_processors.dart';
import 'package:parish_aid_admin/core/utils/enums.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/navigation_drawer_page.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';
import '../../../../core/utils/urls.dart';

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

  //the states
  bool createParishIn = false;
  bool createParishError = false;

  //final homeBloc = sl<HomeBloc>();

  //create parish data
  String name = "";
  String acronym = "";
  String email = "";
  String phoneNo = "";
  String address = "";
  String dioceseId = "";
  String stateId = "";
  String lgaId = "";
  String town = "";
  String parishPriestName = "";
  String password = "";
  String registrarEmail = "";
  String? parishLogo;
  String? parishCoverImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parishLogo = widget.logoPhoto;
    parishCoverImage = widget.coverPhoto;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          Navigator.pop(context);
        }
      } else if (state is CreateParishError) {
        createParishIn = false;
        createParishError = true;
        errorText = state.failure.message;
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue.shade900.withOpacity(0.8),
        body: SafeArea(
          child: SingleChildScrollView(
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
                  color: Colors.grey,
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
                  richText(24),
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(size, "Name", Icons.home, false,
                              (value) {
                            name = value;
                          }),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Acronym',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(
                              size, "Acronym", Icons.hourglass_bottom, false,
                              (value) {
                            acronym = value;
                          }),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      //password textField & f

                      //password textField & f

                      Text(
                        'Email',
                        style: GoogleFonts.inter(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      textInputField(size, "Email", Icons.email_outlined, false,
                          (value) {
                        email = value;
                      }),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  //password textField & forget text here
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.inter(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      textInputField(size, "Password", Icons.password, true,
                          (value) {
                        password = value;
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(size, "Phone", Icons.phone, false,
                              (value) {
                            phoneNo = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(
                              size, "Address", Icons.location_on, false,
                              (value) {
                            address = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diocese Id',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(
                              size, "Diocese Id", Icons.location_on, false,
                              (value) {
                            dioceseId = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State Id',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(
                              size, "State Id", Icons.location_on, false,
                              (value) {
                            stateId = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lga Id',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(
                              size, "Lga Id", Icons.location_on, false,
                              (value) {
                            lgaId = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Town',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(size, "Town", Icons.location_on, false,
                              (value) {
                            town = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Parish priest Name',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(
                              size, "Parish Priest Name", Icons.person, false,
                              (value) {
                            parishPriestName = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registrar Email',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textInputField(size, "Registrar Email",
                              Icons.email_outlined, false, (value) {
                            registrarEmail = value;
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
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
                  actionButton(size, "Create"),
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

  Widget logo(double height_, double width_) {
    return SizedBox(
        child: !parishLogo.isEmptyOrNull
            ? SizedBox(
                height: 100, width: 200, child: loadImageWidget(parishLogo!))
            : Image.asset(
                Urls.defaultBackgroundLogo,
                height: 100,
                width: 200,
              ));
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: Colors.blue.shade900,
          letterSpacing: 2.000000061035156,
        ),
        children: [
          const TextSpan(
            text: 'CREATE',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'Parish',
            style: TextStyle(
              color: Colors.blue.shade900.withOpacity(0.2),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget textInputField(Size size, String hintText, IconData icon,
      bool isObscured, Function(String value)? func) {
    return SizedBox(
      height: size.height / 13,
      child: TextField(
        style: GoogleFonts.inter(
          fontSize: 18.0,
          color: const Color(0xFF151624),
        ),
        maxLines: 1,
        obscureText: isObscured,
        onChanged: func,
        cursorColor: const Color(0xFF151624),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            fontSize: 16.0,
            color: const Color(0xFF151624).withOpacity(0.5),
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.8),
              )),
          prefixIcon: Icon(
            icon,
            color: Colors.blue.shade900.withOpacity(0.8),
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget actionButton(Size size, String text) {
    return // Group: Button
        Container(
      alignment: Alignment.center,
      height: size.height / 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.blue.shade900,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C2E84).withOpacity(0.2),
            offset: const Offset(0, 15.0),
            blurRadius: 60.0,
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            _getCoverImage(ImageSource.gallery);
          },
          child: Text(
            "Pick a Cover Image",
            style: GoogleFonts.inter(
                fontSize: 16.0,
                color: Colors.grey.withOpacity(0.8),
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
                color: Colors.grey.withOpacity(0.8),
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

  clearFields() {
    email = "";
    acronym = "";
    name = "";
    phoneNo = "";
    address = "";
    dioceseId = "";
    stateId = "";
    lgaId = "";
    town = "";
    parishPriestName = "";
    password = "";
    registrarEmail = "";
  }
}

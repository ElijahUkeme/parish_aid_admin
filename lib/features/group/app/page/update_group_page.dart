import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';

import 'package:parish_aid_admin/features/group/app/bloc/group_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_state.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';

import '../../../../core/helpers/image_processors.dart';
import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../../../home/app/widgets/parish_and_group_common_widgets.dart';

class UpdateGroupPage extends StatefulWidget {
  const UpdateGroupPage({Key? key,required this.group}) : super(key: key);

  final GroupData group;

  @override
  State<UpdateGroupPage> createState() => _UpdateGroupPageState();
}

class _UpdateGroupPageState extends State<UpdateGroupPage> {

  String errorText = "";

  //Success message
  String msg = "";


  String name = "";
  String acronym = "";
  String email = "";
  String phoneNo = "";
  String address = "";
  String category = "";
  String town = "";
  String groupId = "";
  String parishPriestName = "";
  String parishId = '';
  //String registrarEmail = "";
  String? groupLogo;
  String? groupCoverImage;
  //the states
  bool updateGroupLoading = false;
  bool updateGroupError = false;

  @override
  void initState() {
    name = widget.group.name!;
    acronym = widget.group.acronym!;
    email = widget.group.email!;
    phoneNo = widget.group.phoneNo!;
    address = widget.group.town!.name!;
    category = widget.group.category!;
    town = widget.group.town!.name!;
    groupId = widget.group.id.toString();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return BlocBuilder<GroupBloc,GroupState>(builder: (context,state){

      if (state is UpdateGroupLoading) {
        updateGroupLoading = true;
        updateGroupError = false;
        errorText = "";
      } else if (state is UpdateGroupLoaded) {
        updateGroupLoading = false;
        updateGroupError = false;
        errorText = "";
        toastInfo(msg: state.groupModel.response!.message!);
        if (context.mounted) {
          Future.delayed(const Duration(seconds: 1)).then((value) => {
            Navigator.pop(context)
          });
        }
      } else if (state is UpdateGroupError) {
        updateGroupLoading = false;
        updateGroupError = true;
        errorText = state.failure.message;
        toastInfo(msg: errorText);
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
                  commonRichText(16, "UPDATE", "GROUP"),
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

                      buildUpdateInputFields(size: size *1.2,isParish: false,input:  "Name", textHint: "Enter the name" ,isObscured: false,initialText: name,
                              func: (value) {
                            name = value;
                          }),

                      const SizedBox(
                        height: 16,
                      ),


                      buildUpdateInputFields(
                          size: size *1.2,isParish: false, input: "Acronym", textHint: "Acronym" ,isObscured: false,initialText: acronym,
                              func: (value) {
                            acronym = value;
                          }),

                      const SizedBox(
                        height: 16,
                      ),

                      buildUpdateInputFields(size: size *1.2,isParish: false, input: "Email", textHint: "Email" ,isObscured: false,initialText: email,
                              func: (value) {
                            email = value;
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(size: size *1.2,isParish: false, input: "Phone", textHint: "Phone" ,isObscured: false,initialText: phoneNo,
                          func: (value) {
                        phoneNo = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(
                      size: size *1.2,isParish: false, input: "Address", textHint: "Address" ,isObscured: false,initialText: address,
                          func: (value) {
                        address = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(
                      size: size *1.2,isParish: false, input: "Group Id", textHint: "Parish Id" ,isObscured: false,initialText: groupId,
                          func: (value) {
                        groupId = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),


                  buildUpdateInputFields(size: size *1.2,isParish: false, input: "Town", textHint: "Town" , isObscured: false,initialText: town,
                         func:  (value) {
                        town = value;
                      }),

                  const SizedBox(
                    height: 16,
                  ),

                  buildUpdateInputFields(size: size *1.2, isParish: false, input: "Parish Id", textHint: "Enter your parish Id" ,isObscured: false,
                      initialText: '',
                          func: (value) {
                        parishId = value;
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
                updateGroup();
              },
              child: Stack(
                children: [
                  commonActionButton(size, "Update"),
                  Visibility(
                    visible: updateGroupLoading,
                    child: Positioned(
                        left: 100,
                        bottom: 18,
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
        child: !groupLogo.isEmptyOrNull
            ? SizedBox(
            height:50, width: 250, child: loadImageWidget(groupLogo!))
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

  Future _getCoverImage(ImageSource source) async {
    final path = await uploadImage(source);

    if (path != null) {
      setState(() {
        groupCoverImage = path;
      });

    }
  }

  void updateGroup(){
    BlocProvider.of<GroupBloc>(context).add(UpdateGroupEvent(
        name: name,
        acronym: acronym,
        email: email,
        phoneNo: phoneNo,
        address: address,
        parishId: parishId,
        town: town,
        logo: groupLogo,
        coverImage: groupCoverImage
    ));
  }
}

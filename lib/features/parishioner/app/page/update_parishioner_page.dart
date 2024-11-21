
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parish_aid_admin/core/utils/app_utils.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_event.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_state.dart';
import 'package:parish_aid_admin/features/parishioner/app/widget/parishioner_input_fields.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';
import '../../../../core/helpers/image_processors.dart';
import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class UpdateParishionerPage extends StatefulWidget {
  const UpdateParishionerPage({Key? key,required this.parishionerData}) : super(key: key);


  final ParishionerData parishionerData;

  @override
  State<UpdateParishionerPage> createState() => _UpdateParishionerPageState();
}

class _UpdateParishionerPageState extends State<UpdateParishionerPage> {

  //error message
  String errorText = "";

  //Success message
  String msg = "";

  bool loading = false;

  String? profileImage;
  String? name;
  String? email;
  String? phoneNo;
  String? whatsAppNo;
  String? employmentStatus;
  String? address;
  String? employerName;
  String? school;
  String? gender;
  String? dob;
  int? stateId;
  int? lgaId;
  String? town;

  @override
  void initState() {
    super.initState();
    profileImage = widget.parishionerData.image;
    name = widget.parishionerData.name;
    email = widget.parishionerData.email;
    phoneNo = widget.parishionerData.phoneNo;
    whatsAppNo = widget.parishionerData.whatsAppNo;
    employmentStatus = widget.parishionerData.employmentStatus;
    employerName = widget.parishionerData.employerName;
    address = widget.parishionerData.address;
    school = widget.parishionerData.school;
    gender = widget.parishionerData.gender;
    dob = widget.parishionerData.dob;
    town = widget.parishionerData.parish!.town!.name;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<ParishionerBloc,ParishionerState>(listener: (context,state){
      if(state is UpdateParishionerLoading){
        setState(() {
          loading = true;
        });
      }else if(state is UpdateParishionerLoaded){
        setState(() {
          loading = false;
          showCustomTopSnackBar(context, message: state.parishionerModel.response!.message!);
        });
      }else if(state is UpdateParishionerError){
        setState(() {
          loading = false;
          showCustomTopSnackBar(context, message: state.failure.message);
        });
      }
    },
      child: Scaffold(
        appBar: AppBar(
            title: Text('Update', style: Theme
                .of(context)
                .textTheme
                .labelSmall)
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                /// -- IMAGE
                Stack(
                  children: [
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.white,
                            child: !profileImage.isEmptyOrNull
                                ? loadCircularImageWidget(
                              profileImage!,
                            )
                                : const SizedBox(
                                width: 130,
                                height: 130,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      Urls.defaultProfileImage),

                                )))),
                    Positioned(
                      bottom: 25,
                      right: 7,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: GestureDetector(
                          onTap: (){
                            _getImage(ImageSource.gallery);
                          },
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Name", "Enter your name", false,name??'', (value) {
                  name = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Email", "Enter your Email", false, email??'', (value) {
                  email = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Gender", "Enter your Gender", false,gender??'', (value) {
                  gender = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "WhatsApp No", "Enter your WhatsApp Number", false,whatsAppNo??'', (value) {
                  whatsAppNo = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Dob", "Enter your date of birth", false,splitDateOfBirth(dob!), (value) {
                  dob = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Employment Status", "Enter your Employment status", false,employmentStatus??'', (value) {
                  employmentStatus = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Address", "Enter your address", false,address??'', (value) {
                  address = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Employer Name", "Enter your Employer Name", false,employerName??'', (value) {
                  employerName = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "School", "Enter your school", false,school??'', (value) {
                  school = value;
                }),
                const SizedBox(height: 16),
                buildParishionerInputFields(size, false, "Town", "Enter your town", false,town??'', (value) {
                  town = value;
                }),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    updateParishioner();
                  },
                  child: Stack(
                    children: [
                      triggerActionButtonBlue(size, "Update",color: Colors.grey.withOpacity(0.9)),
                      Visibility(
                          visible: loading,
                          child: Positioned(
                            left: 100,
                            bottom: 20,
                            child: buildLoadingIndicator(
                                color: Colors.white),
                          )
                      )],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateParishioner(){

    BlocProvider.of<ParishionerBloc>(context).add(
      UpdateParishionerEvent(
          name, email, phoneNo, gender,
          whatsAppNo, dob, employmentStatus,
          address, employerName, school, '', '', town, '', '', profileImage, widget.parishionerData.id.toString())
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
}


import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/app_utils.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/auth/app/widgets/auth_page_widgets.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/update_parishioner_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/widget/parishioner_text_widget.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';

import '../../../../core/helpers/image_processors.dart';

class ParishionerProfilePage extends StatefulWidget {
  const ParishionerProfilePage({Key? key,this.parishionerData}) : super(key: key);

  final ParishionerData? parishionerData;

  @override
  State<ParishionerProfilePage> createState() => _ParishionerProfilePageState();
}

class _ParishionerProfilePageState extends State<ParishionerProfilePage> {



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
      return pageBody(size);
  }

  Widget pageBody(Size size){
    return Scaffold(
        appBar: AppBar(
            title: Text('Parishioner Detail', style: Theme.of(context).textTheme.labelSmall),
          backgroundColor: Colors.blue.shade900.withOpacity(0.9),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Go to Updating screen',
              onPressed: () {
                moveToUpdatingScreen();
              },
            ),
          ],
        ),
        body:SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              // Stack(
              // alignment: Alignment.bottomRight,
              // children: [
              //   Stack(
              //     alignment: Alignment.topLeft,
              //     children: [
              //       CircleAvatar(
              //         radius: 60.0,
              //         backgroundColor: Colors.white,
              //         child: !widget.parishionerData!.image.isEmptyOrNull
              //             ? loadImageWidget(
              //           widget.parishionerData!.image!,
              //         )
              //             :
              //         const Icon(
              //           Icons.person,
              //           color: Colors.grey,
              //           size: 80,
              //         ),
              //       ),
              //     ],
              //   ),
              //   triggerActionButtonBlue(size/3, 'Edit Profile')
              // ],
              //   ),
                const SizedBox(height: 20),
                parishionerTextWidget("Name", widget.parishionerData!.name??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Email", widget.parishionerData!.email??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Phone Number", widget.parishionerData!.phoneNo??""),
                const SizedBox(height: 10),
                parishionerTextWidget("WhatsApp Number", widget.parishionerData!.whatsAppNo??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Address", widget.parishionerData!.address??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Date of Birth", splitDateOfBirth(widget.parishionerData!.dob!)),
                const SizedBox(height: 10),
                parishionerTextWidget("Gender", widget.parishionerData!.gender??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Employment Status", widget.parishionerData!.employmentStatus??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Status", widget.parishionerData!.status??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Employer Name", widget.parishionerData!.employerName??""),
                const SizedBox(height: 10),
                parishionerTextWidget("School", widget.parishionerData!.school??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Parish Name", widget.parishionerData!.parish!.name??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Acronym", widget.parishionerData!.parish!.acronym??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Address", widget.parishionerData!.parish!.address??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Parish priest name", widget.parishionerData!.parish!.parishPriestName??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Diocese", widget.parishionerData!.parish!.diocese!.name??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Town", widget.parishionerData!.parish!.town!.name??""),
                const SizedBox(height: 10),
                parishionerTextWidget("State", widget.parishionerData!.parish!.state!.name??""),
                const SizedBox(height: 10),
                parishionerTextWidget("Country", widget.parishionerData!.parish!.country!.name??""),
                const SizedBox(height: 10),
              ],
            ),
          ),
        )
    );
  }

  void moveToUpdatingScreen(){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=>
    UpdateParishionerPage(parishionerData: widget.parishionerData!)));
  }
}

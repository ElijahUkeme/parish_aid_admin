import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/widgets/general_widgets.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_event.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_state.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/parishioner_profile_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/widget/parishioner_text_widget.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';

import '../../../../core/utils/urls.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class GetParishionerPage extends StatefulWidget {
  const GetParishionerPage({Key? key,this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<GetParishionerPage> createState() => _GetParishionerPageState();
}

class _GetParishionerPageState extends State<GetParishionerPage> {
  ParishionerData? parishionerData;
  bool isLoading = false;
  bool isError = false;
  String parishionerId = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<ParishionerBloc, ParishionerState>(
        listener: (context, state) {
          if (state is GetParishionerLoading) {
            setState(() {
              isLoading = true;
              isError = false;
            });
          }
          else if (state is GetParishionerLoaded) {
            setState(() {
              isLoading = false;
              isError = false;
            });
            parishionerData = state.parishionerModel.response!.data;
            if(parishionerData !=null){
              Future.delayed(Duration.zero).then((value){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return ParishionerProfilePage(parishionerData: parishionerData);
                }));
              });
            }
          } else if (state is GetParishionerError) {
            isError = true;
            isLoading = false;
            toastInfo(msg: state.failure.message);
            if (context.mounted) {
              Future.delayed(Duration.zero).then((value) =>
                  Navigator.pop(context));
            }
          }

        },
        child: buildBody(size));
  }
  Widget buildBody(Size size){
    return SafeArea(
      child: Scaffold(
        appBar: appBar(''),
          backgroundColor: Colors.blue.shade900.withOpacity(0.8),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
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
                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding:  const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  alignment: Alignment.center,
                                  width: size.width * 0.9,
                                  height: size.height * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //logo & text
                                        logo(size.height / 15, size.height / 6),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        //richText("Show a Parish", 20),

                                        //email & password textField
                                        Stack(
                                          children: [
                                            buildInputFields(
                                                size,
                                                false,
                                                "",
                                                "Enter the Parishioner Id",
                                                false,
                                                    (value) {
                                                  parishionerId = value;
                                                }),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.08,
                                        ),

                                        //sign in button
                                        Visibility(
                                          visible: true,
                                          child: GestureDetector(
                                            onTap: () {
                                              getParishioner();
                                            },
                                            child: Stack(
                                              children: [
                                                triggerActionButtonBlue(
                                                    size, "Proceed"),
                                                Positioned(
                                                  bottom: 15,
                                                  left: 90,
                                                  child: Visibility(
                                                    visible: isLoading,
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
                                      ]))
                            ]))
                  ])))),
    );
  }

  void getParishioner(){
    BlocProvider.of<ParishionerBloc>(context).add(GetParishionerEvent(widget.parishId, parishionerId));
  }

}
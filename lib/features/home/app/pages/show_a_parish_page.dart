import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/app/pages/parish_details_page.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../bloc/home_event.dart';

class ShowAParishPage extends StatefulWidget {
  const ShowAParishPage({Key? key,this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<ShowAParishPage> createState() => _ShowAParishPageState();
}

class _ShowAParishPageState extends State<ShowAParishPage> {

  //String parishId = "";
  bool getParishLoading = false;
  bool getParishError = false;

  String errorText = "";

  //Success message
  String msg = "";

  @override
  void initState() {
    showParish();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc,HomeState>(builder: (context,state){

      pp(state.runtimeType);

      if (state is GetParishLoading) {
        getParishLoading = true;
        getParishError = false;
        errorText = "";
      } else if (state is GetParishLoaded) {
        getParishLoading = false;
        getParishError = false;
        errorText = "";
        toastInfo(msg: state.parishModel.response!.message!);
          Future.delayed(const Duration(seconds: 1)).then((value) => {
            if(context.mounted){
              if(state.parishModel.response!.data !=null){
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute<void>(builder: (BuildContext context) {
              return ParishDetailPage(
                  parishData: state.parishModel.response!.data!
              );
            }))
              }
            }
          });
      } else if (state is GetParishError) {
        getParishLoading = false;
        getParishError = true;
        errorText = state.failure.message;
        toastInfo(msg: errorText);
        Navigator.pop(context);
      }
      return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Center(child: CircularProgressIndicator(color: Colors.blue.shade900.withOpacity(0.8),),))),
      );
    });
  }

  void showParish() {
    if(widget.parishId.isEmptyOrNull){
      toastInfo(msg: "Parish Id was not sent");
      Navigator.pop(context);
    }else{
      BlocProvider.of<HomeBloc>(context).add(GetParishEvent(parish: widget.parishId!));
    }
  }
}

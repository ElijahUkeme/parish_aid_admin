import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';

import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/widgets/verification_code_widget.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../data/model/verification_code_model.dart';

class ShowAllVerificationCodePage extends StatefulWidget {
  const ShowAllVerificationCodePage({Key? key,this.parishId}) : super(key: key);

  final String? parishId;

  @override
  State<ShowAllVerificationCodePage> createState() => _ShowAllVerificationCodePageState();
}

class _ShowAllVerificationCodePageState extends State<ShowAllVerificationCodePage> {

  bool loading = true;
  List<VerificationCodeData>? data;

  @override
  void initState() {
    super.initState();
    getVCodeList();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(builder: (context,state){
      if(state is GetVerificationCodeListLoading){

        if(data ==null){
          loading = true;
        }
      }else if(state is GetVerificationCodeListLoaded){
        data = state.model.response!.data;
        loading = false;
        if(data!.isEmpty){
          Navigator.pop(context);
          toastInfo(msg: "The list is empty");
        }
      }else if(state is GetVerificationCodeListError){
        loading = false;
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (context.mounted)
            {
              Navigator.pop(context),
              showCustomTopSnackBar(context,
                  message: state.failure.message, color: Colors.red)
            }
        });
      }
      return loading || data==null
          ? Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade900.withOpacity(0.8),
          ),
        ),
      )
          : Scaffold(
        appBar: appBar(),
        body: body(),
      );
    });
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [codeData()],
      ),
    );
  }

  Widget codeData() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data!.length,
      itemBuilder: (BuildContext context, int index) {
        //final Color color = CardPage.colors[index];
        return VerificationCodeWidget(data: data![index]);
      },
    );
  }

  void getVCodeList(){
    BlocProvider.of<HomeBloc>(context).add(GetVerificationCodeListEvent(int.parse(widget.parishId!)));
  }
}

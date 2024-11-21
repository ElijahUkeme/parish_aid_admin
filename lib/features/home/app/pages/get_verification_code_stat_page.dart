import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/app/widgets/verification_code_stat_card.dart';

import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../data/model/verification_code_stat_model.dart';

class GetVerificationCodeStatPage extends StatefulWidget {
  const GetVerificationCodeStatPage({Key? key,this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<GetVerificationCodeStatPage> createState() => _GetVerificationCodeStatPageState();
}

class _GetVerificationCodeStatPageState extends State<GetVerificationCodeStatPage> {

  List<VerificationCodeStatData>? data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getVCodeStatList();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(builder: (context,state){
      if(state is GetVerificationCodeStatLoading){
        print('Loading...........');
          loading = true;
      }else if(state is GetVerificationCodeStatLoaded){
        print('Loaded............');
        data = state.model.response.data;
        loading = false;
        if(data!.isEmpty){
          Navigator.pop(context);
          toastInfo(msg: "The list is empty");
        }
      }else if(state is GetVerificationCodeStatError){
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
      return loading
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
        children: [vCodeStatData()],
      ),
    );
  }
  Widget vCodeStatData() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data!.length,
      itemBuilder: (BuildContext context, int index) {
        return VerificationCodeStatCard(data: data![index]);
      },
    );
  }

  void getVCodeStatList(){
    BlocProvider.of<HomeBloc>(context).add(GetVerificationCodeStatEvent(int.parse(widget.parishId!)));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_event.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_state.dart';
import 'package:parish_aid_admin/features/parishioner/app/widget/parishioners_card_widget.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_list_model.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';

import '../../../../core/widgets/custom_top_snackbar.dart';

class ShowAllParishionersPage extends StatefulWidget {
  const ShowAllParishionersPage({Key? key,required this.parishId}) : super(key: key);
   //ParishionerData parishionerData;

  final String parishId;


  @override
  State<ShowAllParishionersPage> createState() => _ShowAllParishionersPageState();
}

class _ShowAllParishionersPageState extends State<ShowAllParishionersPage> {

  ParishionerListModel? parishionerListModel;
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("The parishId received is ${widget.parishId}");
    fetchAllParishioners();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ParishionerBloc,ParishionerState>(builder: (context,state){
      if(state is GetParishionersLoading){
        if(parishionerListModel ==null){
          isLoading = true;
          isError = false;
        }
      }else if(state is GetParishionersLoaded){
        isLoading = false;
        isError = false;
        parishionerListModel = state.parishionerListModel;
        if(parishionerListModel!.response!.data!.isEmpty){
          toastInfo(msg: "Empty List");
          if(context.mounted){
            Future.delayed(Duration.zero).then((value) => Navigator.pop(context));
          }
        }

      }else if(state is GetParishionerError){
        isLoading = false;
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (context.mounted)
            {
              showCustomTopSnackBar(context,
                  message: state.failure.message, color: Colors.red)
            }
        });
      }
      return isLoading|| parishionerListModel==null
          ? Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade900.withOpacity(0.8),
          ),
        ),
      )
          : Scaffold(
        body: body());
    });
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [parishionersData()],
      ),
    );
  }

  Widget parishionersData() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: parishionerListModel!.response!.data!.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return  ParishionersCardWidget(parishionerData: parishionerListModel!.response!.data![index]);
      },
    );
  }
  void fetchAllParishioners(){
    BlocProvider.of<ParishionerBloc>(context).add(GetParishionersEvent(widget.parishId));
  }
}

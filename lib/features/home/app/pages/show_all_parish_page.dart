import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/app/pages/parish_card_data.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart' as pModel;

import '../../../../core/widgets/custom_top_snackbar.dart';


class ShowAllParishPage extends StatefulWidget {
  const ShowAllParishPage({Key? key}) : super(key: key);



  @override
  State<ShowAllParishPage> createState() => _ShowAllParishPageState();
}

class _ShowAllParishPageState extends State<ShowAllParishPage> {

  final Color color = Colors.blue.shade900.withOpacity(0.8);
  bool fetchLoading = true;
  pModel.ParishModel? parishModel;



  @override
  void initState() {
    super.initState();
    fetchAllParish();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(builder: (context,state){
      if(state is GetParishesLoading){
        if(parishModel ==null){
          fetchLoading = true;
        }
      }else if(state is GetParishesLoaded){
        parishModel = state.parishModel;
        fetchLoading = false;
      }else if(state is GetParishesError){
        fetchLoading = false;
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (context.mounted)
            {
              showCustomTopSnackBar(context,
                  message: state.failure.message, color: Colors.red)
            }
        });
      }
       return fetchLoading
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
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [data()],
      ),
    );
  }
  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }

  Widget data() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: parishModel!.response!.data!.length,
      itemBuilder: (BuildContext context, int index) {
        //final Color color = CardPage.colors[index];
        return ParishCardData(parishData: parishModel!.response!.data![index]);
      },
    );
  }
  void fetchAllParish(){
    BlocProvider.of<HomeBloc>(context).add(GetParishesEvent());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/group/app/page/group_double_card.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_bloc.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_state.dart';

import '../../../../core/utils/color.dart';
import '../../../home/app/widgets/double_card.dart';
import '../../../users/app/bloc/user_auth_event.dart';
import '../../../users/data/models/user_account_fetch_model.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  UserAccountFetchModel? userAccountFetchModel;
  bool fetchLoading = true;
  bool fetchGroupError = false;

  @override
  void initState() {
    super.initState();
    fetchAccount();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAuthBloc, UserAuthState>(builder: (context, state) {
      pp(state.runtimeType);
      if (state is UserFetchAccountLoading) {
        if (userAccountFetchModel == null) {
          fetchLoading = true;
        }
      } else if (state is UserFetchAccountLoaded) {
        userAccountFetchModel = state.userAccountFetchModel;

        fetchLoading = false;
      } else if (state is UserFetchAccountError) {
        fetchLoading = false;
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
        children: [heading(), data(),groupHeading(),groupData()],
      ),
    );
  }

  void fetchAccount() {
    BlocProvider.of<UserAuthBloc>(context).add(UserFetchAccountEvent());
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }

  Widget heading() {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0, left: 20.0),
      child: Text(
        "Your Parishes",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget groupHeading() {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0, left: 20.0),
      child: Text(
        "Your Groups",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget data() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userAccountFetchModel==null?0:userAccountFetchModel!.response!.data!.parish!.length,
      itemBuilder: (BuildContext context, int index) {
        return DoubleCard(
            parish: userAccountFetchModel!.response!.data!.parish![index]);
      },
    );
  }

  Widget groupData() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userAccountFetchModel!.response!.data!.groups!.length,
        itemBuilder: (BuildContext context, int index) {
          return GroupDoubleCard(groupData: userAccountFetchModel!.response!.data!.groups![index]);
        });
  }
}


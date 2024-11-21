import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../bloc/group_bloc.dart';
import '../bloc/group_state.dart';

class UpdateGroupAdminPage extends StatefulWidget {
  const UpdateGroupAdminPage({Key? key, required this.data, this.parishId})
      : super(key: key);

  final GroupAdminData data;
  final int? parishId;

  @override
  State<UpdateGroupAdminPage> createState() => _UpdateGroupAdminPageState();
}

class _UpdateGroupAdminPageState extends State<UpdateGroupAdminPage> {
  bool loading = false;

  String name = '';
  String email = '';
  String groupId = '';
  String role = '';

  @override
  void initState() {
    name = widget.data.group!.name!;
    email = widget.data.group!.email!;
    groupId = widget.data.group!.id.toString();
    role = widget.data.role!;
    pp('The sent parish Id is ${widget.parishId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is UpdateGroupAdminLoading) {
            setState(() {
              loading = true;
            });
          } else if (state is UpdateGroupAdminLoaded) {
            setState(() {
              loading = false;
            });
            toastInfo(msg: 'Group Admin Updated Successfully');
            Navigator.pop(context);
          } else if (state is UpdateGroupAdminError) {
            setState(() {
              loading = false;
            });
            toastInfo(msg: state.failure.message);
          }
        },
        child: Scaffold(
            backgroundColor: Colors.blue.shade900.withOpacity(0.8),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: SizedBox(
                    height: size.height,
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
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
                      const SizedBox(height: 65),
                      //card and footer ui
                      Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                alignment: Alignment.center,
                                width: size.width * 0.9,
                                height: size.height * 0.6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.white,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        //logo & text
                                        logo(size.height / 10, size.height / 6),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        //richText("Show a Parish", 20),

                                        //email & password textField
                                        Stack(
                                          children: [
                                            buildUpdateInputFields(
                                                size: size * 1.2,
                                                isParish: false,
                                                input: "Name",
                                                textHint: "Enter the name",
                                                isObscured: false,
                                                initialText: name,
                                                func: (value) {
                                                  name = value;
                                                }),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Stack(
                                          children: [
                                            buildUpdateInputFields(
                                                size: size * 1.2,
                                                isParish: false,
                                                input: "Email",
                                                textHint: "Enter the Email",
                                                isObscured: false,
                                                initialText: email,
                                                func: (value) {
                                                  email = value;
                                                }),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Stack(
                                          children: [
                                            buildUpdateInputFields(
                                                size: size * 1.2,
                                                isParish: false,
                                                input: "Role",
                                                textHint: "Enter the Role",
                                                isObscured: false,
                                                initialText: role,
                                                func: (value) {
                                                  role = value;
                                                }),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Stack(
                                          children: [
                                            buildUpdateInputFields(
                                                size: size * 1.2,
                                                isParish: false,
                                                input: "Group Id",
                                                textHint: "Enter the group Id",
                                                isObscured: false,
                                                initialText: groupId,
                                                func: (value) {
                                                  groupId = value;
                                                }),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.05,
                                        ),

                                        //sign in button
                                        Visibility(
                                          visible: true,
                                          child: GestureDetector(
                                            onTap: () {
                                              updateGroupAdmin();
                                            },
                                            child: Stack(
                                              children: [
                                                triggerActionButtonBlue(
                                                    size, "Update"),
                                                Positioned(
                                                  bottom: 15,
                                                  left: 90,
                                                  child: Visibility(
                                                    visible: loading,
                                                    child:
                                                        buildLoadingIndicator(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.8)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                        ),
                                      ]),
                                ))
                          ]))
                    ])))));
  }

  void updateGroupAdmin() {
    if (name.isEmptyOrNull) {
      showCustomTopSnackBar(context, message: 'Name required');
    } else if (email.isEmptyOrNull) {
      showCustomTopSnackBar(context, message: 'Email required');
    } else if (groupId == null) {
      showCustomTopSnackBar(context, message: 'Group Id required');
    } else if (role.isEmptyOrNull) {
      showCustomTopSnackBar(context, message: 'Role required');
    } else if (widget.parishId == null) {
      showCustomTopSnackBar(context,
          message: 'Parish Id was not sent, try again later');
    } else {
      pp('The name is $name');
      BlocProvider.of<GroupBloc>(context).add(UpdateGroupAdminEvent(
          group: int.parse(groupId),
          parish: widget.parishId!,
          admin: widget.data.id!,
          email: email,
          name: name,
          role: role,
          groupId: int.parse(groupId)));
    }
  }
}

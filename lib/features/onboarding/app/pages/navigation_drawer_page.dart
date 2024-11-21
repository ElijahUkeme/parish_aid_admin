import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/navigation_route_page.dart';

import '../../../../core/helpers/txt.dart';
import '../../../home/app/widgets/drawer_menu.dart';
import '../../../users/data/models/user_account_fetch_model.dart';

class NavigationDrawerPage extends StatefulWidget {

  const NavigationDrawerPage({Key? key}) : super(key: key);

  @override
  _NavigationDrawerPage createState() => _NavigationDrawerPage();
}

class _NavigationDrawerPage extends State<NavigationDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      //body: body(),
      //drawer: const ComplexDrawer(),
      drawerScrimColor: Colors.transparent,
      //backgroundColor: Colorz.compexDrawerCanvasColor,
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: IconTheme.of(context).copyWith(
        //color: Colors.white.withOpacity(0.8),
      ),
      title: Txt(
        text: "",
        color: Colors.white.withOpacity(0.5),
      ),
      //backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }

  Widget body() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          "assets/images/catholic.webp",
          fit: BoxFit.cover,
        ));
  }
}

class ComplexDrawer extends StatefulWidget {
  final Parish parish;
  const ComplexDrawer({Key? key,required this.parish}) : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  int selectedIndex = -1; //dont set it to 0

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double width = 270;
    return Container(
      width: width,
      color: Colors.blue.shade900.withOpacity(0.8),
      child: row(),
    );
  }

  Widget row() {
    return Row(children: [
       blackIconTiles()
          //: blackIconMenu(),
      //invisibleSubMenus(),
    ]);
  }

  Widget blackIconTiles() {
    return Container(
      width: 270,
      margin: const EdgeInsets.only(top: 10,bottom: 20),
      color: Colors.blue.shade900.withOpacity(0.10),
      child: Column(
        children: [
          //controlTile(),
          Expanded(
            child: ListView.builder(
              itemCount: cdms.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();

                CDM cdm = cdms[index];
                bool selected = selectedIndex == index;
                return ExpansionTile(
                    onExpansionChanged: (z) {
                      setState(() {
                        selectedIndex = z ? index : -1;
                      });
                    },
                    leading: Icon(cdm.icon, color: Colors.white),
                    title: Txt(
                      text: cdm.title,
                      color: Colors.white,
                    ),
                    trailing: cdm.submenus.isEmpty
                        ? null
                        : Icon(
                      selected
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    children: cdm.submenus.map((subMenu) {
                      return sMenuButton(subMenu, false);
                    }).toList());
              },
            ),
          ),
          //accountTile(),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: ListTile(
        leading: Image.asset("assets/images/parish_aid_spot.png"),
        title: const Txt(
          text: "ParishAid",
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        onTap: expandOrShrinkDrawer,
      ),
    );
  }

  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: 100,
      color: Colors.blue.shade900.withOpacity(0.8),
      child: Column(
        children: [
          controlButton(),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (contex, index) {
                  // if(index==0) return controlButton();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Icon(cdms[index].icon, color: Colors.white),
                    ),
                  );
                }),
          ),
          //accountButton(),
        ],
      ),
    );
  }

  Widget invisibleSubMenus() {
    // List<CDM> _cmds = cdms..removeAt(0);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: isExpanded ? 0 : 125,
      child: Column(
        children: [
          Container(height: 95),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (context, index) {
                  CDM cmd = cdms[index];
                  // if(index==0) return Container(height:95);
                  //controll button has 45 h + 20 top + 30 bottom = 95

                  bool selected = selectedIndex == index;
                  bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
                  return subMenuWidget(
                      [cmd.title]..addAll(cmd.submenus), isValidSubMenu);
                }),
          ),
        ],
      ),
    );
  }

  Widget controlButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrShrinkDrawer,
        child: Container(
            height: 45,
            alignment: Alignment.center,
            child: Image.asset("assets/images/parish_aid_spot.png")),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 57.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu
              ? Colors.blue.shade900.withOpacity(0.8)
              : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return sMenuButton(subMenu, index == 0);
          }),
    );
  }

  Widget sMenuButton(String subMenu, bool isTitle) {
    return InkWell(
      onTap: () {
        //handle the function
        //if index==0? donothing: doyourlogic here
        pp("The tapped sub menu is ${subMenu.toString()}");
        navigate(context, subMenu,widget.parish);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: Txt(
            text: subMenu,
            fontSize: isTitle ? 17 : 14,
            color: isTitle ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Widget accountButton({bool usePadding = true}) {
  //   return Padding(
  //     padding: EdgeInsets.all(usePadding ? 8 : 0),
  //     child: AnimatedContainer(
  //       duration: Duration(seconds: 1),
  //       height: 45,
  //       width: 45,
  //       decoration: BoxDecoration(
  //         color: Colors.white70,
  //         image: const DecorationImage(
  //           image: NetworkImage(""),
  //           fit: BoxFit.cover,
  //         ),
  //         borderRadius: BorderRadius.circular(6),
  //       ),
  //     ),
  //   );
  // }

  // Widget accountTile() {
  //   return Container(
  //     color: Colorz.complexDrawerBlueGrey,
  //     child: ListTile(
  //       leading: accountButton(usePadding: false),
  //       title: Txt(
  //         text: "Elijah Ukeme",
  //         color: Colors.white,
  //       ),
  //       subtitle: Txt(
  //         text: "Mobile Developer",
  //         color: Colors.white70,
  //       ),
  //     ),
  //   );
  // }

  static List<CDM> cdms = [
    // CDM(Icons.grid_view, "Control", []),

    CDM(Icons.church, "Parish", [
      "Create a Parish",
      //"Show All Parish",
      "Show a Parish",
      "Update a Parish",
      //"Approve a Parish",
      "Delete a Parish"
    ]),
    CDM(Icons.subscriptions, "Billing", [
      "Show All Billings",
      "Show a Billing",
      //"Create a Billing",
      //"Update a Billing",
      //"Delete a Billing"
    ]),
    //CDM(Icons.subscriptions, "Plan Benefit", ["All Plans", "Save a Plan"]),
    CDM(
      Icons.person,
      "Parishioner",
      [
        "Create a Parishioner",
        "Get all Parishioners",
        "Show a Parishioner",
        "Delete a Parishioner"
      ],
    ),
    // CDM(Icons.church, "Parish Registration", [
    //   "Register a Parish",
    //   "Get a Parish",
    //   "Get Parish Details",
    //   "Get Parish by Uid"
    // ]),

    CDM(Icons.group, "Group Admin", [
      "Get all Group Admin",
      "Create a Group Admin",
    ]),
    CDM(Icons.group, "Group", [
      "Create a Group",
      "Get all Groups",
      "Show a Group",
    ]),
    CDM(Icons.settings, "Verification Code", [
      "Create a Verification Code",
      "Get all Verification Code",
      "Get Statistics",
      "Show Verification Code",
      "Delete a Verification Code"
    ]),
    // CDM(Icons.money, "Transactions",
    //     ["Get all Transactions", "Show a Transaction"]),
    // CDM(Icons.grid_view, "Billing Plans", ["Get all Plans", "Show a Plan"]),
    CDM(Icons.grid_view, "Subscriptions",
        ["Get Subscription List", "Show a Subscription"]),
    // CDM(Icons.church, "Diocese", [
    //   "Get all Diocese",
    //   "Show a Diocese",
    // ]),
    // CDM(Icons.location_on, "Location", ["Get States", "Get LGAs", "Get Towns"]),
  ];

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

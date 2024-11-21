//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../core/helpers/txt.dart';
// import '../../../../core/utils/color.dart';
// import '../../../../core/utils/urls.dart';
// import '../../../home/app/widgets/drawer_menu.dart';
//
// class ComplexDrawerPage extends StatefulWidget {
//   const ComplexDrawerPage({Key? key}) : super(key: key);
//
//   @override
//   _ComplexDrawerPageState createState() => _ComplexDrawerPageState();
// }
//
// class _ComplexDrawerPageState extends State<ComplexDrawerPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(),
//       body: body(),
//       drawer: const ComplexDrawerUI(),
//       drawerScrimColor: Colors.transparent,
//       backgroundColor: Colorz.compexDrawerCanvasColor,
//     );
//   }
//
//   AppBar appBar() {
//     return AppBar(
//       iconTheme: IconTheme.of(context).copyWith(
//         color: Colorz.complexDrawerBlack,
//       ),
//       title: const Txt(
//         text: "Navigation Drawer",
//         color: Colorz.complexDrawerBlack,
//       ),
//       backgroundColor: Colorz.compexDrawerCanvasColor,
//     );
//   }
//
//   Widget body() {
//     return Center(
//       child: Container(
//         foregroundDecoration: const BoxDecoration(
//           color: Colorz.complexDrawerBlack,
//           backgroundBlendMode: BlendMode.saturation,
//         ),
//         child: const FlutterLogo(
//           size: 150,
//         ),
//       ),
//     );
//   }
// }
//
// class ComplexDrawerUI extends StatefulWidget {
//   const ComplexDrawerUI({Key? key}) : super(key: key);
//
//   @override
//   _ComplexDrawerState createState() => _ComplexDrawerState();
// }
//
// class _ComplexDrawerState extends State<ComplexDrawerUI> {
//   int selectedIndex = -1; //dont set it to 0
//
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     double width = 270;
//     return Container(
//       width: width,
//       color: Colors.blue.shade900.withOpacity(0.8),
//       child: row(),
//     );
//   }
//
//   Widget row() {
//     return Row(children: [
//       blackIconTiles() ,
//     ]);
//   }
//
//   Widget blackIconTiles() {
//     return Container(
//       width: 270,
//       margin: const EdgeInsets.only(top: 10,bottom: 20),
//       color: Colors.blue.shade900.withOpacity(0.10),
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cdms.length,
//               itemBuilder: (BuildContext context, int index) {
//                 //  if(index==0) return controlTile();
//
//                 CDM cdm = cdms[index];
//                 bool selected = selectedIndex == index;
//                 return ExpansionTile(
//                     onExpansionChanged: (z) {
//                       setState(() {
//                         selectedIndex = z ? index : -1;
//                       });
//                     },
//                     leading: Icon(cdm.icon, color: Colors.white),
//                     title: Txt(
//                       text: cdm.title,
//                       color: Colors.white,
//                     ),
//                     trailing: cdm.submenus.isEmpty
//                         ? null
//                         : Icon(
//                       selected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                       color: Colors.white,
//                     ),
//                     children: cdm.submenus.map((subMenu) {
//                       return sMenuButton(subMenu, false);
//                     }).toList());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget blackIconMenu() {
//     return AnimatedContainer(
//       duration: const Duration(seconds: 1),
//       width: 100,
//       color: Colorz.complexDrawerBlack,
//       child: Column(
//         children: [
//           //controlButton(),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: cdms.length,
//                 itemBuilder: (context, index) {
//                   // if(index==0) return controlButton();
//                   return InkWell(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                     },
//                     child: Container(
//                       height: 45,
//                       alignment: Alignment.center,
//                       child: Icon(cdms[index].icon, color: Colors.white),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget sMenuButton(String subMenu, bool isTitle) {
//     return InkWell(
//       onTap: () {
//
//         //handle the function
//         //if index==0? donothing: doyourlogic here
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           margin: const EdgeInsets.only(left: 15),
//           alignment: Alignment.centerLeft,
//           child: Txt(
//             text: subMenu,
//             fontSize: isTitle ? 17 : 14,
//             color: isTitle ? Colors.white : Colors.grey,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   static List<CDM> cdms = [
//     // CDM(Icons.grid_view, "Control", []),
//
//     // CDM(Icons.church, "Parish", [
//     //   "Create a Parish",
//     //   "Show All",
//     //   "Show One",
//     //   "Update a Parish",
//     //   "Approve a Parish",
//     //   "Delete a Parish"
//     // ]),
//     // CDM(Icons.subscriptions, "Billing", [
//     //   "Show All",
//     //   "Show One",
//     //   "Create a Billing",
//     //   "Update a Billing",
//     //   "Delete a Billing"
//     // ]),
//     // CDM(Icons.subscriptions, "Plan Benefit", ["All Plans", "Save a Plan"]),
//     // CDM(
//     //   Icons.person,
//     //   "Parishioner",
//     //   [
//     //     "Register a Parishioner",
//     //     "Preview a Parishioner",
//     //     "Update a Parishioner",
//     //     "Get all Parishioners",
//     //     "Show a Parishioner",
//     //     "Delete a Parishioner"
//     //   ],
//     // ),
//     // CDM(Icons.church, "Parish Registration", [
//     //   "Register a Parish",
//     //   "Get a Parish",
//     //   "Get Parish Details",
//     //   "Get Parish by Uid"
//     // ]),
//     //
//     // CDM(Icons.group, "Group Admin", [
//     //   "Update Group Admin",
//     //   "Get all Group Admin",
//     //   "Show a Group Admin",
//     //   "Delete a Group Admin",
//     //   "Create a Group Admin",
//     // ]),
//     // CDM(Icons.group, "Group", [
//     //   "Update a Group",
//     //   "Get all Groups",
//     //   "Show a Group",
//     //   "Delete a Group",
//     //   "Create a Group"
//     // ]),
//     // CDM(Icons.settings, "Verification Code", [
//     //   "Create a Verification Code",
//     //   "Get all Verification Code",
//     //   "Get Statistics",
//     //   "Show Verification Code",
//     //   "Delete a Verification Code"
//     // ]),
//     // CDM(Icons.money, "Transactions",
//     //     ["Get all Transactions", "Show a Transaction"]),
//     // CDM(Icons.grid_view, "Billing Plans", ["Get all Plans", "Show a Plan"]),
//     // CDM(Icons.grid_view, "Subscriptions",
//     //     ["Get Subscription List", "Show a Subscription"]),
//     // CDM(Icons.church, "Diocese", [
//     //   "Get all Diocese",
//     //   "Show a Diocese",
//     // ]),
//     // CDM(Icons.location_on, "Location", ["Get States", "Get LGAs", "Get Towns"]),
//   ];
//
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/urls.dart';

import '../../data/model/parishioner_model.dart';
import '../page/show_all_parishioners_page.dart';

class ParishionersCardWidget extends StatelessWidget {
   ParishionersCardWidget({Key? key,required this.parishionerData}) : super(key: key);

  ParishionerData parishionerData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: GestureDetector(
        onTap: () {
          print("The card item is clicked");
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return const ShowAllParishionersPage(parishId: "",
               //parishionerData: parishionerData
            );
          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: Colors.grey,
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(child: parishionerData.image==null?Image.asset(Urls.defaultProfileImage):Image.network(parishionerData.image!))
                ),
                const SizedBox(width: 10,),
                Text(parishionerData.name!,style: Theme.of(context).textTheme.labelMedium)
              ],
            )),
      ),
    );
  }
}

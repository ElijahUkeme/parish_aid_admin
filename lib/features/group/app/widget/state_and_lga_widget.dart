
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';

class StateAndLgaWidget extends StatefulWidget {
  const StateAndLgaWidget({Key? key}) : super(key: key);

  @override
  State<StateAndLgaWidget> createState() => _StateAndLgaWidgetState();
}

class _StateAndLgaWidgetState extends State<StateAndLgaWidget> {

  String stateValue = NigerianStatesAndLGA.allStates[0];
  String lgaValue = 'Select a Local Government Area';
  String selectedLGAFromAllLGAs = NigerianStatesAndLGA.getAllNigerianLGAs()[0];
  List<String> statesLga = [];
  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a Nigerian state',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                  key: const ValueKey('States'),
                  value: stateValue,
                  isExpanded: true,
                  hint: const Text('Select a Nigerian state'),
                  items: NigerianStatesAndLGA.allStates
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (val) {
                    lgaValue = 'Select a Local Government Area';
                    statesLga.clear();
                    statesLga.add(lgaValue);
                    statesLga.addAll(NigerianStatesAndLGA.getStateLGAs(val!));
                    setState(() {
                      stateValue = val;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                  key: const ValueKey('Local governments'),
                  value: lgaValue,
                  isExpanded: true,
                  hint: const Text('Select a Lga'),
                  items:
                  statesLga.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      lgaValue = val!;
                    });
                  }),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Select a Local Government Area from all Nigerian LGAs',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                  value: selectedLGAFromAllLGAs,
                  isExpanded: true,
                  hint: const Text('Select a Lga'),
                  items: NigerianStatesAndLGA.getAllNigerianLGAs()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedLGAFromAllLGAs = val!;
                    });
                  }),
            ]);
  }
}

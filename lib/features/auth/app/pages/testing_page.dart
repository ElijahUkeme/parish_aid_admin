import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:segmented_progress_bar/segmented_progress_bar.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPage();
}

class _TestingPage extends State<TestingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SegmentedProgressBar(
            segments: socialSegments3,
          ),
        ),
      ),
    );
  }

  List<ProgressSegment> get socialSegments => [
    ProgressSegment(value: 1, color: Colors.pink, label: '0',isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.indigo, label: '1', isAbove: false),
    ProgressSegment(value: 1, color: Colors.redAccent, label: '2'),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '3', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '4', isAbove: false, ),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '5', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '6', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '7', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '8', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '9', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '10', isAbove: false),
  ];

  List<ProgressSegment> get socialSegments1 => [
    ProgressSegment(value: 1, color: Colors.pink, label: '0',isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.indigo, label: '1', isAbove: false),
    ProgressSegment(value: 1, color: Colors.redAccent, label: '2'),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '3', isAbove: false),
    ProgressSegment(
      value: 3, color: Colors.lightBlue, label: '4', isAbove: false, ),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '5', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '6', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '7', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '8', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '9', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '10', isAbove: false),
  ];

  List<ProgressSegment> get socialSegments2 => [
    ProgressSegment(value: 1, color: Colors.pink, label: '0',isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.indigo, label: '1', isAbove: false),
    ProgressSegment(value: 1, color: Colors.redAccent, label: '2'),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '3', isAbove: false),
    ProgressSegment(
      value: 3, color: Colors.lightBlue, label: '4', isAbove: false, ),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '5', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.lightBlue, label: '6', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '7', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '8', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '9', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.white, label: '10', isAbove: false),
  ];

  List<ProgressSegment> get socialSegments3 => [
    ProgressSegment(value: 1, color: Colors.red, label: '0',isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.indigo, label: '1', isAbove: false),
    ProgressSegment(value: 1, color: Colors.redAccent, label: '2'),
    ProgressSegment(
        value: 3, color: Colors.redAccent, label: '3', isAbove: false),
    ProgressSegment(
      value: 3, color: Colors.brown.shade900, label: '4', isAbove: false, ),
    ProgressSegment(
        value: 3, color: Colors.brown, label: '5', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.yellowAccent.withOpacity(0.9), label: '6', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.greenAccent, label: '7', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.greenAccent, label: '8', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.green, label: '9', isAbove: false),
    ProgressSegment(
        value: 3, color: Colors.green, label: '10', isAbove: false),
  ];

}

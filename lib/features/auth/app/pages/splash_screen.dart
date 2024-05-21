import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/auth/app/pages/auth_page.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/create_parish_page.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/navigation_drawer_page.dart';

import '../../../../core/helpers/txt.dart';
import '../widgets/auth_page_widgets.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //bool showAnimationTile = false;
  bool showHorizontalCircleLabelsAndBackground = false;

  // List<IconData> horizontalCircleIcons = [];
  List<IconData> horizontalCircleIconsLeft = [];
  List<IconData> horizontalCircleIconsRight = [];
  IconData? selectedHorizontalIcon;
  static const List<String> horizontalCircleLabelsisLeft = [
    "Receive",
    "Send",
  ];
  static const List<String> horizontalCircleLabelsisRight = [
    "Exchange",
    "React",
  ];

  bool showActive = false;
  bool showAnimationTile1 = false;
  bool showAnimationTile2 = false;
  bool showNoAnalytics = false;
  bool showAnimationTile3 = false;
  bool showAnimationTitle4 = false;
  bool showLogo = false;
  bool showButton = false;

//keys for animatedlists
  final GlobalKey<AnimatedListState> horizontalCirclesKeyLeft = GlobalKey();
  final GlobalKey<AnimatedListState> horizontalCirclesKeyRight = GlobalKey();

  final GlobalKey<AnimatedListState> primaryListKey = GlobalKey();

  @override
  void initState() {
    startAnimations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/catholic.webp"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.blue.shade900.withOpacity(0.7),
            ),
            const SizedBox(height: 65),
            //Positioned(top: 75, child: horizontalCircles()),
            Positioned(
              top: 220,
              left: 50,
              right: 50,
              child: Visibility(
                visible: showLogo,
                child: Center(
                    child: Container(
                        height: 270,
                        width: 260,
                        child: Image.asset(
                            "assets/images/parish_aid_horiz_w_trans.png"))),
              ),
            ),
            Visibility(
              visible: showButton,
              child: Positioned(
                  left: 50,
                  right: 50,
                  bottom: 100,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthPage(),
                        ),
                      );
                    },
                    child: triggerActionButtonWhite(size, "Get Started",
                        color: Colors.white),
                  )),
            )
          ],
        ));
  }

  // Widget horizontalCircles() {
  //   return AnimatedContainer(
  //     duration: duration,
  //     //color:
  //     //  showHorizontalCircleLabelsAndBackground ? Colors.white : Colors.white,
  //     child: Row(children: [
  //       horizontalCircleListView(),
  //       horizontalCircleListView(isLeft: false),
  //     ]),
  //   );
  // }

  Widget horizontalCircleListView({bool isLeft = true}) {
    return Container(
      height: 80,
      //color: Colors.blue.shade900.withOpacity(0.8),
      width: MediaQuery.of(context).size.width / 2,
      child: AnimatedList(
        reverse: isLeft,
        key: isLeft ? horizontalCirclesKeyLeft : horizontalCirclesKeyRight,
        scrollDirection: Axis.horizontal,
        initialItemCount:
            (isLeft ? horizontalCircleIconsLeft : horizontalCircleIconsRight)
                .length,
        itemBuilder: (context, index, animation) {
          IconData icon = isLeft
              ? horizontalCircleIconsLeft[index]
              : horizontalCircleIconsRight[index];
          return horizontalCircle(index, animation, icon, isLeft);
        },
      ),
    );
  }

  Widget horizontalCircle(
      int index, Animation<double> animation, IconData icon, bool isLeft) {
    bool selected = selectedHorizontalIcon == icon;
    Color selectedColor = (randomColors..shuffle())[0];
    return AnimatedContainer(
      height: 80,
      width: MediaQuery.of(context).size.width / (animation.value == 0 ? 2 : 4),
      duration: duration,
      alignment: Alignment.center,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: Column(
            children: [
              //circle avatar
              InkWell(
                borderRadius: BorderRadius.circular(360),
                onTap: () {
                  setState(() {
                    selectedHorizontalIcon = selected ? null : icon;
                  });
                },
                child: AnimatedContainer(
                  duration: duration,
                  padding: EdgeInsets.all(animation.value == 0 ? 0 : 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: animation.value == 0
                        ? Colors.blue.shade900
                        : (selected ? selectedColor : Colors.blue.shade900),
                  ),
                  child: RotationTransition(
                      turns: animation, child: Icon(icon, color: Colors.white)),
                ),
              ),
              //label
              AnimatedContainer(
                duration: duration,
                padding: EdgeInsets.all(
                    showHorizontalCircleLabelsAndBackground ? 4 : 0),
                child: AnimatedOpacity(
                  opacity: showHorizontalCircleLabelsAndBackground ? 1 : 0,
                  duration: duration,
                  child: Txt(
                    text: isLeft
                        ? horizontalCircleLabelsisLeft[index]
                        : horizontalCircleLabelsisRight[index],
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget plainTile(String label, bool visible) {
    return AnimatedContainer(
      duration: duration,
      padding: EdgeInsets.symmetric(vertical: visible ? 12 : 0),
      child: AnimatedOpacity(
        duration: duration,
        opacity: visible ? 1 : 0,
        child: Card(
          color: Colors.transparent,
          child: ListTile(
            title: Txt(
              text: label,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
            //trailing: Icon(Icons.arrow_drop_up, size: 32, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget animatedLogo(Size size, bool visible) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: duration,
      child: AnimatedContainer(
        duration: duration,
      ),
    );
  }

  Widget animationLeading(IconData icon, Color color, bool showAnimationTile) {
    return AnimatedContainer(
      duration: duration,
      padding: EdgeInsets.all(showAnimationTile ? 8 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(showAnimationTile ? 360 : 8),
        color: showAnimationTile ? color : const Color(0xFF21899C),
        gradient: gradient(color),
      ),
      child: AnimatedOpacity(
          duration: duration,
          opacity: showAnimationTile ? 1 : 0,
          child: Icon(icon, color: Colors.white)),
    );
  }

  LinearGradient gradient(Color color) {
    return LinearGradient(
        end: Alignment.topRight,
        begin: Alignment.bottomRight,
        colors: [
          color.withAlpha(175),
          color,
        ]);
  }

//  static Duration duration150 = Duration(milliseconds:150);

//  static Duration duration300 = Duration(milliseconds:300);
  static Duration duration = Duration(milliseconds: 350);

//  static Duration duration2 = Duration(seconds:2);
//  static Duration duration3 = Duration(seconds:3);
//  static Duration duration5 = Duration(seconds:5);

  static List<Color> randomColors = [
    Colors.pink,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.amber,
  ];

  static Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 350));
  }

  void startAnimations() async {
    await delay();

    // setState(() => showLogo = true);
    // await delay();

    //setState(() => showAnimationTile = true);
    //await delay();

    await addHorizontalCircles();
    await delay();

    // setState(() => showActive = true);
    // await delay();

    // setState(() => showAnimationTile1 = true);
    // await delay();
    //
    // setState(() => showAnimationTile2 = true);
    // await delay();
    //
    // setState(() => showNoAnalytics = true);
    // await delay();
    //
    // setState(() => showAnimationTile3 = true);
    // await delay();
    //
    // setState(() => showAnimationTitle4 = true);
    // await delay();

    setState(() => showLogo = true);
    await delay();

    setState(() => showButton = true);
    await delay();
  }

  Future<void> addHorizontalCircles() async {
    horizontalCircleIconsLeft.add(Icons.south);
    horizontalCirclesKeyLeft.currentState?.insertItem(0, duration: duration);
    await delay();

    horizontalCircleIconsLeft.add(Icons.shortcut);
    horizontalCirclesKeyLeft.currentState?.insertItem(1, duration: duration);
    await delay();

    horizontalCircleIconsRight.add(Icons.cached);
    horizontalCirclesKeyRight.currentState?.insertItem(0, duration: duration);
    await delay();

    horizontalCircleIconsRight.add(Icons.north);
    horizontalCirclesKeyRight.currentState?.insertItem(1, duration: duration);
    await delay();

    showHorizontalCircleLabelsAndBackground = true;
    setState(() {});
  }

// 1) M̶a̶k̶e̶ t̶h̶e̶ m̶o̶n̶e̶y̶ t̶e̶x̶t̶ v̶i̶s̶i̶b̶l̶e̶ u̶s̶i̶n̶g̶ A̶n̶i̶m̶a̶t̶e̶d̶O̶p̶a̶c̶i̶t̶y̶
// 2) u̶s̶e̶ h̶o̶r̶i̶z̶o̶n̶t̶a̶l̶ a̶n̶i̶m̶a̶t̶e̶d̶ l̶i̶s̶t̶ a̶n̶d̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 1̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 2̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 0̶
// 	a̶d̶d̶ t̶o̶ i̶n̶d̶e̶x̶ 3̶
// 3) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶o̶p̶a̶c̶i̶t̶y̶ t̶o̶ m̶a̶k̶e̶ a̶c̶t̶i̶v̶e̶ v̶i̶s̶i̶b̶l̶e̶
// 4) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶l̶i̶s̶t̶ t̶o̶ a̶d̶d̶ y̶e̶l̶l̶o̶w̶ c̶o̶i̶n̶ &̶ b̶l̶u̶e̶ c̶o̶i̶n̶
// 5) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶o̶p̶a̶c̶i̶t̶y̶ t̶o̶ m̶a̶k̶e̶ n̶o̶ s̶t̶a̶t̶i̶s̶t̶i̶c̶s̶ v̶i̶s̶i̶b̶l̶e̶
// 6) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶ l̶i̶s̶t̶ t̶o̶ a̶d̶d̶ g̶r̶e̶y̶ c̶o̶i̶n̶
// 7) u̶s̶e̶ a̶n̶i̶m̶a̶t̶e̶d̶ l̶i̶s̶t̶ t̶o̶ a̶d̶d̶ d̶o̶w̶n̶ u̶p̶ w̶i̶d̶g̶e̶t̶
// 8) b̶o̶t̶t̶o̶m̶ n̶a̶v̶i̶g̶a̶t̶i̶o̶n̶ b̶a̶r̶ w̶i̶t̶h̶ n̶o̶t̶c̶h̶e̶d̶ f̶a̶b̶
}

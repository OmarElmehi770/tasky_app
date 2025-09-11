import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky_app/features/auth/veiw/presentation/login-scrren.dart';
import 'package:tasky_app/features/home/view/presentation/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingItem> onBoardingPages = onBoardingItems();
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: 100),
                Image.asset(onBoardingPages[index].imageUrl),
                SizedBox(height: 20),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(dotHeight: 10, dotWidth: 10),
                  onDotClicked: (index) {},
                ),
                SizedBox(height: 50),
                Text(onBoardingPages[index].title),
                SizedBox(height: 42),
                Text(onBoardingPages[index].desc, textAlign: TextAlign.center),
                SizedBox(height: 100),
                Positioned(
                  bottom: 40,
                  right: 20,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        index < 2
                            ? controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              )
                            : Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                      });
                    },
                    color: Color(0xff5F33E1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(index < 2 ? "NEXT" : "GET STARTED"),
                  ),
                ),
              ],
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}

class OnBoardingItem {
  String imageUrl;
  String title;
  String desc;

  OnBoardingItem({
    required this.imageUrl,
    required this.title,
    required this.desc,
  });
}

List<OnBoardingItem> onBoardingItems() {
  return [
    OnBoardingItem(
      imageUrl: "assets/images/on-boarding-image-1.png",
      title: "Manage your tasks",
      desc: "You can easily manage all of your daily tasks in DoMe for free",
    ),
    OnBoardingItem(
      imageUrl: "assets/images/on-boarding-image-2.png",
      title: "Create daily routine",
      desc:
          "In Tasky  you can create your personalized routine to stay productive",
    ),
    OnBoardingItem(
      imageUrl: "assets/images/on-boarding-image-3.png",
      title: "Organize your tasks",
      desc:
          "You can organize your daily tasks by adding your tasks into separate categories",
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/colors.dart';
import 'package:pawsome_client/model/onboard_model.dart';
import 'package:pawsome_client/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img:
          'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=394&q=80',
      text: "Find your best companion today",
      desc:
          "Having an pet is a great way to relieve stress levels and increase happiness",
      bg: Colors.white,
    ),
    OnboardModel(
      img:
          'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=394&q=80',
      text: "Match your compatibility ",
      desc: "Find best companion based on specific criteria and compatibility",
      bg: Color(0xFF4756DF),
    ),
    OnboardModel(
      img:
          'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=394&q=80',
      text: "Foster or Adopt",
      desc:
          "Shorter Commitment or Longer Commitment- there is more than one way to help an animal in need",
      bg: Colors.white,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black26,
          // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark,
          //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              print("Skip");
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 7,
              child: PageView.builder(
                itemCount: screens.length,
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        screens[index].img,
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      Text(
                        screens[index].text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: kblack,
                        ),
                      ),
                      Text(
                        screens[index].desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          color: kblack,
                        ),
                      ),
                      // ... remaining content
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 10.0,
                child: ListView.builder(
                  itemCount: screens.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          width: currentIndex == index ? 25 : 12,
                          height: 10,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? const Color(0xFF9188e3)
                                : const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              child: FilledButton.tonal(
                onPressed: () {
                  if (currentIndex == screens.length - 1) {
                    _storeOnboardInfo();
                    GoRouter.of(context).go("/home");
                  }
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  currentIndex == screens.length - 1
                      ? "Get Started"
                      : "Explore",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: kwhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/model/onboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img:
          'https://freedesignfile.com/upload/2022/04/Dog-sticking-out-tongue-cartoon-vector.jpg',
      text: "Find your best companion today",
      desc:
          "Having an pet is a great way to relieve stress levels and increase happiness",
    ),
    OnboardModel(
      img:
          'https://img.freepik.com/free-vector/dog-high-five-concept-illustration_114360-11145.jpg?w=740&t=st=1687416083~exp=1687416683~hmac=e1578955fa9e7f4c7414747336df8e86dc7903c32321e22cdc9aa25275400973',
      text: "Match your compatibility ",
      desc: "Find best companion based on specific criteria and compatibility",
    ),
    OnboardModel(
      img:
          'https://img.freepik.com/premium-vector/adopt-pet-concept_23-2148517279.jpg?w=740',
      text: "Foster or Adopt",
      desc:
          "Shorter Commitment or Longer Commitment- there is more than one way to help an animal in need",
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoard', true);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black26,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness:
              Brightness.light,
        ),
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              print("Skip");
              _storeOnboardInfo();
              context.go("/home");
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
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        screens[index].desc,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          color: Colors.black,
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
              child: SizedBox(
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
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
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
              margin: const EdgeInsets.only(bottom: 20.0),
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
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
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

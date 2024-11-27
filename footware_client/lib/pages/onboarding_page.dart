import 'package:flutter/material.dart';
import 'package:footware_client/pages/register_page.dart';
import 'package:footware_client/widgets/content_model.dart';
import 'package:footware_client/widgets/widget_support.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 300,
                          width: MediaQuery.of(context).size.width / 1.5,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          contents[i].title,
                          style: AppWidget.SemiBoldTextFieldStyle(),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          contents[i].description,
                          style: AppWidget.LightSemiBoldTextFieldStyle(),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              }
              _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 66, 48, 106),
                  borderRadius: BorderRadius.circular(10)),
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                  child: Text(
                      currentIndex == contents.length - 1 ? "Start" : "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold))),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black38),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/network/remote/cach_helper.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  String? image;
  String? title;
  String? body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body
});

}


class OnBoardingScreen extends StatefulWidget {
  
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> model =
  [
    BoardingModel(
        title: "On Boarding Title 1",
        image: 'assets/images/on_boarding.jpg',
        body: 'On Boarding body 1'
    ),
    BoardingModel(
        title: "On Boarding Title 2",
        image: 'assets/images/on_boarding.jpg',
        body: 'On Boarding body 2'
    ),
    BoardingModel(
        title: "On Boarding Title 3",
        image: 'assets/images/on_boarding.jpg',
        body: 'On Boarding body 3'
    )
  ];

  var boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
              {
                submit();
              },
              child: const Text(
                "SKIP"
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == model.length - 1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    isLast = false;
                  }
                },
                controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index)=> buildBoardingItem(model[index]),
                  itemCount: model.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: model.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                          duration: const Duration(
                              milliseconds: 750
                          ),
                          curve: Curves.bounceInOut
                      );
                    }


                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_sharp
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),

          Text(
              '${model.title}',
            style: TextStyle(
              fontSize: 25
            ),

          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
                fontSize: 20
            ),
          )
        ],
      );
  }

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      navigateAndFinish(context, const LoginScreen());

      print(CacheHelper.getData(key: 'onBoarding'));
    }).catchError((error){print(error.toString());});

  }
}

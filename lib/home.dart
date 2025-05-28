import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tas/add-task.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.only(top: 32,left: 16,right: 16),
        child: Column(
          children: [
            SizedBox(width: 375,height: 52,),
            Row(
              children: [
                Image.asset('assets/images/Thumbnail.png',width: 60,height: 60,),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Text(
                      'Good Evening ,Usama ',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 20,
                      ),
                    ),
                      Text(
                        'One task at a time.One step\n closer. ',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 16,
                        ),
                    ),
                  ],
                ),
                SizedBox(width: 100,),
                CircleAvatar(
                  backgroundColor: const Color(0xFF282828),
                  radius: 17,
                  child: SvgPicture.asset(
                    'assets/images/Icon.svg',
                    width: 18,  // Image width
                    height: 18, // Image height
                  ),
                )
              ],
            ),
            SizedBox(height: 24,),
            Align(
              alignment:Alignment.centerLeft,
              child: Text('Yuhuu ,Your work Is ',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 32,
              ),),
            ),
            SizedBox(height: 4,),
            Row(
              children: [
                Text('almost done ! ',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 32,
                ),),
                SvgPicture.asset('assets/images/hand3.svg',width: 32,height: 32,),

              ],
            ),
            SizedBox(height: 100,),
            SizedBox(
              width: 167,
              height: 40,
              child: FloatingActionButton(
                backgroundColor:Color(0xFF15B86C),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return AddTask();
                  }));
                },child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('+',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize:12 ,
                  ),),
                  SizedBox(width: 8,),
                  Row(
                    children: [
                      Text('+',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 16,
                      ),),
                      Text('Add New Task',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 16,
                      ),),
                    ],
                  ),
                ],
              ),),
            )
          ],
        ),
      )
    );
  }
}

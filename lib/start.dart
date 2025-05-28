import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home.dart';
class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width:375,height: 52,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/Vector.svg',width: 42,height: 42,),
                SizedBox(width: 16,),
                Text('Tasky',style: Theme.of(context).textTheme.displayMedium,),
              ],
            ),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome To Tasky ',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 24,
                ),),
                SvgPicture.asset('assets/images/hand3.svg',width: 28,height: 28,),
              ],
            ),
            SizedBox(height: 8,),
            Text('Your productivity journey starts here.',style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 16,
            ),),
            SizedBox(height: 24,),
            SvgPicture.asset('assets/images/pana.svg',width: 215,height: 204,),
            SizedBox(height: 28,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Full Name',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: 'e.g. Sarah Khalid', // Only unique property kept
              ),
            ),
            SizedBox(height: 24,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return Home();
                }));
              },
              child: Text('Let\'s Get Started'),
            )



          ],
        ),
      ),
    );
  }
}

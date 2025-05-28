import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(width: 375,height: 52,),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Home()));
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF282828),
                    radius: 17,
                    child: SvgPicture.asset(
                      'assets/images/Icon2.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                SizedBox(width: 16,),
                Text('New Task',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize:20 ,
                  fontWeight: FontWeight.w400,

                ),),
              ],
            ),
            SizedBox(height: 40,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Task Name',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize:20 ,
                fontWeight: FontWeight.w400,
              ),),
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Finish UI design for login screen',
              ),
            ),
            SizedBox(height: 24,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Task Description',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize:20 ,
                fontWeight: FontWeight.w400,
              ),),
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Finish onboarding UI and hand off to\n devs by Thursday.', // Only unique property kept
              ),
              maxLines: 5,
            ),
            SizedBox(height: 24,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return Home();
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('+',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 16,
                  ),),
                  SizedBox(width: 10,),
                  Text('Add Task',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 16,
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

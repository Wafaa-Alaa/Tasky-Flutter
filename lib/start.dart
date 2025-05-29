import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tas/core/components/custome-textfiled.dart';
import 'home.dart';

class Start extends StatelessWidget {
  Start({super.key});
  final TextEditingController controllerName = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 375, height: 52),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/Vector.svg',
                    width: 42,
                    height: 42,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Tasky',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome To Tasky ',
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(fontSize: 24),
                  ),
                  SvgPicture.asset(
                    'assets/images/hand3.svg',
                    width: 28,
                    height: 28,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Your productivity journey starts here.',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 16),
              ),
              SizedBox(height: 24),
              SvgPicture.asset(
                'assets/images/pana.svg',
                width: 215,
                height: 204,
              ),
              SizedBox(height: 28),
              CustomeTextFieled(
                title: 'Full Name',
                hintText: 'e.g. Sarah Khalid',
                controller: controllerName,
                validator: (String?name){
                  if(name==null || name.isEmpty)
                    return 'Please Enter Your Name';
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final SharedPreferences sharP = await SharedPreferences.getInstance();
                  sharP.setString('username',controllerName.text);
                  if (_key.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Home();
                        },
                      ),
                    );
                  }
                },
                child: Text('Let\'s Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tas/core/components/custome-textfiled.dart';
import 'package:tas/core/services/sharedprefernce-manager.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final TextEditingController controllerUserName = TextEditingController();
  final TextEditingController controllerUserQuote = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final SharedPreferencesProvider _prefsProvider = SharedPreferencesProvider();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userName = await _prefsProvider.getString('username'); // Changed to 'username' to match your logout code
    String? userQuote = await _prefsProvider.getString('userQuote');

    if (mounted) {
      setState(() {
        controllerUserName.text = userName ?? '';
        controllerUserQuote.text = userQuote ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(width: 375, height: 52),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Changed to pop
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
                    SizedBox(width: 16),
                    Text(
                      'User Details',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                CustomeTextFieled(
                  title: 'User Name',
                  controller: controllerUserName,
                  validator: (String? name) {
                    if (name == null || name.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomeTextFieled(
                  title: 'Motivation Quote',
                  controller: controllerUserQuote,
                  maxLins: 5,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      await _prefsProvider.setString('username', controllerUserName.text); // Changed to 'username'
                      await _prefsProvider.setString('userQuote', controllerUserQuote.text);

                      if (mounted) {
                        Navigator.pop(context); // Changed to pop
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF15B86C),
                    minimumSize: const Size(167, 40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Save Changes',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 108,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFCFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
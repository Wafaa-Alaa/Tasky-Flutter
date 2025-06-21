import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tas/core/services/sharedprefernce-manager.dart';
import 'package:tas/core/themes/theme-controller.dart';
import 'package:tas/home.dart';
import 'package:tas/profile-details.dart';
import 'package:tas/core/services/auth-service.dart';
import 'package:tas/start.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _imageFile;
  final SharedPreferencesProvider _prefsProvider = SharedPreferencesProvider();
  final AuthService _authService = AuthService();
  String _username = '';
  String _userQuote = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final username = await _prefsProvider.getString('username') ?? '';
    final quote = await _prefsProvider.getString('userQuote') ?? '';
    final imageString = await _prefsProvider.getString('profileImage');

    if (mounted) {
      setState(() {
        _username = username;
        _userQuote = quote;
        if (imageString != null && imageString.isNotEmpty) {
          final bytes = base64Decode(imageString);
          _imageFile = File.fromRawPath(bytes);
        }
      });
    }
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose image source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      await _prefsProvider.setString('profileImage', base64Image);

      setState(() {
        _imageFile = file;
      });
    }
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Start()),
      (route) => false,
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 375, height: 52),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
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
                  const SizedBox(width: 16),
                  Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        FutureBuilder<String?>(
                          future: _prefsProvider.getString('profileImage'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final bytes = base64Decode(snapshot.data!);
                              return CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(bytes),
                                backgroundColor: Colors.grey,
                              );
                            }
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : const AssetImage('assets/images/imageprofile.avif')
                              as ImageProvider,
                              backgroundColor: Colors.grey,
                            );
                          },
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, size: 20),
                            color: Colors.white,
                            onPressed: _showImageSourceDialog,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_username.isNotEmpty)
                      Text(
                        _username,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (_userQuote.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _userQuote,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Profile Info',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.person_2_outlined, size: 26),
                title: Text(
                  'User Details',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20),
                ),
                trailing: const Icon(Icons.arrow_forward, size: 26),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileDetails()),
                  ).then((_) => _loadUserData());
                },
              ),
              Divider(
                // color: Colors.white,
                height: 2,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: ThemeController().themeNotifier,
                builder: (context, themeMode, child) {
                  return ListTile(
                    leading: Icon(
                      themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      size: 26,
                    ),
                    title: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20),
                    ),
                    trailing: Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        ThemeController().toggleTheme();
                      },
                    ),
                  );
                },
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: const Icon(Icons.logout, size: 26),
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    inherit: true,
                      fontSize: 20),
                ),
                trailing: const Icon(Icons.arrow_forward, size: 26),
                onTap: _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isHeightPrority = false;
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
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
              SizedBox(width: 375, height: 52),
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
                    style: Theme.of(context).textTheme.displayMedium
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : const NetworkImage('https://example.com/profile.jpg')
                      as ImageProvider,
                      backgroundColor: Colors.grey,
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
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Profile Info',
                style: Theme.of(context).textTheme.displayMedium
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/images/profile.svg',
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  'User Details',
                  style: Theme.of(context).textTheme.displayMedium
                      ?.copyWith(fontSize: 20),
                ),
                trailing: const Icon(Icons.arrow_forward, size: 26),
              ),
              Divider(
                color: Colors.white,
                height: 2,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined, size: 26),
                title: Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.displayMedium
                      ?.copyWith(fontSize: 20),
                ),
                trailing: Switch(
                  value: isHeightPrority,
                  onChanged: (bool value) {
                    setState(() {
                      isHeightPrority = value;
                    });
                  },
                ),
              ),
              Divider(
                color: Colors.white,
                height: 2,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: const Icon(Icons.logout, size: 26),
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.displayMedium
                      ?.copyWith(fontSize: 20),
                ),
                trailing: const Icon(Icons.arrow_forward, size: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
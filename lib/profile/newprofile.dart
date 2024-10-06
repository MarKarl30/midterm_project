import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:midterm_project/profile/editprofile.dart';
import 'package:midterm_project/profile/text_box.dart';
import 'package:midterm_project/screens/user-auth/login_screen.dart';

void navigateToLoginScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const SignIn()),
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;
  String userName = 'Loading...';
  String phoneNumber = 'Loading...';
  File? _image;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      fetchUserDetails();
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'] ?? 'No name found';
          phoneNumber = userDoc['phone'] ?? 'No phone number found';
        });
        // Debugging lines
        print('User Name: $userName');
        print('Phone Number: $phoneNumber');
      } else {
        setState(() {
          userName = 'No name found';
          phoneNumber = 'No phone number found';
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Error loading name';
        phoneNumber = 'Error loading phone';
      });
      print('Error fetching user details: $e'); // Add error log
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final File imageFile = File(pickedFile.path);
      final String imagePath = '${directory.path}/profile_picture.png';

      await imageFile.copy(imagePath);

      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    navigateToLoginScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentUser?.email ?? 'Email not available',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'My Details',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            MyTextBox(
              text: userName,
              sectionName: 'Username',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            MyTextBox(
              text: phoneNumber,
              sectionName: 'Phone Number',
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color.fromARGB(255, 0, 0, 0),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Logout', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
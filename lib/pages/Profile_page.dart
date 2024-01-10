import 'dart:io';

import 'package:algi/components/BMIPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _imagePath = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'PROFILE',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: _imagePath.isNotEmpty
                      ? ClipOval(
                          child: Image.file(
                            File(_imagePath),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 100,
                        ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save user profile here
                  String name = _nameController.text;
                  String email = _emailController.text;

                  // Do something with the saved user data
                  // For now, let's just print the data
                  print('Name: $name, Email: $email');

                  // Show a snackbar to indicate the data has been saved
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile saved: Name: $name, Email: $email'),
                    ),
                  );
                },
                child: Text('Save Profile'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to BMI page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BMIPage()),
                  );
                },
                child: Text('BMI PAGE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

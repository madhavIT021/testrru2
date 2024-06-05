import 'package:flutter/material.dart';
import 'package:testrru/services/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final Authservice _auth = Authservice();

  final TextEditingController _nameController = TextEditingController(text: 'Madhav');
  final TextEditingController _emailController = TextEditingController(text: 'madhav.desai@example.com');
  final TextEditingController _phoneController = TextEditingController(text: '8320760088');
  final TextEditingController _addressController = TextEditingController(text: 'GH-3, Gandhinagar');
  final TextEditingController _schoolController = TextEditingController(text: 'RRU');
  final TextEditingController _degreeController = TextEditingController(text: 'Bachelor of Technology');
  final TextEditingController _fieldOfStudyController = TextEditingController(text: 'Information Technology');
  final TextEditingController _graduationYearController = TextEditingController(text: '2026');

  bool _isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Image(image: AssetImage('assets/Logo copy.png')),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/image.jpeg"),
            ),
            SizedBox(height: 16),
            Text(
              _nameController.text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _emailController.text,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isEditable = !_isEditable;
                });
              },
              child: Text(_isEditable ? 'Save Profile' : 'Edit Profile'),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Personal Information
                  Text('Personal Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  // Academic Information
                  Text('Academic Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _schoolController,
                    decoration: InputDecoration(labelText: 'School/University'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your school or university';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _degreeController,
                    decoration: InputDecoration(labelText: 'Degree'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your degree';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _fieldOfStudyController,
                    decoration: InputDecoration(labelText: 'Field of Study'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your field of study';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _graduationYearController,
                    decoration: InputDecoration(labelText: 'Year of Graduation'),
                    enabled: _isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your year of graduation';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  TextButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    label: const Text("logout"),
                    icon: const Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

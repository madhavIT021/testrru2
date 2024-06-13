import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:testrru/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testrru/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {


  final String selected_role;
  ProfilePage({super.key,required this.selected_role});

  @override
  Widget build(BuildContext context) {
   if(selected_role=='Student')
      {
        return ProfilePageS(role: selected_role);
      }
   else
     {
       return ProfilePageF();
     }

  }
}

class ProfilePageS extends StatefulWidget {
 final String role ;
  ProfilePageS({required this.role});
  @override
  _ProfilePageSState createState() => _ProfilePageSState();
}

class _ProfilePageSState extends State<ProfilePageS> {
  final _formKey = GlobalKey<FormState>();
  final Authservice _auth = Authservice();
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _nameController =
      TextEditingController(text: 'Madhav');
  final TextEditingController _emailController =
      TextEditingController(text: 'madhav.desai@example.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '8320760088');
  final TextEditingController _addressController =
      TextEditingController(text: 'GH-3, Gandhinagar');
  final TextEditingController _schoolController =
      TextEditingController(text: 'RRU');
  final TextEditingController _degreeController =
      TextEditingController(text: 'Bachelor of Technology');
  final TextEditingController _fieldOfStudyController =
      TextEditingController(text: 'Information Technology');
  final TextEditingController _graduationYearController =
      TextEditingController(text: '2026');
  final TextEditingController _admissionYearController =
  TextEditingController(text: '2024');

  bool _isEditable = false;
  File? _profileImage;
  String? _profileImageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await _auth.uploadImage(_profileImage!);
      // Assuming the uploadImage method in Authservice sets the _profileImageUrl correctly.
      final downloadUrl = await _auth.uploadImage(_profileImage!);
      setState(() {
        _profileImageUrl = downloadUrl;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImageUrl();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final User user = _firebaseAuth.currentUser!;
    final DatabaseServices dbService = DatabaseServices(uid: user.uid);
    final DocumentSnapshot userData = await dbService.getUserData(widget.role);

    setState(() {
      _nameController.text = userData['name'];
      _emailController.text = userData['email'];
      _phoneController.text = userData['phone'];
      _addressController.text = userData['address'];
      _schoolController.text = userData['school'];
      _degreeController.text = userData['degree'];
      _fieldOfStudyController.text = userData['fieldOfStudy'];
      _graduationYearController.text = userData['graduationYear'];
      _admissionYearController.text = userData['yearOfAdmission'];

    });
  }

  Future<void> _loadProfileImageUrl() async {
    final profileImageUrl = await _auth.fetchProfileImageUrl();
    setState(() {
      _profileImageUrl = profileImageUrl;
    });
  }

  // void _showOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: Icon(Icons.photo_library),
  //               title: Text('Upload Image'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickImage();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.visibility),
  //               title: Text('See Image'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (_) => ProfilePhotoView(
  //                       photoTag: "profile_photo_tag",
  //                       photoFile: _profileImage,
  //                       photoUrl: _profileImageUrl,
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Future<void> _saveProfileData() async {
    if (_formKey.currentState!.validate()) {
      final User user = _firebaseAuth.currentUser!;
      final DatabaseServices dbService = DatabaseServices(uid: user.uid);

      final Map<String, dynamic> updatedData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'school': _schoolController.text,
        'degree': _degreeController.text,
        'fieldOfStudy': _fieldOfStudyController.text,
        'graduationYear': _graduationYearController.text,
        'yearOfAdmission': _admissionYearController.text,
      };

      await dbService.updateUserData(widget.role, updatedData);

      setState(() {
        _isEditable = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
    }
  }

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
            GestureDetector(
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePhotoView(
                      photoTag: "profile_photo_tag",
                      photoFile: _profileImage,
                      photoUrl: _profileImageUrl,
                    ),
                  ),
                );
              },
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: "profile_photo_tag",
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImageUrl != null
                          ? NetworkImage(_profileImageUrl!)
                          : _profileImage != null
                              ? FileImage(_profileImage!)
                              : AssetImage("assets/Logo copy.png")
                                  as ImageProvider,
                    ),
                  ),
                  Positioned(
                    right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: (){
                          _pickImage();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlue,
                          child: Icon(Icons.edit, color: Colors.white,),
                        ),
                      )
                  ),
                ],
              ),
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
                if (_isEditable) {
                  _saveProfileData();
                } else {
                  setState(() {
                    _isEditable = true;
                  });
                }
              },
              child: Text(_isEditable ? 'Save Profile' : 'Edit Profile'),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Personal Information
                  Text('Personal Information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  Text('Academic Information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _graduationYearController,
                          decoration: InputDecoration(labelText: 'Graduation Year'),
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your graduation year';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: _admissionYearController,
                          decoration: InputDecoration(labelText: 'Admission Year'), // New field
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your admission year';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  TextButton.icon(
                    onPressed: () {
                      _auth.signOut();
                    },
                    label: Text('SignOut'),
                    icon: Icon(Icons.logout),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePhotoView extends StatelessWidget {
  final String photoTag;
  final File? photoFile;
  final String? photoUrl;

  ProfilePhotoView({required this.photoTag, this.photoFile, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Photo'),
      ),
      body: Center(
        child: Hero(
          tag: photoTag,
          child: photoUrl != null
              ? Image.network(photoUrl!)
              : photoFile != null
                  ? Image.file(photoFile!)
                  : Image.asset("assets/Logo copy.png"),
        ),
      ),
    );
  }
}


class ProfilePageF extends StatefulWidget {
  @override
  _ProfilePageFState createState() => _ProfilePageFState();
}

class _ProfilePageFState extends State<ProfilePageF> {
  final _formKey = GlobalKey<FormState>();
  final Authservice _auth = Authservice();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController =
  TextEditingController(text: 'Madhav');
  final TextEditingController _emailController =
  TextEditingController(text: 'madhav.desai@example.com');
  final TextEditingController _phoneController =
  TextEditingController(text: '8320760088');
  final TextEditingController _addressController =
  TextEditingController(text: 'GH-3, Gandhinagar');


  bool _isEditable = false;
  File? _profileImage;
  String? _profileImageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await _auth.uploadImage(_profileImage!);
      // Assuming the uploadImage method in Authservice sets the _profileImageUrl correctly.
      final downloadUrl = await _auth.uploadImage(_profileImage!);
      setState(() {
        _profileImageUrl = downloadUrl;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImageUrl();
  }

  Future<void> _loadProfileImageUrl() async {
    final profileImageUrl = await _auth.fetchProfileImageUrl();
    setState(() {
      _profileImageUrl = profileImageUrl;
    });
  }

  // void _showOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: Icon(Icons.photo_library),
  //               title: Text('Upload Image'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickImage();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.visibility),
  //               title: Text('See Image'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (_) => ProfilePhotoView(
  //                       photoTag: "profile_photo_tag",
  //                       photoFile: _profileImage,
  //                       photoUrl: _profileImageUrl,
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePhotoView(
                      photoTag: "profile_photo_tag",
                      photoFile: _profileImage,
                      photoUrl: _profileImageUrl,
                    ),
                  ),
                );
              },
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: "profile_photo_tag",
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImageUrl != null
                          ? NetworkImage(_profileImageUrl!)
                          : _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage("assets/Logo copy.png")
                      as ImageProvider,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: (){
                          _pickImage();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlue,
                          child: Icon(Icons.edit, color: Colors.white,),
                        ),
                      )
                  ),
                ],
              ),
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
                  Text('Personal Information',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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

                  TextButton.icon(
                    onPressed: () {
                      _auth.signOut();
                    },
                    label: Text('SignOut'),
                    icon: Icon(Icons.logout),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


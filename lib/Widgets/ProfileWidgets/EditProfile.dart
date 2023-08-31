import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override

 late ImageProvider _avatarImage;
 late File _selectedImage;
  @override
  void initState() {
    super.initState();
    _avatarImage = AssetImage('assets/image9.png');
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final selectedFile = File(pickedImage.path);
      setState(() {
        _selectedImage = selectedFile;
        _avatarImage = FileImage(File(pickedImage.path));

      });
    }
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final userData = Provider.of<UserProvider>(context).user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:  _avatarImage,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.014),
        Text(
          '${userData!.name}',
          style: GoogleFonts.lato(
              fontSize: size.height * 0.03, fontWeight: FontWeight.bold),
        ),
        Text(
          '${userData.email}',
          style: GoogleFonts.lato(color: Colors.grey),
        ),
        SizedBox(height: size.height * 0.02),
        Divider(height: 1),
        SizedBox(height: size.height * 0.02),
        Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 42, 129, 201),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Card(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: ListTile(
            tileColor: Color.fromARGB(255, 212, 218, 221),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${userData.name}"),
              ],
            ),
            trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: _editName, // Call the function to show the edit name dialog
        ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Card(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: ListTile(
            tileColor: Color.fromARGB(255, 212, 218, 221),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${userData.email}"),
              ],
            ),
           trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: _editEmail, // Call the function to show the edit name dialog
        ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Card(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: ListTile(
            tileColor: Color.fromARGB(255, 212, 218, 221),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Password",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("********"),
              ],
            ),
            trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: _editPassword, // Call the function to show the edit name dialog
        ),
          ),
        ),
        SizedBox(height: size.height * 0.04),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return LoginScreen();
            }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Logout",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.03),
                ),
                Icon(Icons.logout),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // code for editing the username
 String _name = "username"; 
  void _editName() async {
    String newName = await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _textFieldController = TextEditingController();
        return AlertDialog(
          title: Text("Edit Name"),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter new name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _textFieldController.text); // Return the edited name
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        _name = newName; // Update the name with the new value
      });
    }
  }
  // 

    // code for editing the username
 String _email = "user@gmail.com"; 
  void _editEmail() async {
    String newEmail = await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _textEmailController = TextEditingController();
        return AlertDialog(
          title: Text("Change email"),
          content: TextField(
            controller: _textEmailController,
            decoration: InputDecoration(hintText: "Enter new email"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _textEmailController.text); // Return the edited name
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );

    if (newEmail != null && newEmail.isNotEmpty) {
      setState(() {
        _email = newEmail; // Update the name with the new value
      });
    }
  }
  // 



  // code for editing the password
  String _oldPassword = "";
  String _newPassword = "";
  String _confirmPassword = "";

  void _editPassword() async {
    await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _oldPasswordController = TextEditingController();
        TextEditingController _newPasswordController = TextEditingController();
        TextEditingController _confirmPasswordController = TextEditingController();

        return AlertDialog(
          title: Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter old password"),
              ),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter new password"),
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Confirm new password"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Validate and update password logic here
                String oldPassword = _oldPasswordController.text;
                String newPassword = _newPasswordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (newPassword == confirmPassword) {
                  // Update password logic here
                  setState(() {
                    _oldPassword = oldPassword;
                    _newPassword = newPassword;
                    _confirmPassword = confirmPassword;
                  });
                  Navigator.pop(context); // Close the dialog
                } else {
                  // Show an error or validation message
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
  // ...
}
 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/features/auth/login_screen.dart';
import 'package:laptop_harbor_app/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  bool ispassword = true;

  //form validation
  final formkey = GlobalKey<FormState>();

  Future register(context) async {
    setState(() {
      isloading = true;
    });
    try {
      final auth = FirebaseAuth.instance;
      final user = await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final db = FirebaseFirestore.instance.collection(
        'users',
      ); //create collect
      // await db.add({"id":user.user!.uid,"name":name.text,"email":email.text});//db
      await db.doc(user.user!.uid).set({
        "id": user.user!.uid,
        "name": name.text,
        "email": email.text,
      }); //db

      //add    users/{id}/data
      //set    users/id/data

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Utils.showMessage(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Utils.showMessage(
          context,
          'The account already exists for that email.',
        );
      } else {
        print(e.code);
        Utils.showMessage(context, e.code.toString());
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 40),

              TextFormField(
                controller: name,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'enter name';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(),
                  labelText: 'Name',
                  labelStyle: TextStyle(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 18),

              TextFormField(
                controller: email,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'enter Email';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(),
                  labelText: 'Email',
                  labelStyle: TextStyle(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 18),

              TextFormField(
                controller: password,
                obscureText: ispassword,
                obscuringCharacter: '*',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'enter Password';
                  } else if (val.length < 6) {
                    return 'minimun enter 6 letter';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(),
                  labelText: 'Password',
                  labelStyle: TextStyle(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  prefixIcon: Icon(Icons.password),
                ),
              ),

              SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50), // full width + height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    register(context);
                  }
                },
                child: isloading
                    ? CircularProgressIndicator()
                    : Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

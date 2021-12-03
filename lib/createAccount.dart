import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobilappmercedes/createAccount.dart';
import 'package:mobilappmercedes/login.dart';

import 'components/rounded_button.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AccountIslemleri extends StatefulWidget {
  @override
  _AccountIslemleriState createState() => _AccountIslemleriState();
}

class _AccountIslemleriState extends State<AccountIslemleri> {
  late String kullaniciAdi, email, password;

  get users => null;

  get veriYolu => null;

  kullaniciAdiAl(kullaniciAdiTutucu) {
    this.kullaniciAdi = kullaniciAdiTutucu;
  }

  emailAl(emailTutucu) {
    this.email = emailTutucu;
  }

  passwordAl(passwordTutucu) {
    this.password = passwordTutucu;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Kullanıcı Oturumu Kapattı');
      } else {
        print('Kullaıcı oturumu Açtı');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.0010,
            ),
            SvgPicture.asset(
              "assets/icons/Discover theMercedesMedia.svg",
              height: size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onChanged: (String kullaniciAdiTutucu) {
                  kullaniciAdiAl(kullaniciAdiTutucu);
                },
                decoration: const InputDecoration(
                    labelText: "User Name",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onChanged: (String emailTutucu) {
                  emailAl(emailTutucu);
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onChanged: (String passwordTutucu) {
                  passwordAl(passwordTutucu);
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                ),
              ),
            ),
            RoundedButton(
              text: "Create Account",
              color: Colors.purple,
              press: _emailSifreKullaniciolustur,
            ),
            RoundedButton(
              text: "Forgot Password",
              color: Colors.blueAccent,
              press: _resetPassword,
            ),
          ],
        ),
      ),
    );
  }

  void _emailSifreKullaniciolustur() async {
    // String _email = "e160503138@stud.tau.edu.tr";
    /// String _password = "abc123";
    DocumentReference veriYolu =
        FirebaseFirestore.instance.collection("users").doc(kullaniciAdi);

    Map<String, dynamic> users = {
      "KullaniciAdi": kullaniciAdi,
      "Email": email,
      "Sifre": password,
    };

    veriYolu.set(users).whenComplete(() {});

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? _yeniUser = _credential.user;
      await _yeniUser!.sendEmailVerification();
      if (_auth.currentUser != null) {
        debugPrint("Size bir mail attık lütfen onaylayın");
        await _auth.signOut();
        debugPrint("Kullanıcıyı sistemden attık");
      }

      debugPrint(_yeniUser.toString());
    } catch (e) {
      debugPrint("*******HATA VAR***");
      debugPrint(e.toString());
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginIslemleri()));
  }

  void _resetPassword() async {
    String _email = email;

    try {
      await _auth.sendPasswordResetEmail(email: _email);
      debugPrint("Resetleme maili gönderildi");
    } catch (e) {
      debugPrint("Şifre resetlenirken hata $e");
    }
  }
}

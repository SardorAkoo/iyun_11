import 'package:flutter/material.dart';
import 'package:iyun_11/servise/auth_http_services.dart';
import 'package:iyun_11/views/home_screen.dart';
import 'package:iyun_11/views/login_screen.dart';
import 'package:iyun_11/views/register_screen.dart';

class ReastPassword extends StatefulWidget {
  const ReastPassword({super.key});

  @override
  State<ReastPassword> createState() => _ReastPasswordState();
}

class _ReastPasswordState extends State<ReastPassword> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  bool isLoading = false;

  String? email;
  String? password;

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.login(email!, password!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return HomeScreen();
            },
          ),
        );
      } on Exception catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email mavjud";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reast password"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 90,
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Elektron pochta",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos elektron pochtangizni kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  //? save email
                  email = newValue;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pochtaga borgan parolni kiriting",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos parolingizni kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  //? save password
                  password = newValue;
                },
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : FilledButton(
                      onPressed: submit,
                      child: const Text("Parolni ozgartirish"),
                    ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
                child: const Text("Kirish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

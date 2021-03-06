import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_sistema_ventas/widgets/register_login_controller.dart';
import 'package:flutter/services.dart';

class RegisterLoginPage extends StatelessWidget {
  final controller = Get.put(LoginRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginRegisterController>(
        builder: (_) {
          return Form(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _.emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    
                    TextFormField(
                      controller: _.passwordController,
                      inputFormatters: <TextInputFormatter>[
                        //FilteringTextInputFormatter.allow(RegExp(r'^(?=(?:.\d){2})(?=(?:.[A-Z]){1})(?=(?:.*[a-z]){1})\S{6,10}$')),
                      ],
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                     TextFormField(
                      controller: _.cedulaController,
                      decoration: const InputDecoration(labelText: 'Cedula'),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        child: Text('Register'),
                        onPressed: () async {
                          _.register();
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_.success == null
                          ? ''
                          : (_.success!
                              ? 'Successfully registered $_.userEmail'
                              : 'Registration failed')),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

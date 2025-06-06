import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class TodoLoginPage extends StatelessWidget {
  const TodoLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final loginProvider = Provider.of<TodoProviderAuthen>(context);
    String uPasswd = loginProvider.passwd.toString();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/mainBackground2.jpg"),
          Container(
            width: screenSize.width,
            height: screenSize.height,
            padding: EdgeInsets.only(bottom: 80),
            color: Color.fromRGBO(30, 50, 140, 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "User name",
                      hintFadeDuration: Durations.medium1,
                      labelText: "Name",
                      prefixIcon: Icon(Icons.account_box_outlined),
                      prefixIconColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                SizedBox(
                  width: 300,
                  child: TextField(
                    maxLength: 4,
                    decoration: InputDecoration(
                      hintText: "only 4 digit numbers",
                      hintFadeDuration: Durations.medium1,
                      labelText: "Password",
                      suffixIcon:
                          (uPasswd.isNotEmpty)
                              ? IconButton(
                                onPressed: () {
                                  loginProvider.showPasswd();
                                },
                                icon: Icon(
                                  (loginProvider.isPasswdVis)
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              )
                              : null,
                      suffixIconColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: !loginProvider.isPasswdVis,
                    obscuringCharacter: "*",
                    onChanged: (value) {
                      // loginProvider.passwd = value;
                      loginProvider.typePasswd(value);
                    },
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "home");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                  ),
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

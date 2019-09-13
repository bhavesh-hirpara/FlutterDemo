import 'package:flutter/material.dart';

import 'todos_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  String _errorMessage;

  bool _isLoading;

  String _validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return 'Email is Required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid Email';
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    if (value.length == 0) {
      return 'Password is Required';
    } else if (value.length < 6) {
      return '6 chard required';
    } else {
      return null;
    }
  }

  bool _validate() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void _loginCall() {
    if (_validate()) {
      // do api call if validate
      Navigator.pop(context, true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NetworkPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Stack(
            children: <Widget>[
              _buildLoginForm(),
              _buildCircularProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*SizedBox(
            height: 150,
            child: Image.asset(
              'assets/login_logo.png',
              fit: BoxFit.contain,
            ),
          ),*/
          SizedBox(height: 45),
          _buildEmailTextField(),
          SizedBox(height: 25),
          _buildPasswordTextField(),
          SizedBox(height: 35),
          _buildLoginButton(),
          SizedBox(height: 5),
          _buildForgotPassword(),
          SizedBox(height: 45),
          _buildDoNotHaveAnAccount(),
          _buildShowErrorMessage(),
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 20),
          hintText: 'Email',
          hintStyle: TextStyle(fontSize: 17, color: Colors.blueGrey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
      style: TextStyle(fontSize: 17),
      validator: _validateEmail,
      onSaved: (value) => _email = value,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      maxLines: 1,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 20),
          hintText: 'Password',
          hintStyle: TextStyle(fontSize: 17, color: Colors.blueGrey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
      style: TextStyle(fontSize: 17),
      validator: _validatePassword,
      onSaved: (value) => _password = value,
    );
  }

  Widget _buildCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }

  Widget _buildLoginButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(32),
      color: Color(0xff3c8dbc),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 15, 20),
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: _loginCall,
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(
            'Forgot password ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.end,
          ),
          onPressed: () {
            print('forgot password');
          },
        )
      ],
    );
  }

  Widget _buildDoNotHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text(
            'Don\'t have an account ? Sign up',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 17,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.end,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildShowErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return Text(
        _errorMessage,
        style: TextStyle(fontSize: 13, color: Colors.red),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
}

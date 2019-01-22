import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      // overlay over the image
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  InputDecoration _buildInputDecoration(labelText) {
    return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
    );
  }

  void _submitCode() {
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: deviceWidth,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: _buildInputDecoration('E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String value) {
                      setState(() {
                        _emailValue = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: _buildInputDecoration('Password'),
                    obscureText: true,
                    onChanged: (String value) {
                      setState(() {
                        _passwordValue = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    value: _acceptTerms,
                    onChanged: (bool value) {
                      setState(() {
                        _acceptTerms = value;
                      });
                    },
                    title: Text('Accept Terms'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('LOGIN'),
                    onPressed: _submitCode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'emailValue': null,
    'passwordValue': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    if (!_formKey.currentState.validate() && _formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    print(_formData);
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
            child: Form(
              key: _formKey,
              child: Container(
                width: deviceWidth,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: _buildInputDecoration('E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty ||
                            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                          return "E-mail is not valid";
                        }
                      },
                      onSaved: (String value) {
                        _formData['emailValue'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: _buildInputDecoration('Password'),
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Password should not be empty.";
                        }
                      },
                      onSaved: (String value) {
                        _formData['passwordValue'] = value;
                      },
                    ),
                    SwitchListTile(
                      value: _formData['acceptTerms'],
                      onChanged: (bool value) {
                        _formData['acceptTerms'] = value;
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
      ),
    );
  }
}

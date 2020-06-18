import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/presentation/utils/scaffold_body.dart';

class RememberLoginPage extends StatefulWidget {
  @override
  _RememberLoginPageState createState() => _RememberLoginPageState();
}

class _RememberLoginPageState extends State<RememberLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody.authSceneGradient(
        child: Container(
          padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Remember Login?',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              SizedBox(height: 16.0),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 15.0),
              Container(
                height: 55.0,
                child: FlatButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(UserAuthenticated(needToRemeber: true));
                  },
                  child: Text(
                    'Remember & Continue',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 55.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(4)),
                  onPressed: () {
                     BlocProvider.of<AuthenticationBloc>(context).add(UserAuthenticated(needToRemeber: false));
                  },
                  child: Text(
                    'No Thanks',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              SizedBox(height: 64.0)
            ],
          ),
        ),
      ),
    );
  }
}

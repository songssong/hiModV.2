import 'package:flutter/material.dart';
import 'package:himod/service/auth_provider_service.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              AuthProviderService.instance.user == null ?
              Container() :
              CircleAvatar(
                backgroundImage:
                    NetworkImage(AuthProviderService.instance.user.photoURL),
              ),
              SizedBox(
                height: 46,
                width: 46,
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriverOptionEmpty extends StatelessWidget {
  const DriverOptionEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FontAwesomeIcons.faceSadTear,
              size: 50, color: Colors.grey),
          const SizedBox(height: 8.0),
          Text(
            'Hiện chưa có tài xế trên hệ thống',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

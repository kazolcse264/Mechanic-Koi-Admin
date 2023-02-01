import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/welcome.gif",
              ),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Card(
                elevation: 20,
                shadowColor: Colors.purple,
                child: Image.asset(
                  "assets/images/car_service.PNG",
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
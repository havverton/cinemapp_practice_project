import 'package:flutter/widgets.dart';

import 'constants.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 44,
          width: double.infinity,
          color: kMainBackGrndColor,
        ),
        Container(
          height: 40,
          width: double.infinity,
          color: kMainBackGrndColor,
          child: Text("Cinemapp",textAlign: TextAlign.center,),
        ),
      ],
    );
  }
}

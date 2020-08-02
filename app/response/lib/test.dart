import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:response/custom_widgets/CustomDrawerWidget.dart';
import 'custom_widgets/CustomZoomScaffold.dart';

class Test extends StatefulWidget {
  static const String id = '/Test';

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
//      builder: (context) => menuController,
//      create: (context) => menuController,
      value: menuController,
      child: CustomZoomScaffold(
        menuScreen: CustomDrawerWidget(),
        contentScreen: Layout(
          contentBuilder: (cc) => Container(
            color: Colors.grey[200],
            child: Container(
              color: Colors.grey[200],
            ),
          ),
        ),
      ),
    );
  }
}

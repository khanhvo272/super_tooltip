import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

void main() => runApp(const MainApp());
const Color annotationUp = Color(0xD91B4AC3);
const Color annotationDown = Color(0xCC011C4F);
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Tooltip Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({
    Key? key,
  }) : super(key: key);
  @override
  State createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TargetWidget(),
      ),
    );
  }
}

class TargetWidget extends StatefulWidget {
  const TargetWidget({Key? key}) : super(key: key);

  @override
  State createState() => _TargetWidgetState();
}

class _TargetWidgetState extends State<TargetWidget> {

  final _controller = SuperTooltipController();
  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: GestureDetector(
        onTap: () async {
          await _controller.showTooltip();
        },
        child: SuperTooltip(
          showBarrier: true,
          controller: _controller,
          popupDirection: TooltipDirection.down,
          gradient: LinearGradient(
              begin: Alignment.topCenter, // Start point
              end: Alignment.bottomCenter, // End point
              colors: [
                annotationUp, // First color
                annotationUp, // First color
                annotationUp, // First color
                annotationDown, // Second color
                annotationDown, // Second color
              ]),
          left: 30,
          right: 30,
          arrowTipDistance: 15.0,
          arrowBaseWidth: 20.0,
          arrowLength: 20.0,
          borderWidth: 2.0,
          constraints: const BoxConstraints(
            minHeight: 0.0,
            maxHeight: 100,
            minWidth: 0.0,
            maxWidth: 100,
          ),
          showCloseButton: ShowCloseButton.none,
          touchThroughAreaShape: ClipAreaShape.rectangle,
          touchThroughAreaCornerRadius: 30,
          barrierColor: Color.fromARGB(26, 47, 45, 47),
          content: const Text(
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void makeTooltip() {
    _controller.showTooltip();
  }
}

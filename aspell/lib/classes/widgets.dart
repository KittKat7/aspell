import 'package:flutter/material.dart';
// custom
import 'package:aspell/helpers_gui.dart';


class SignBox extends StatefulWidget {
  final Image? image;
  final bool offset;
  const SignBox({super.key, required this.image, this.offset = false});
  
  @override
  _SignBoxState createState() => _SignBoxState();
}

class _SignBoxState extends State<SignBox> {
    
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Image? image = widget.image;
    Size screenSize = getScreenSize(context);
    double width = (screenSize.width * (1 - paddingW * 2));
    double height = ((screenSize.width * (1 - paddingW * 2)) * 3 / 4);
    //_imagePath = widget.initialImagePath;
    
    var child = image == null ? const SizedBox()
      : (height - 4 >= 1024 ? Transform.scale(scale: (height - 4) / (1024), child: image) : image);
    
    Row box = Row(
      children: <Widget>[
        Expanded(flex: 6, child: child),
        Expanded(flex: widget.offset ? 1 : 0, child: const SizedBox()),
      ],
    );

    var border = Border.all(
      color: Colors.black,
      width: 2.0,
    );
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
      ),
      child: box
    );
  }
}

class GoBackButton extends StatelessWidget
{
  // FIELDS
  final BuildContext context;
  final Function? exec;
  const GoBackButton({super.key, required this.context, this.exec});
  
  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        exec == null ? exec : null;
      },
      child: const Text('Go Back'),
    );
  } // end build
} // end GoBackButton

class PaddedScroll extends StatelessWidget
{
  // FIELDS
  final BuildContext context;
  final List<Widget> children;
  
  const PaddedScroll({super.key, required this.context, required this.children});

  @override
  Widget build(BuildContext context)
  {
    final screenSize = getScreenSize(context);
    var edgeInsets = EdgeInsets.symmetric(
      horizontal: screenSize.width * paddingW,
      vertical: screenSize.height * paddingH,
    );
    var column = Column(
      children: children,
    );
    var padding = Padding(
      padding: edgeInsets,
      child: column,
    );
    return Center(
      child: SingleChildScrollView(
        child: padding
      ),
    );
  } // end buidl
} // end PaddedScroll


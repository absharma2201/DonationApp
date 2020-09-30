import 'package:flutter/material.dart';
import 'package:iwish_app/UIPages/details_cover.dart';

class DetailsPage extends StatefulWidget {
  //imagePath, name, title, location, description
  final String imagePath;
  final String name;
  final String location;
  final String description;
  final String title;
  // final List<dynamic> storyList;

  //Recieving Datas
  DetailsPage({
    this.imagePath,
    this.name,
    this.title,
    this.description,
    this.location,
  });

  @override
  State<StatefulWidget> createState() {
    return _DetailsPageState();
  }
}

class _DetailsPageState extends State<DetailsPage> {
  final PageController controller = PageController();

  //bool to make FAB FadeOut & FadeIn
  bool _visible = true;

  //Function to Scroll Down to other Page
  void scrollDown() {
    controller.animateToPage(
      1,
      curve: Curves.ease,
      duration: Duration(milliseconds: 500),
    );
  }

  //Function to FadeOut FAB
  fadeOut() {
    setState(() {
      _visible = false;
    });
  }

  //Function to FadeIn FAB
  fadeIn() {
    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        //FAB to ScrollDown Page
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.centerRight,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _visible ? 1.0 : 0,
          child: Container(
            //ScrollDown Button
            height: 50,
            width: 50,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_downward,
                ),
                onPressed: () {
                  scrollDown();
                },
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                (controller.page > 0.5) ? fadeOut() : fadeIn();
              });
            },
            controller: controller,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              DetailsCover(
                imagePath: widget.imagePath,
                name: widget.name,
                location: widget.location,
                title: widget.title,
              ),
              DetailsInfo(
                description: widget.description,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 30,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
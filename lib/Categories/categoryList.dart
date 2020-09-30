import 'package:iwish_app/Categories/category.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                Category.popularCourseList.length,
                    (int index) {
                  final int count = Category.popularCourseList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      //iWishHomePage();
                      widget.callBack();
                    },
                    category: Category.popularCourseList[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
        this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0,
                20 * (1.0 - animation.value),
                0.0
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
                //iWishHomePage();
              },
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF8FAFB),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(16.0)),
                      // border: new Border.all(
                      //     color: DesignCourseAppTheme.notWhite),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8, right: 16, left: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(16.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.0),
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 6.0),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(16.0)),
                                      child: AspectRatio(
                                          aspectRatio: 1.28,
                                          child: Image.asset(category.imagePath)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, left: 16, right: 16),
                                  child: Text(
                                    category.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      letterSpacing: 0.27,
                                      color: Color(0xFF093145),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
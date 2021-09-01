import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:papa/constants/common_size.dart';
import 'package:papa/constants/screen_size.dart';
import 'package:papa/screens/profile_screen.dart';
import 'package:papa/widgets/rounded_avatar.dart';

class ProfileBody extends StatefulWidget {
  final Function() onMenuChanged;

  const ProfileBody({Key? key, required this.onMenuChanged}) : super(key: key);
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size!.width;
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController =
        AnimationController(vsync: this, duration: duration);
    super.initState();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _appbar(),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(common_gap),
                            child: RoundedAvatar(
                              size: 80,
                            ),
                          ),
                          Expanded(
                            child: Table(
                              children: [
                                TableRow(children: [
                                  _valueText("123123"),
                                  _valueText("3123"),
                                  _valueText("123"),
                                ]),
                                TableRow(children: [
                                  _labeText("Post"),
                                  _labeText("Followers"),
                                  _labeText("Following"),
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                      _username(),
                      _userBio(),
                      _editProfileBtn(),
                      _tabButtons(),
                      _selectedIndicator(),
                    ],
                  ),
                ),
                _imagesPager(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 44,
        ),
        Expanded(
          child: Text(
            "My Profile",
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onMenuChanged();
            _iconAnimationController.status == AnimationStatus.completed
                ? _iconAnimationController.reverse()
                : _iconAnimationController.forward();
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _iconAnimationController,
          ),
        ),
      ],
    );
  }

  Text _valueText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
  Text _labeText(String label) => Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      );

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
      child: Stack(children: <Widget>[
        AnimatedContainer(
          duration: duration,
          transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
          curve: Curves.fastOutSlowIn,
          child: _images(),
        ),
        AnimatedContainer(
          duration: duration,
          transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
          curve: Curves.fastOutSlowIn,
          child: _images(),
        ),
      ]),
    );
  }

  GridView _images() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 1,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
          imageUrl: "https://picsum.photos/id/${index + 20}/100/100",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: duration,
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size!.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }

  Row _tabButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconButton(
            onPressed: () {
              _tabSelected(SelectedTab.left);
            },
            icon: ImageIcon(
              AssetImage("assets/images/grid.png"),
              color: _selectedTab == SelectedTab.left
                  ? Colors.black
                  : Colors.black26,
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () {
              _tabSelected(SelectedTab.right);
            },
            icon: ImageIcon(
              AssetImage("assets/images/saved.png"),
              color: _selectedTab == SelectedTab.left
                  ? Colors.black26
                  : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          setState(() {
            _selectedTab = SelectedTab.left;
            _leftImagesPageMargin = 0;
            _rightImagesPageMargin = size!.width;
          });
          break;
        case SelectedTab.right:
          setState(() {
            _selectedTab = SelectedTab.right;
            _leftImagesPageMargin = -size!.width;
            _rightImagesPageMargin = 0;
          });
          break;
      }
    });
  }
}

Padding _editProfileBtn() {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: common_gap, vertical: common_xxs_gap),
    child: SizedBox(
      height: 24,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.black45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    ),
  );
}

Widget _username() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      "username",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget _userBio() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      "this is what I believe!!",
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}

enum SelectedTab { left, right }

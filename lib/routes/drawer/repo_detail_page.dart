import 'package:flutter/material.dart';

class RepoDetailRoute extends StatefulWidget {
  RepoDetailRoute(this.reposOwner, this.reposName);

  final String reposOwner;
  final String reposName;

  @override
  State<StatefulWidget> createState() {
    return _RepoDetailRouteState();
  }
}

class _RepoDetailRouteState extends State<RepoDetailRoute>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.reposName),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: tabController,
                tabs: <Widget>[
                  Tab(text: 'INFO',),
                  Tab(text: 'FILES',),
                  Tab(text: 'COMMITS',),
                  Tab(text: 'ACTIVITY',)
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Center(child: Text('Content of Info'),),
                Center(child: Text('Content of Files'),),
                Center(child: Text('Content of Commits'),),
                Center(child: Text('Content of Activity'),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

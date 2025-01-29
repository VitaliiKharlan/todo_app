import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedPageIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _selectedPageIndex = value;
          });
        },
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                title: Center(
                  child: Text(
                    'TODO',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: AddNewTaskButton(theme: theme),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    separatorBuilder: (context, index) => SizedBox(width: 20),
                    padding: EdgeInsets.only(left: 20),
                    itemBuilder: (context, index) => BaseContainer(
                      width: 192,
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Monday',
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.green),
                          ),
                          SizedBox(height: 10),
                          Text('27/01/2025'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverList.builder(
                itemBuilder: (context, index) => const TaskListCard(),
              ),
            ],
          ),
          Scaffold(),
          Scaffold(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.hintColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        currentIndex: _selectedPageIndex,
        onTap: _openPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Save new task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add new task',
          ),
        ],
      ),
    );
  }

  void _openPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.bounceInOut,
      );
    });
  }
}

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.width,
    this.margin,
    required this.child,
    this.padding = const EdgeInsets.only(left: 12),
  });

  final double width;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.hintColor.withAlpha(10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.home,
            color: Colors.deepPurple,
          ),
          Text('Sliver list  Sliver list  Sliver list',
              style: theme.textTheme.bodyLarge),
          Column(
            children: [
              Text(
                '29 Jan',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 4),
              Text(
                '23:24',
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddNewTaskButton extends StatelessWidget {
  const AddNewTaskButton({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(height: 12),
          Text(
            'Add new task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.hintColor.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }
}

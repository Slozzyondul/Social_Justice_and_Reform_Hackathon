import 'package:flutter/material.dart';
import 'package:solop/frontend/widgets/main_build_button_widget.dart';
import 'package:solop/frontend/widgets/main_drawer_Item.dart';
import 'package:solop/frontend/widgets/main_drawer_widget.dart';

class MainOptionScreen extends StatelessWidget {
  const MainOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('')),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 5.0,
      ),
      drawer: mainDrawer(context),
      body: Stack(
        children: [
          // Add a background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Flexible(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildOptionButtonMain(
                      context,
                      icon: Icons.search,
                      label: 'Fact Check',
                      route: '/facts',
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(height: 20),
                    buildOptionButtonMain(
                      context,
                      icon: Icons.report,
                      label: 'Report Corruption',
                      route: '/report',
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 20),
                    buildOptionButtonMain(
                      context,
                      icon: Icons.newspaper,
                      label: 'View Reports',
                      route: '/viewreport',
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(height: 20),
                    buildOptionButtonMain(
                      context,
                      icon: Icons.people,
                      label: 'Youth Empowerment',
                      route: '/viewreport',
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(height: 20),
                    buildOptionButtonMain(
                      context,
                      icon: Icons.info,
                      label: 'Resources',
                      route: '/viewreport',
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 20),
                    buildOptionButtonMain(
                      context,
                      icon: Icons.policy,
                      label: 'Policies',
                      route: '/viewreport',
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(height: 20),
                    buildOptionButtonMain(
                      context,
                      icon: Icons.question_answer,
                      label: 'Awareness and Solutions',
                      route: '/viewreport',
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

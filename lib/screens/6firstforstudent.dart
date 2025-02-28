import 'package:flutter/material.dart';

class studentform extends StatefulWidget {
  const studentform({super.key});

  @override
  _studentform createState() => _studentform();
}

class _studentform extends State<studentform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(),
                  SurveyContainer(),
                  SurveysSection(),
                  RecentActivityContainer(),
                  BottomNavigationBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Center(
            child: Text(
              'Student Hhhome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SearchBox(),
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 8),
          Text(
            'Search surveys...',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class SurveyContainer extends StatelessWidget {
  const SurveyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: double.infinity,
      height: 257,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset('assets/exam.png',
                  width: 350, height: 146, fit: BoxFit.cover),
            ),
          ),
          Text(
            'Join Our Surveys',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 5),
          Text(
            'Your opinion matters! Participate and make a difference.',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class RecentActivityContainer extends StatelessWidget {
  const RecentActivityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 248,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Recent Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          ),
          ActivityItem(
              time: '2 hours ago',
              title: 'Survey Completed',
              description:
                  'Academic advisor Survey completed with a 5-star rating'),
          ActivityItem(
              time: '1 day ago',
              title: 'Survey Completed',
              description: 'Spring courses Survey completed and submitted'),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String time;
  final String title;
  final String description;

  const ActivityItem(
      {super.key,
      required this.time,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          SizedBox(height: 2),
          Text(description,
              style: TextStyle(fontSize: 12, color: Colors.grey[800])),
          SizedBox(height: 5),
          Text(time, style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

class SurveysSection extends StatelessWidget {
  const SurveysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 400,
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Surveys",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          SurveyCard(
              title: "Spring courses",
              subtitle: "Stat 2025",
              image: "assets/exam3.png"),
          SizedBox(height: 20),
          SurveyCard(
              title: "Academic advisors",
              subtitle: "Chem 2025",
              image: "assets/exam4.png"),
        ],
      ),
    );
  }
}

class SurveyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  const SurveyCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 108,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                ApplyButton(),
              ],
            ),
          ),
          Container(
            width: 112,
            height: 84,
            decoration: BoxDecoration(
              color: Colors.grey[300], // Placeholder background color
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 71,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(2),
      ),
      alignment: Alignment.center,
      child: Text(
        "Apply now",
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 99,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavItem(
              icon: Icons.home,
              label: "Home",
              isSelected: true,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/firsrforadminn');
              }),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isSelected ? Colors.black : Colors.grey, size: 24),
            Text(
              label,
              style: TextStyle(
                  fontSize: 10, color: isSelected ? Colors.black : Colors.grey),
            ),
          ],
        ));
  }
}

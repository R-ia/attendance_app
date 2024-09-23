import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Attendance screen to display a list of members
class AttendanceScreen extends StatelessWidget {
  final List<Member> members = [
    Member(
        name: 'Elon Musk',
        id: 'WSL0003',
        profileImage: 'assets/icons/elon.webp',
        loginTime: '09:30 am',
        logoutTime: '',
        status: 'Working'),
    Member(
        name: 'Mark Jukarbarg',
        id: 'WSL0034',
        profileImage: 'assets/icons/mark.jpeg',
        loginTime: '09:30 am',
        logoutTime: '06:40 pm',
        status: 'Logged out'),
    Member(
        name: 'Warren Buffett',
        id: 'WSL0035',
        profileImage: 'assets/icons/warren.webp',
        loginTime: '09:30 am',
        logoutTime: '06:40 pm',
        status: 'Logged out'),
    Member(
        name: 'Ratan Naval Tata',
        id: 'WSL0036',
        profileImage: 'assets/icons/ratan.webp',
        loginTime: '09:30 am',
        logoutTime: '06:40 pm',
        status: 'Logged out'),
    Member(
        name: 'Esther Howard',
        id: 'WSL0037',
        profileImage: 'assets/icons/profile1.avif',
        loginTime: '09:30 am',
        logoutTime: '',
        status: 'Working'),
    // Add more members here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return MemberTile(member: member);
        },
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final Member member;

  const MemberTile({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(member.profileImage), // Replace with your image
        radius: 30,
      ),
      title: Text('${member.name} (${member.id})'),
      subtitle: Row(
        children: [
          Icon(Icons.arrow_upward, color: Colors.green, size: 16),
          SizedBox(width: 5),
          Text(member.loginTime),
          if (member.logoutTime.isNotEmpty) ...[
            SizedBox(width: 10),
            Icon(Icons.arrow_downward, color: Colors.red, size: 16),
            SizedBox(width: 5),
            Text(member.logoutTime),
          ]
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (member.status == 'Working')
      Transform.scale(
        scale: 0.8, // Adjust the scale factor as necessary
        child: Chip(
          label: Text(member.status),
          backgroundColor: Colors.green,
        ),
      ),
          IconButton(
            icon: SvgPicture.asset(
        'assets/icons/history.svg', // Use your custom history icon here
        width: 24, // Adjust size as necessary
        height: 24,
      ),
            onPressed: () {
              // Add location viewing functionality
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
        'assets/icons/location.svg', 
        width: 24, 
        height: 24,
      ),
            onPressed: () {
              // Add location viewing functionality
            },
          ),
        ],
      ),
    );
  }
}

class Member {
  final String name;
  final String id;
  final String profileImage;
  final String loginTime;
  final String logoutTime;
  final String status;

  Member({
    required this.name,
    required this.id,
    required this.profileImage,
    required this.loginTime,
    required this.logoutTime,
    required this.status,
  });
}


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  DateTime? _selectedDate;
  String _selectedRole = 'Student';

  final List<String> roles = [
    'Student',
    'Developer',
    'Designer',
  ];

  // Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Cupertino Date Picker
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  // Cupertino Role Picker
  void _showCupertinoRolePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = roles[index]);
          },
          children: roles.map((role) {
            return Center(child: Text(role));
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor:
        Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // Portrait Layout
  Widget _buildPortraitView() {
    return ListView(
      children: [
        const StudentDetailsSection(),
        const ImageSection(
          imagePath: 'assets/images/lake.jpg',
        ),
        const TitleSection(
          name: 'Oeschinen Lake',
          location: 'Kandersteg, Switzerland',
          starCount: 41,
        ),
        const ActionButtonsSection(),
        const TextSection(),
        _buildPickerSection(),
      ],
    );
  }

  // Landscape Layout
  Widget _buildLandscapeView() {
    return Row(
      children: [
        Expanded(
          child: ListView(
            children: const [
              StudentDetailsSection(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              const ImageSection(
                imagePath: 'assets/images/lake.jpg',
              ),
              const TitleSection(
                name: 'Oeschinen Lake',
                location: 'Kandersteg, Switzerland',
                starCount: 41,
              ),
              const ActionButtonsSection(),
              const TextSection(),
              _buildPickerSection(),
            ],
          ),
        ),
      ],
    );
  }

  // Four Pickers
  Widget _buildPickerSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pickers',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // 1. Material Date Picker
          ElevatedButton(
            onPressed: () => _selectMaterialDate(context),
            child: const Text('Material Date Picker'),
          ),

          // 2. Cupertino Date Picker
          ElevatedButton(
            onPressed: () => _showCupertinoDatePicker(context),
            child: const Text('Cupertino Date Picker'),
          ),

          const SizedBox(height: 12),

          // 3. Material DropdownButton
          DropdownButton<String>(
            value: _selectedRole,
            items: roles.map((String role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => _selectedRole = newValue);
              }
            },
          ),

          // 4. Cupertino Wheel Picker
          ElevatedButton(
            onPressed: () => _showCupertinoRolePicker(context),
            child: const Text('Cupertino Wheel Picker'),
          ),
        ],
      ),
    );
  }
}

// Lab 01: Student Details
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpeg'),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Wong Ing Xin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Student ID: BCS24020039',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const Divider(height: 32, thickness: 1),

                const Text(
                  'Personal Life Goal / Quote:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  '"Never stop learning and improving myself."',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Lab 02: Image Section
class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}

// Lab 02: Title Section
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

// Lab 02: Action Buttons Section
class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(Icons.call, 'CALL'),
        _buildButton(Icons.near_me, 'ROUTE'),
        _buildButton(Icons.share, 'SHARE'),
      ],
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// Lab 02: Text Section
class TextSection extends StatelessWidget {
  const TextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'Oeschinen Lake is a beautiful mountain lake in Switzerland. '
            'It is surrounded by mountains and green forests.',
        textAlign: TextAlign.justify,
      ),
    );
  }
}

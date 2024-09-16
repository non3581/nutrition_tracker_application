import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:nutrition_tracker_application/home_page.dart'; // Import the page
=======
import 'package:nutrition_tracker_application/home_page.dart';
>>>>>>> 1a1e2685ac92b17d21d8a6c09faed1e894d2d227

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Nutrition',
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff6750a4),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            minimumSize: Size(double.infinity, 50),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white, // Set input background color to white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Color(0xff6750a4)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
=======
        title: 'Nutriton',
        home: WelcomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff6750a4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ));
>>>>>>> 1a1e2685ac92b17d21d8a6c09faed1e894d2d227
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? _selectedGender;
  String? _selectedActiveLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
<<<<<<< HEAD
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
=======
          padding: EdgeInsets.all(32),
>>>>>>> 1a1e2685ac92b17d21d8a6c09faed1e894d2d227
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'asset/images/logo.png',
                  height: 300,
                ),
              ),
              Text(
                "Let's us know about you!",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              _buildTextField(
                controller: _ageController,
                label: 'Age',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildDropdownField<String>(
                value: _selectedGender,
                label: 'Gender',
                items: ['Male', 'Female', 'Other'],
                onChanged: (value) => setState(() => _selectedGender = value),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _weightController,
                label: 'Weight (kg)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _heightController,
                label: 'Height (cm)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  final height = double.tryParse(value);
                  if (height == null || height <= 0) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildDropdownField<String>(
                value: _selectedActiveLevel,
                label: 'Active Level',
                items: [
                  'Sedentary',
                  'Lightly Active',
                  'Moderately Active',
                  'Very Active'
                ],
                onChanged: (value) => setState(() => _selectedActiveLevel = value),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your activity level';
                  }
                  return null;
                },
              ),
              SizedBox(height: 72),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
<<<<<<< HEAD
                    if (_formKey.currentState!.validate()) {
                      // Parse the text fields to doubles
                      double? weight = double.tryParse(_weightController.text);
                      double? height = double.tryParse(_heightController.text);
                      int? age = int.tryParse(_ageController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            age: age ?? 0,
                            gender: _selectedGender ?? "Not Specified",
                            weight: weight ?? 0.0,
                            height: height ?? 0.0,
                            activeLevel: _selectedActiveLevel ?? "Not Specified",
                          ),
                        ),
                      );
                    }
=======
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
>>>>>>> 1a1e2685ac92b17d21d8a6c09faed1e894d2d227
                  },
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdownField<T>({
    required T? value,
    required String label,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String? Function(T?)? validator,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

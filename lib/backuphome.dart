import 'package:flutter/material.dart';
import 'package:nutrition_tracker_application/AddFoodPage.dart';
import 'package:nutrition_tracker_application/personal.dart';

class HomePage extends StatefulWidget {
  final int age;
  final String gender;
  final double weight; // in kg
  final double height; // in cm
  final String activeLevel;

  HomePage({
    Key? key,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.activeLevel,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int age;
  late String gender;
  late double weight; // in kg
  late double height; // in cm
  late String activeLevel;

  List<Map<String, dynamic>> foodItems = [];

  double consumedCalories = 0;
  double consumedCarbs = 0;
  double consumedProtein = 0;
  double consumedFat = 0;
  double consumedWater = 0;

  @override
  void initState() {
    super.initState();
    age = widget.age;
    gender = widget.gender;
    weight = widget.weight;
    height = widget.height;
    activeLevel = widget.activeLevel;
  }

  // Function to calculate BMR
  double calculateBMR() {
    if (gender == 'Male') {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  // Function to calculate TDEE based on activity level
  double calculateTDEE() {
    double bmr = calculateBMR();
    switch (activeLevel) {
      case 'Sedentary':
        return bmr * 1.2;
      case 'Lightly active':
        return bmr * 1.375;
      case 'Moderately active':
        return bmr * 1.55;
      case 'Very active':
        return bmr * 1.725;
      case 'Super active':
        return bmr * 1.9;
      default:
        return bmr * 1.2; // Default to Sedentary
    }
  }

  // Function to calculate daily water intake requirement
  double calculateWaterRequirement() {
    return weight * 30; // Standard recommendation: 30 ml per kg of body weight
  }

  // Function to handle food addition from AddFoodPage
  void _addFood(Map<String, dynamic> newFood) {
    setState(() {
      foodItems.add(newFood);
      consumedCalories += newFood['calories'];
      consumedCarbs += newFood['carbs'];
      consumedProtein += newFood['protein'];
      consumedFat += newFood['fat'];

      // Update water intake if food is water
      if (newFood['name'].toLowerCase() == 'water') {
        consumedWater += newFood['weight'];
      }

      // Debugging logs
      print("Current foodItems: $foodItems");
    });

void _navigateAndUpdatePersonalInfo() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditPersonalInfoPage(
        age: age,
        gender: gender,
        weight: weight,
        height: height,
        activeLevel: activeLevel,
      ),
    ),
  );

  if (result != null) {
    setState(() {
      age = result['age'];
      gender = result['gender'];
      weight = result['weight'];
      height = result['height'];
      activeLevel = result['activeLevel'];
    });
  }
}

  }

  @override
  Widget build(BuildContext context) {
    double totalCalories = calculateTDEE();
    double totalWater = calculateWaterRequirement();

    double remainingCalories = totalCalories - consumedCalories;
    double remainingWater = totalWater - consumedWater;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Page'),
      //   backgroundColor: Color(0xff6750a4),
      //   titleTextStyle: TextStyle(
      //       color: Color(0xfffafafa),
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Color(0xfffafafa)),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        // Make the entire body scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            Text(
              'Hello, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),

            // Remaining Calories Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff6750a4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Calories Remaining',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6750a4),
                    ),
                  ),
                  Text(
                    '$remainingCalories kcal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        4), // Add border radius to the progress bar
                    child: LinearProgressIndicator(
                      value: consumedCalories / totalCalories,
                      color: Color(0xff6750a4),
                      backgroundColor: Color(0xff6750a4).withOpacity(0.3),
                      minHeight: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Intake $consumedCalories kcal / $totalCalories kcal',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

// Macronutrients Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff6750a4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header for Macronutrients
                  Text(
                    'Macronutrients',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6750a4),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Carbs
                      Column(
                        children: [
                          Text(
                            'Carbs',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width:
                                    80, // Increased size of circular indicator
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: 0.6, // Example progress value
                                  color: Color(0xff6750a4),
                                  backgroundColor:
                                      Color(0xff6750a4).withOpacity(0.3),
                                  strokeWidth: 8,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '30', // Consumed number
                                    style: TextStyle(
                                      fontSize:
                                          20, // Increased size of consumed number
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '/120g', // Total goal in new line
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'left 90g', // Remaining amount at the bottom
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      // Protein
                      Column(
                        children: [
                          Text(
                            'Protein',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width:
                                    80, // Increased size of circular indicator
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: 0.4, // Example progress value
                                  color: Color(0xff6750a4),
                                  backgroundColor:
                                      Color(0xff6750a4).withOpacity(0.3),
                                  strokeWidth: 8,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '24', // Consumed number
                                    style: TextStyle(
                                      fontSize:
                                          20, // Increased size of consumed number
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '/60g', // Total goal in new line
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'left 36g', // Remaining amount at the bottom
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      // Fat
                      Column(
                        children: [
                          Text(
                            'Fat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width:
                                    80, // Increased size of circular indicator
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: 0.8, // Example progress value
                                  color: Color(0xff6750a4),
                                  backgroundColor:
                                      Color(0xff6750a4).withOpacity(0.3),
                                  strokeWidth: 8,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '48', // Consumed number
                                    style: TextStyle(
                                      fontSize:
                                          20, // Increased size of consumed number
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '/60g', // Total goal in new line
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'left 12g', // Remaining amount at the bottom
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Water Intake Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff6750a4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Water Remaining',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6750a4),
                    ),
                  ),
                  Text(
                    '$remainingWater ml',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        4), // Add border radius to the progress bar
                    child: LinearProgressIndicator(
                      value: consumedWater / totalWater,
                      color: Color(0xff6750a4),
                      backgroundColor: Color(0xff6750a4).withOpacity(0.3),
                      minHeight: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Intake $consumedWater ml / $totalWater ml',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Recent Food List
            Text(
              'Recent Foods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Column(
              children: foodItems.map((food) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xff6750a4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                food['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      4), // Reduced space between name and weight
                              Text(
                                '(${food['weight']})',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${food['calories']} kcal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Carbs: ${food['carbs']}g'),
                          Text('Protein: ${food['protein']}g'),
                          Text('Fat: ${food['fat']}g'),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.bar_chart, size: 28, color: Color(0xff6750a4)),
              onPressed: () {
                // Navigate to report page
              },
            ),
            IconButton(
              icon: Icon(Icons.person, size: 28, color: Color(0xff6750a4)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPersonalInfoPage(
                      age: age,
                      gender: gender,
                      weight: weight,
                      height: height,
                      activeLevel: activeLevel,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff6750a4),
        child: Icon(Icons.add, color: Color(0xfffafafa)),
        onPressed: () async {
          final newFood = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFoodPage()),
          );

          if (newFood != null) {
            _addFood(newFood);
          }
        },
      ),
    );
  }
}

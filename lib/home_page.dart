import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int totalCalories = 2200; // Example total calories goal
  final int consumedCalories = 1400; // Example consumed calories
  final int totalWater = 3000; // Example total water intake in ml
  final int consumedWater = 1200; // Example consumed water in ml

  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Chicken Wing',
      'weight': '200g',
      'calories': 400,
      'carbs': 0,
      'protein': 30,
      'fat': 28
    },
    {
      'name': 'Salmon',
      'weight': '150g',
      'calories': 300,
      'carbs': 0,
      'protein': 25,
      'fat': 20
    },
    {
      'name': 'Rice',
      'weight': '100g',
      'calories': 130,
      'carbs': 28,
      'protein': 2,
      'fat': 0.3
    },
    {
      'name': 'Apple',
      'weight': '180g',
      'calories': 95,
      'carbs': 25,
      'protein': 0.5,
      'fat': 0.3
    },
    {
      'name': 'Broccoli',
      'weight': '100g',
      'calories': 55,
      'carbs': 11,
      'protein': 4,
      'fat': 0.6
    },
  ];

  @override
  Widget build(BuildContext context) {
    int remainingCalories = totalCalories - consumedCalories;
    int remainingWater = totalWater - consumedWater;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xff6750a4),
        titleTextStyle: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 20,
            fontWeight: FontWeight.bold),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xfffafafa)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                // Navigate to profile page
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff6750a4),
        child: Icon(Icons.add, color: Color(0xfffafafa)),
        onPressed: () {
          // Navigate to add food page
        },
      ),
    );
  }
}

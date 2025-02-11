import 'package:fit/Common_Widget/latest_activity_row.dart';
import 'package:fit/View/SleepTracker/sleep_add_alarm_view.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../Common/color_extension.dart';
import '../../Common_Widget/round_button.dart';
import 'package:hive/hive.dart';
import 'api_view.dart';

class SleepTrackerView extends StatefulWidget {
  const SleepTrackerView({super.key});

  @override
  _SleepTrackerViewState createState() => _SleepTrackerViewState();
}

class _SleepTrackerViewState extends State<SleepTrackerView> {
  List lastWorkoutArr = [
    {"image": "assets/images/bed.png", "title": "Bedtime, 09:00pm", "time": "in 6hours 22minutes"},
    {"image": "assets/images/clock.png", "title": "Alarm, 05:10am", "time": "in 14hours 30minutes"},
  ];

  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherDetails();
  }

  Future<void> fetchWeatherDetails() async {
    final box = await Hive.openBox('weatherBox'); // Open Hive Box

    print("Fetching weather data...");
    final data = await WeatherService.fetchWeather();

    if (data != null) {
      print("✅ Data fetched from API: $data");
      box.put('weatherData', data); // Store data in Hive
    } else {
      print("⚠️ Failed to fetch from API, loading from cache...");
    }

    setState(() {
      weatherData = data ?? box.get('weatherData'); // Load from API or cache
      isLoading = false;
    });

    print("📦 Cached Data: ${box.get('weatherData')}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tcolor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Tcolor.lightgrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/images/A1.png",
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: const Text(
          "Sleep Tracker",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              setState(() => isLoading = true);
              fetchWeatherDetails();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Enhanced Graph Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.withOpacity(0.2),
                          strokeWidth: 1,
                        ),
                        getDrawingVerticalLine: (value) => FlLine(
                          color: Colors.grey.withOpacity(0.2),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Text('Sun');
                                case 1:
                                  return const Text('Mon');
                                case 2:
                                  return const Text('Tue');
                                case 3:
                                  return const Text('Wed');
                                case 4:
                                  return const Text('Thu');
                                case 5:
                                  return const Text('Fri');
                                case 6:
                                  return const Text('Sat');
                                default:
                                  return const Text('');
                              }
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 5),
                            FlSpot(1, 6),
                            FlSpot(2, 7),
                            FlSpot(3, 8),
                            FlSpot(4, 6),
                            FlSpot(5, 9),
                            FlSpot(6, 7),
                          ],
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Weather Info Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Tcolor.primaryColor1, Tcolor.primaryColor2.withOpacity(0.5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isLoading
                          ? "Fetching weather..."
                          : (weatherData != null
                          ? "🌤️ ${weatherData!['weather'][0]['description'].toString().toUpperCase()}"
                          : "⚠️ No Weather Data"),
                      style: TextStyle(
                        color: Tcolor.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isLoading
                          ? ""
                          : (weatherData != null
                          ? "🌡️ Temp: ${weatherData!['main']['temp']}°C | Humidity: ${weatherData!['main']['humidity']}%"
                          : "⚠️ Failed to load"),
                      style: TextStyle(
                        color: Tcolor.black.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: lastWorkoutArr.length,
                itemBuilder: (context, index) {
                  var wObj = lastWorkoutArr[index] as Map? ?? {};
                  return InkWell(
                      onTap: () {
                        if (wObj['title'] == "Alarm, 05:10am") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SleepAddAlarmView(date: DateTime.now()),
                            ),
                          );
                        }
                      },
                      child: LatestActivityRow(wObj: wObj));
                }),
          ],
        ),
      ),
    );
  }
}

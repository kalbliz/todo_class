
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Focus / timer tab
class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  Timer? _timer;

  // CHANGED: Start from 30 minutes instead of 0.
  // 30 minutes = 30 * 60 = 1800 seconds.
  int _totalSeconds = 30 * 60;
  int _seconds = 0;

  String selectedPeriod = 'This Week';

    final List<WeeklyData> chartData = [
    WeeklyData('Mon', 30),
    WeeklyData('Tue', 50),
    WeeklyData('Wed', 40),
    WeeklyData('Thu', 80),
    WeeklyData('Fri', 60),
    WeeklyData('Sat', 95),
    WeeklyData('Sun', 45),
  ];

  bool _isRunning = false;

  void _toggleTimer() {
    if (_isRunning) {
      // CHANGED: Pause the timer without resetting the time.
      _timer?.cancel();

      setState(() {
        _isRunning = false;
      });
    } else {
      // Start the timer to tick every 1 second.
      setState(() {
        _isRunning = true;
      });

      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          // ADDED: Stop when the 30-minute session is complete.
          if (_seconds >= _totalSeconds) {
            timer.cancel();

            setState(() {
              _isRunning = false;
            });

            return;
          }

          setState(() {
            // Count the elapsed time.
            _seconds++;
          });
        },
      );
    }
  }

  // ADDED: Reset the timer back to zero.
  void _resetTimer() {
    _timer?.cancel();

    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    // Cancel the timer when leaving this page.
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ADDED: Calculate the progress of the timer.
    // Starts at 0.0 and increases to 1.0.
    double progress = _seconds / _totalSeconds;

    // ADDED: Convert seconds into minutes and seconds.
    String minutes = (_seconds ~/ 60)
        .toString()
        .padLeft(2, '0');

    String seconds = (_seconds % 60)
        .toString()
        .padLeft(2, '0');

    return Scaffold(
      // backgroundColor: const Color(0xFF252A33),

      appBar: AppBar(
        title: const Text('Focus'),
        // backgroundColor: const Color(0xFF252A33),
        // foregroundColor: Colors.white,
      ),

      body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
            
                // ADDED: Circular timer.
                // Stack allows us to place the time inside the circle.
                SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ADDED: Grey circle (the full background track).
                      SizedBox(
                        width: 190,
                        height: 190,
                        child: CircularProgressIndicator(
                          value: 1.0,
                          strokeWidth: 8,
                          backgroundColor: Colors.transparent,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(
                            Color(0xFF555B66),
                          ),
                        ),
                      ),
            
                      // ADDED: Blue circle that changes as time passes.
                      SizedBox(
                        width: 190,
                        height: 190,
                        child: CircularProgressIndicator(
                          // This value controls how much of the circle is blue.
                          value: progress,
                          strokeWidth: 8,
                          strokeCap: StrokeCap.round,
                          backgroundColor: Colors.transparent,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(
                            Color(0xFF80B4FF),
                          ),
                        ),
                      ),
            
                      // CHANGED: The timer text sits in the centre.
                      Text(
                        '$minutes:$seconds',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 17, 16, 16),
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 30),
            
                // ADDED: Description beneath the timer.
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'While your focus mode is on, '
                    'all of your notifications will be off.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(179, 15, 14, 14),
                    ),
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // CHANGED: Button now starts and pauses the timer.
                ElevatedButton(
                  onPressed: _toggleTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isRunning ? const Color.fromARGB(255, 229, 51, 24) : Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    _isRunning ? 'Pause Focus' : 'Start Focusing',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              
                // ADDED: Reset button.
                TextButton(
                  onPressed: _resetTimer,
                  child: const Text(
                    'Reset Timer',
                    style: TextStyle(color: Color.fromARGB(179, 14, 12, 12), fontSize: 16),
                  ),
                ),
                SizedBox(height: 45,),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text("Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                      SizedBox(width: 145,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 115, 125, 143),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedPeriod,
                                dropdownColor: Color(0xFF414957),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: 'This Week',
                                    child: Text('This Week'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Lasr Week',
                                    child: Text('Last Week'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'This Year',
                                    child: Text('This Year'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedPeriod = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                      )
                    ],
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                         padding: const EdgeInsets.all(16),
                         decoration: BoxDecoration(
                           color:  Colors.transparent,
                           borderRadius: BorderRadius.circular(16),
                         ),
                         child: SizedBox(
                           height: 280,
                           child: SfCartesianChart(
                             plotAreaBorderWidth: 0,
                   
                             primaryXAxis: CategoryAxis(
                               labelStyle: const TextStyle(
                                 color: Color.fromARGB(179, 12, 12, 12),
                               ),
                               majorGridLines: const MajorGridLines(width: 0),
                               axisLine: const AxisLine(width: 0),
                               majorTickLines: const MajorTickLines(size: 0),
                             ),
                   
                             primaryYAxis: NumericAxis(
                               minimum: 1,
                               maximum: 100,
                               interval: 20,
                               labelStyle: const TextStyle(
                                 color: Color.fromARGB(137, 11, 11, 11),
                                 fontSize: 11,
                               ),
                               axisLine: const AxisLine(width: 0),
                               majorTickLines: const MajorTickLines(size: 0),
                               majorGridLines: MajorGridLines(
                                 color: const Color.fromARGB(255, 9, 9, 9).withValues(alpha: 0.1),
                               ),
                             ),
                   
                             series: <CartesianSeries<WeeklyData, String>>[
                               ColumnSeries<WeeklyData, String>(
                                 dataSource: chartData,
                                 xValueMapper: (WeeklyData data, _) => data.day,
                                 yValueMapper: (WeeklyData data, _) => data.value,
                   
                                 color: const Color(0xFF6485FF),
                                 borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                                 ),
                   
                                 dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 9, 9, 9),
                      fontSize: 11,
                    ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                 ),
                
                 Padding(
                   padding: const EdgeInsets.only(left: 24),
                   child: Row(
                    children: [Text("Applications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),],
                   ),
                 ),
                SizedBox(height: 18,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Container(
    height: 80,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: const Color(0xFF66717F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // App icon
         Image.asset("assets/images/brand/instagram.png"),
  
        const SizedBox(width: 15),
  
        // App name and usage time
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instagram',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'You spent 4h on Instagram today',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
  
        // Vertical divider
        Container(
          height: 55,
          width: 2,
          color: Colors.white54,
        ),
  
        const SizedBox(width: 15),
  
        // Information icon
        const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 27,
        ),
      ],
    ),
  ),
),
SizedBox(height: 16,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Container(
    height: 80,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: const Color(0xFF66717F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // App icon
         Image.asset("assets/images/brand/twitter.png"),
  
        const SizedBox(width: 15),
  
        // App name and usage time
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Twitter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'You spent 3h on Twitter today',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
  
        // Vertical divider
        Container(
          height: 55,
          width: 2,
          color: Colors.white54,
        ),
  
        const SizedBox(width: 15),
  
        // Information icon
        const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 27,
        ),
      ],
    ),
  ),
),
SizedBox(height: 16,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Container(
    height: 80,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: const Color(0xFF66717F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // App icon
         Image.asset("assets/images/brand/Facebook.png", height: 30, width: 30,),
  
        const SizedBox(width: 15),
  
        // App name and usage time
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Facebook',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'You spent 1h on Facebook today',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
  
        // Vertical divider
        Container(
          height: 55,
          width: 2,
          color: Colors.white54,
        ),
  
        const SizedBox(width: 15),
  
        // Information icon
        const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 27,
        ),
      ],
    ),
  ),
),
SizedBox(height: 16,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Container(
    height: 80,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: const Color(0xFF66717F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // App icon
         Image.asset("assets/images/brand/telegram.png"),
  
        const SizedBox(width: 15),
  
        // App name and usage time
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Telegram',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'You spent 30m on Telegram today',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
  
        // Vertical divider
        Container(
          height: 55,
          width: 2,
          color: Colors.white54,
        ),
  
        const SizedBox(width: 15),
  
        // Information icon
        const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 27,
        ),
      ],
    ),
  ),
),
SizedBox(height: 16,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Container(
    height: 80,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: const Color(0xFF66717F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // App icon
         Image.asset("assets/images/brand/gmail.png"),
  
        const SizedBox(width: 15),
  
        // App name and usage time
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gmail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'You spent 44m on Gmail today',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
  
        // Vertical divider
        Container(
          height: 55,
          width: 2,
          color: Colors.white54,
        ),
  
        const SizedBox(width: 15),
  
        // Information icon
        const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 27,
        ),
      ],
    ),
  ),
),
SizedBox(height: 16,)
              ],
            ),
          ),
      ),
    );
  }
}

class WeeklyData {
  WeeklyData(this.day, this.value);

  String day;
  double value;
}


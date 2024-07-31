import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // استخدم مكتبة intl للتعامل مع التواريخ

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String content = 'محتوى يوم معين';
  bool isLoading = false;

  void _onDateChanged(String newContent) {
    setState(() {
      content = newContent;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Date Selection Bar'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          DateSelectionBar(onDateChanged: _onDateChanged),
          Expanded(
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : AnimatedSwitcher(
                      duration: Duration(milliseconds: 100),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        content,
                        key: ValueKey<String>(content),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateSelectionBar extends StatefulWidget {
  final ValueChanged<String>? onDateChanged;

  DateSelectionBar({this.onDateChanged});

  @override
  _DateSelectionBarState createState() => _DateSelectionBarState();
}

class _DateSelectionBarState extends State<DateSelectionBar> {
  late List<DateItem> dates;
  late int selectedIndex;
  bool isFirstLoad = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    dates = _generateDatesForCurrentMonth();
    selectedIndex = DateTime.now().day - 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
      _updateContent();
    });
  }

  List<DateItem> _generateDatesForCurrentMonth() {
    List<DateItem> generatedDates = [];
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(now.year, now.month, i);
      String dayName = DateFormat('EEEE', 'ar').format(date);
      generatedDates.add(DateItem(dayName, i.toString()));
    }

    return generatedDates;
  }

  void _onDateSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    Future.delayed(Duration(seconds: 1), () {
      _updateContent();
      _scrollToSelectedIndex();
    });
  }

  void _updateContent() {
    String newContent =
        'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
    widget.onDateChanged?.call(newContent);
  }

  void _scrollToSelectedIndex() {
    if (isFirstLoad) {
      double position = selectedIndex * 60.0;
      _scrollController.animateTo(
        position,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      isFirstLoad = false;
    }
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _scrollLeft(),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dates
                    .asMap()
                    .entries
                    .map((entry) => GestureDetector(
                          onTap: () => _onDateSelected(entry.key),
                          child: DateWidget(
                            dateItem: entry.value,
                            isSelected: selectedIndex == entry.key,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () => _scrollRight(),
          ),
        ],
      ),
    );
  }
}

class DateItem {
  final String day;
  final String date;

  DateItem(this.day, this.date);
}

class DateWidget extends StatelessWidget {
  final DateItem dateItem;
  final bool isSelected;

  DateWidget({required this.dateItem, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Text(
            dateItem.day,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                dateItem.date,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          if (isSelected)
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   late int selectedIndex;
//   String content = 'محتوى يوم';
//   bool isLoading = false;
//   bool isFirstLoad = true;
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForCurrentMonth();
//     selectedIndex = DateTime.now().day - 1; // تحديد اليوم الحالي كمؤشر تلقائي
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToSelectedIndex();
//       _updateContent();
//     });
//   }
//
//   List<DateItem> _generateDatesForCurrentMonth() {
//     List<DateItem> generatedDates = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(now.year, now.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       isLoading = true;
//       selectedIndex = index;
//     });
//
//     // محاكاة عملية تحميل (مثل جلب بيانات من خادم)
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         isLoading = false;
//         _updateContent();
//         _scrollToSelectedIndex();
//       });
//     });
//   }
//
//   void _updateContent() {
//     setState(() {
//       content =
//           'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
//     });
//   }
//
//   void _scrollToSelectedIndex() {
//     if (isFirstLoad) {
//       double position =
//           selectedIndex * 60.0; // تحديد الموقع المناسب للتاريخ المحدد
//       _scrollController.animateTo(
//         position,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       isFirstLoad = false; // تعيين isFirstLoad إلى false بعد التمرير الأولي
//     }
//   }
//
//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//             scrollController: _scrollController,
//             scrollLeft: _scrollLeft,
//             scrollRight: _scrollRight,
//           ),
//           Expanded(
//             child: Center(
//               child: isLoading
//                   ? CircularProgressIndicator()
//                   : AnimatedSwitcher(
//                       duration: Duration(milliseconds: 300),
//                       transitionBuilder:
//                           (Widget child, Animation<double> animation) {
//                         return FadeTransition(opacity: animation, child: child);
//                       },
//                       child: Text(
//                         content,
//                         key: ValueKey<String>(content),
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//   final ScrollController scrollController;
//   final Function scrollLeft;
//   final Function scrollRight;
//
//   DateSelectionBar({
//     required this.dates,
//     required this.selectedIndex,
//     required this.onDateSelected,
//     required this.scrollController,
//     required this.scrollLeft,
//     required this.scrollRight,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => scrollLeft(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               controller: scrollController,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () => scrollRight(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 40,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               // shape: BoxShape.circle,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Column(
//                 children: [
//                   Text(
//                     dateItem.day,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.grey,
//                       fontWeight:
//                           isSelected ? FontWeight.bold : FontWeight.normal,
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     dateItem.date,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.grey,
//                       fontWeight:
//                           isSelected ? FontWeight.bold : FontWeight.normal,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   late int selectedIndex;
//   String content = 'محتوى يوم';
//   bool isLoading = false;
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForCurrentMonth();
//     selectedIndex = DateTime.now().day - 1; // تحديد اليوم الحالي كمؤشر تلقائي
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToSelectedIndex();
//       _updateContent();
//     });
//   }
//
//   List<DateItem> _generateDatesForCurrentMonth() {
//     List<DateItem> generatedDates = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(now.year, now.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       isLoading = true;
//       selectedIndex = index;
//     });
//
//     // محاكاة عملية تحميل (مثل جلب بيانات من خادم)
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         isLoading = false;
//         _updateContent();
//         _scrollToSelectedIndex();
//       });
//     });
//   }
//
//   void _updateContent() {
//     setState(() {
//       content =
//           'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
//     });
//   }
//
//   void _scrollToSelectedIndex() {
//     double position =
//         selectedIndex * 60.0; // تحديد الموقع المناسب للتاريخ المحدد
//     _scrollController.animateTo(
//       position,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//             scrollController: _scrollController,
//             scrollLeft: _scrollLeft,
//             scrollRight: _scrollRight,
//           ),
//           Expanded(
//             child: Center(
//               child: isLoading
//                   ? CircularProgressIndicator()
//                   : AnimatedSwitcher(
//                       duration: Duration(milliseconds: 300),
//                       transitionBuilder:
//                           (Widget child, Animation<double> animation) {
//                         return FadeTransition(opacity: animation, child: child);
//                       },
//                       child: Text(
//                         content,
//                         key: ValueKey<String>(content),
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//   final ScrollController scrollController;
//   final Function scrollLeft;
//   final Function scrollRight;
//
//   DateSelectionBar({
//     required this.dates,
//     required this.selectedIndex,
//     required this.onDateSelected,
//     required this.scrollController,
//     required this.scrollLeft,
//     required this.scrollRight,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => scrollLeft(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               controller: scrollController,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () => scrollRight(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

/// اختيار يوم هوا يوم محدد

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   late int selectedIndex;
//   String content = 'محتوى يوم';
//   bool isLoading = false;
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForCurrentMonth();
//     selectedIndex = DateTime.now().day - 1; // تحديد اليوم الحالي كمؤشر تلقائي
//     _updateContent();
//   }
//
//   List<DateItem> _generateDatesForCurrentMonth() {
//     List<DateItem> generatedDates = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(now.year, now.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       isLoading = true;
//       selectedIndex = index;
//     });
//
//     // محاكاة عملية تحميل (مثل جلب بيانات من خادم)
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         isLoading = false;
//         _updateContent();
//       });
//     });
//   }
//
//   void _updateContent() {
//     setState(() {
//       content =
//           'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
//     });
//   }
//
//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//             scrollController: _scrollController,
//             scrollLeft: _scrollLeft,
//             scrollRight: _scrollRight,
//           ),
//           Expanded(
//             child: Center(
//               child: isLoading
//                   ? CircularProgressIndicator()
//                   : AnimatedSwitcher(
//                       duration: Duration(milliseconds: 300),
//                       transitionBuilder:
//                           (Widget child, Animation<double> animation) {
//                         return FadeTransition(opacity: animation, child: child);
//                       },
//                       child: Text(
//                         content,
//                         key: ValueKey<String>(content),
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//   final ScrollController scrollController;
//   final Function scrollLeft;
//   final Function scrollRight;
//
//   DateSelectionBar({
//     required this.dates,
//     required this.selectedIndex,
//     required this.onDateSelected,
//     required this.scrollController,
//     required this.scrollLeft,
//     required this.scrollRight,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => scrollLeft(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               controller: scrollController,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () => scrollRight(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// يوم والانميشن
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   int selectedIndex = 0;
//   String content = 'محتوى يوم';
//   bool isLoading = false;
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForCurrentMonth();
//     _updateContent();
//   }
//
//   List<DateItem> _generateDatesForCurrentMonth() {
//     List<DateItem> generatedDates = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(now.year, now.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       isLoading = true;
//       selectedIndex = index;
//     });
//
//     // محاكاة عملية تحميل (مثل جلب بيانات من خادم)
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         isLoading = false;
//         _updateContent();
//       });
//     });
//   }
//
//   void _updateContent() {
//     setState(() {
//       content =
//           'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
//     });
//   }
//
//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//             scrollController: _scrollController,
//             scrollLeft: _scrollLeft,
//             scrollRight: _scrollRight,
//           ),
//           Expanded(
//             child: Center(
//               child: isLoading
//                   ? CircularProgressIndicator()
//                   : AnimatedSwitcher(
//                       duration: Duration(milliseconds: 300),
//                       transitionBuilder:
//                           (Widget child, Animation<double> animation) {
//                         return FadeTransition(opacity: animation, child: child);
//                       },
//                       child: Text(
//                         content,
//                         key: ValueKey<String>(content),
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//   final ScrollController scrollController;
//   final Function scrollLeft;
//   final Function scrollRight;
//
//   DateSelectionBar({
//     required this.dates,
//     required this.selectedIndex,
//     required this.onDateSelected,
//     required this.scrollController,
//     required this.scrollLeft,
//     required this.scrollRight,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => scrollLeft(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               controller: scrollController,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () => scrollRight(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   int selectedIndex = 0;
//   String content = 'محتوى يوم';
//   bool isLoading = false;
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForCurrentMonth();
//     _updateContent();
//   }
//
//   List<DateItem> _generateDatesForCurrentMonth() {
//     List<DateItem> generatedDates = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(now.year, now.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       isLoading = true;
//       selectedIndex = index;
//     });
//
//     // محاكاة عملية تحميل (مثل جلب بيانات من خادم)
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         isLoading = false;
//         _updateContent();
//       });
//     });
//   }
//
//   void _updateContent() {
//     setState(() {
//       content =
//           'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
//     });
//   }
//
//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//             scrollController: _scrollController,
//             scrollLeft: _scrollLeft,
//             scrollRight: _scrollRight,
//           ),
//           Expanded(
//             child: Center(
//               child: isLoading
//                   ? CircularProgressIndicator()
//                   : AnimatedSwitcher(
//                       duration: Duration(milliseconds: 300),
//                       child: Text(
//                         content,
//                         key: ValueKey<String>(content),
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//   final ScrollController scrollController;
//   final Function scrollLeft;
//   final Function scrollRight;
//
//   DateSelectionBar({
//     required this.dates,
//     required this.selectedIndex,
//     required this.onDateSelected,
//     required this.scrollController,
//     required this.scrollLeft,
//     required this.scrollRight,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => scrollLeft(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               controller: scrollController,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () => scrollRight(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   int selectedIndex = 0;
//   String content = 'محتوى يوم';
//   DateTime currentMonth = DateTime.now();
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForMonth(currentMonth);
//     _updateContent();
//   }
//
//   List<DateItem> _generateDatesForMonth(DateTime month) {
//     List<DateItem> generatedDates = [];
//     int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(month.year, month.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//       _updateContent();
//     });
//   }
//
//   void _updateContent() {
//     setState(() {
//       content =
//           'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
//     });
//   }
//
//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _previousMonth() {
//     setState(() {
//       currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
//       dates = _generateDatesForMonth(currentMonth);
//       selectedIndex = 0;
//       _updateContent();
//     });
//   }
//
//   void _nextMonth() {
//     setState(() {
//       currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
//       dates = _generateDatesForMonth(currentMonth);
//       selectedIndex = 0;
//       _updateContent();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back, color: Colors.white),
//                 onPressed: _previousMonth,
//               ),
//               Text(
//                 DateFormat.yMMM('ar').format(currentMonth),
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               IconButton(
//                 icon: Icon(Icons.arrow_forward, color: Colors.white),
//                 onPressed: _nextMonth,
//               ),
//             ],
//           ),
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//             scrollController: _scrollController,
//             scrollLeft: _scrollLeft,
//             scrollRight: _scrollRight,
//           ),
//           Expanded(
//             child: Center(
//               child: AnimatedSwitcher(
//                 duration: Duration(milliseconds: 300),
//                 child: Text(
//                   content,
//                   key: ValueKey<String>(content),
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//   final ScrollController scrollController;
//   final Function scrollLeft;
//   final Function scrollRight;
//
//   DateSelectionBar({
//     required this.dates,
//     required this.selectedIndex,
//     required this.onDateSelected,
//     required this.scrollController,
//     required this.scrollLeft,
//     required this.scrollRight,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => scrollLeft(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               controller: scrollController,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () => scrollRight(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

/// this code is test okkkkkkkk
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   int selectedIndex = 0;
//   String content = 'محتوى يوم';
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForCurrentMonth();
//     _updateContent();
//   }
//
//   List<DateItem> _generateDatesForCurrentMonth() {
//     List<DateItem> generatedDates = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(now.year, now.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//       _updateContent();
//     });
//   }
//
//   void _updateContent() {
//     setState(() {
//       content =
//           'محتوى يوم ${dates[selectedIndex].day} ${dates[selectedIndex].date}';
//     });
//   }
//
//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 100,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//             scrollController: _scrollController,
//             scrollLeft: _scrollLeft,
//             scrollRight: _scrollRight,
//           ),
//           Expanded(
//             child: Center(
//               child: AnimatedSwitcher(
//                 duration: Duration(milliseconds: 300),
//                 child: Text(
//                   content,
//                   key: ValueKey<String>(content),
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//   final ScrollController scrollController;
//   final Function scrollLeft;
//   final Function scrollRight;
//
//   DateSelectionBar({
//     required this.dates,
//     required this.selectedIndex,
//     required this.onDateSelected,
//     required this.scrollController,
//     required this.scrollLeft,
//     required this.scrollRight,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => scrollLeft(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               controller: scrollController,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () => scrollRight(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// اص
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<DateItem> dates;
//   int selectedIndex = 0;
//   String content = 'محتوى يوم';
//
//   @override
//   void initState() {
//     super.initState();
//     dates = _generateDatesForCurrentMonth();
//   }
//
//   List<DateItem> _generateDatesForCurrentMonth() {
//     List<DateItem> generatedDates = [];
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       DateTime date = DateTime(now.year, now.month, i);
//       String dayName =
//           DateFormat('EEEE', 'ar').format(date); // عرض اسم اليوم بالعربية
//       generatedDates.add(DateItem(dayName, i.toString()));
//     }
//
//     return generatedDates;
//   }
//
//   void _onDateSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//       content = 'محتوى يوم ${dates[index].day}';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 '$content ${dates[selectedIndex].date}',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//
//   DateSelectionBar(
//       {required this.dates,
//       required this.selectedIndex,
//       required this.onDateSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//               // تنفيذ التمرير للخلف
//             },
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: dates
//                     .asMap()
//                     .entries
//                     .map((entry) => GestureDetector(
//                           onTap: () => onDateSelected(entry.key),
//                           child: DateWidget(
//                             dateItem: entry.value,
//                             isSelected: selectedIndex == entry.key,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.arrow_forward, color: Colors.white),
//             onPressed: () {
//               // تنفيذ التمرير للأمام
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//
//   DateItem(this.day, this.date);
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final List<DateItem> dates = [
//     DateItem('الاثنين', '29'),
//     DateItem('الثلاثاء', '30'),
//     DateItem('الأربعاء', '31'),
//     DateItem('الخميس', '1'),
//     DateItem('الجمعة', '2'),
//     DateItem('السبت', '3'),
//     DateItem('الأحد', '4'),
//   ];
//
//   int selectedIndex = 2;
//   String content = 'محتوى يوم الأربعاء';
//
//   void _onDateSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//       content = 'محتوى يوم ${dates[index].day}';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Date Selection Bar'),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           DateSelectionBar(
//             dates: dates,
//             selectedIndex: selectedIndex,
//             onDateSelected: _onDateSelected,
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 content,
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DateSelectionBar extends StatelessWidget {
//   final List<DateItem> dates;
//   final int selectedIndex;
//   final Function(int) onDateSelected;
//
//   DateSelectionBar(
//       {required this.dates,
//       required this.selectedIndex,
//       required this.onDateSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: dates
//             .asMap()
//             .entries
//             .map((entry) => GestureDetector(
//                   onTap: () => onDateSelected(entry.key),
//                   child: DateWidget(
//                     dateItem: entry.value,
//                     isSelected: selectedIndex == entry.key,
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
//
// class DateItem {
//   final String day;
//   final String date;
//   final bool isSelected;
//
//   DateItem(this.day, this.date, {this.isSelected = false});
// }
//
// class DateWidget extends StatelessWidget {
//   final DateItem dateItem;
//   final bool isSelected;
//
//   DateWidget({required this.dateItem, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         children: [
//           Text(
//             dateItem.day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//           SizedBox(height: 5),
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.blue : Colors.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 dateItem.date,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           if (isSelected)
//             Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

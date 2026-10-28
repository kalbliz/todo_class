import 'package:flutter/material.dart';
import 'package:todo_class/utils/text_fields/app_text_field.dart';


class Addcategory extends StatefulWidget {
  const Addcategory({super.key});
  @override
  State<Addcategory> createState() => _Addcategory();
}

class _Addcategory extends State<Addcategory> {
   final TextEditingController _textController = TextEditingController();
   final List<Color> customColors = [
  const Color.fromARGB(255, 218, 142, 137),
  const Color.fromARGB(255, 161, 200, 232),
  const Color.fromARGB(255, 155, 225, 157),
  const Color.fromARGB(255, 227, 188, 130),
  const Color.fromARGB(255, 222, 150, 234),
  const Color.fromARGB(255, 230, 145, 173),
  const Color.fromARGB(255, 208, 225, 112),
  const Color.fromARGB(255, 115, 183, 209),
  const Color.fromARGB(255, 160, 145, 216),
  const Color.fromARGB(255, 236, 232, 136),
  const Color.fromARGB(255, 233, 211, 210),
];

   @override
  void dispose() {
    // Always dispose your controllers to avoid memory leaks
    _textController.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text("Create new category", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),),
          ),
           SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text("Category name:", style: TextStyle(fontSize: 16, color: Colors.black,),),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 31, 25, 25), width: 0.8),
                ),
                      // Border when the user is actively typing in the field
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 23, 26, 28), width: 1),
                ),
                // labelText: 'Category name', // Moves to top on focus
                hintText: 'Category name',   
                hintStyle: TextStyle(),     // Placeholder text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text("Category icon:", style: TextStyle(fontSize: 16, color: Colors.black),),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 235, 219, 219),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Adjust radius here
                ),
              ),
              onPressed: () {
                // Add your button click action here
                print('Button Pressed!');
              },
              child: const Text('Choose icon from library', style: TextStyle(fontSize: 12, color: Colors.black),),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text("Category color:", style: TextStyle(fontSize: 16, color: Colors.black),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: SizedBox(
              height: 80, // Set a fixed height for the scrollable row
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                itemCount: 11, // Number of circular containers
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration:  BoxDecoration(
                         color: customColors[index % customColors.length], 
                         shape: BoxShape.circle, // Makes the container circular
                      ),
                                //         child: Center(
                                // child: Text(
                                //   '$index',
                                //   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                // ),
                                //         ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 325,),
          Row(
            children: [
              Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                fixedSize: Size(154, 48),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Adjust radius here
                ),
              ),
              onPressed: () {
                // Add your button click action here
                print('Button Pressed!');
              },
              child: const Text('Cancel', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 107, 122, 237)),),
            ),
          ),
             Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: Size(160, 48),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Adjust radius here
                ),
              ),
              onPressed: () {
                // Add your button click action here
                print('Button Pressed!');
              },
              child: const Text('Create Category', style: TextStyle(fontSize: 16, color: Colors.white),),
            ),
          ),
            ],
          )
        ],
      ),
    );
  }
}
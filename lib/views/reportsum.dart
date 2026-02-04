import 'package:dialo/constants/app_textstyle.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ReportSum extends StatefulWidget {
  const ReportSum({super.key});

  @override
  State<ReportSum> createState() => _ReportSumState();
}

class _ReportSumState extends State<ReportSum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  centerTitle: true,
  title: Text("Reports",style: AppTextstyle.Maintitle,),
),
      body: Padding(
        padding: const EdgeInsets.all(7),
      child:
      SingleChildScrollView(
        child:
      Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.textColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Swabirin", style: AppTextstyle.SubTitle),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                        Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.themeColor,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: AppColors.whitetext,
                      ),
                    ),
                    Text("Pending", style: AppTextstyle.MiniText),
                  ],
                ),
                Row(
                  children: [
                    Text("priority:"),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(children: [Text("Handle time:"), Text("3m 32s"),
                  Spacer(),
                  Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                        Text("Call",style: TextStyle(color: AppColors.whitetext),)
                      ],
                    ),

                  )]
                ),

              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),

          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),

          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Swabirin", style: AppTextstyle.SubTitle),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined,color: AppColors.greenColor,),
                            Text("Completed",style: TextStyle(color: AppColors.greenColor),),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.themeColor,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: AppColors.whitetext,
                          ),
                        ),
                        Text("Pending", style: AppTextstyle.MiniText),
                      ],
                    ),
                    Row(
                      children: [
                        Text("priority:"),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        ),
                        Text("High"),
                      ],
                    ),
                    Row(children: [Text("Handle time:"), Text("3m 32s"),
                      Spacer(),
                      Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.call_end,color: AppColors.whitetext,size: 20,),

                            Text("Call",style: TextStyle(color: AppColors.whitetext),)
                          ],
                        ),

                      )]
                    ),

                  ],
                ),
              ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alice cooper", style: AppTextstyle.SubTitle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                      ),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: AppColors.whitetext,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.warning_amber,
                            color: AppColors.whitetext,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Priority:"),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.redColor,
                    ),
                    Text("High"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Handle Time:",
                    ),
                    Text("5m 20s"),
                    Spacer(),
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_end,
                            color: AppColors.whitetext,
                            size: 20,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
      ),
    );
  }
}

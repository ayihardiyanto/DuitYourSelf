// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

import 'package:duit_yourself/presentation/screens/dashboard/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/profile/general_form_layout.dart';
import 'package:duit_yourself/presentation/screens/job_posting/bloc/job_posting_bloc.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dashboard/base_layout.dart';

class EditableJobScreen extends StatefulWidget {
  final String jobId;

  const EditableJobScreen({Key key, this.jobId}) : super(key: key);
  @override
  _EditableJobScreenState createState() => _EditableJobScreenState();
}

class _EditableJobScreenState extends State<EditableJobScreen> {
  TextEditingController jobTitle;
  JobPostBloc bloc;
  DashboardBloc dashboardBloc;
  TextEditingController description;
  TextEditingController requirement;
  TextEditingController currency;
  TextEditingController budget;
  TabController profileTab;
  bool isPictHovered = false;
  Uint8List uploadedImage;
  String error;
  Image displayedImage;
  File savedImage;
  dynamic base64;
  bool checkBoxValue = false;

  @override
  void initState() {
    super.initState();
    // profileTab = TabController(length: 1, vsync: this);
    // widget.bloc.add(GetUserData());
    bloc = BlocProvider.of<JobPostBloc>(context);
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    if (widget.jobId != null) {
      bloc.add(OpenJob(jobId: widget.jobId));
    }
    jobTitle = TextEditingController();
    description = TextEditingController();
    requirement = TextEditingController();
    currency = TextEditingController();
    budget = TextEditingController();
    jobTitle.addListener(() {
      setState(() {});
    });
    description.addListener(() {
      setState(() {});
    });
    requirement.addListener(() {
      setState(() {});
    });
    currency.addListener(() {
      setState(() {});
    });
    budget.addListener(() {
      setState(() {});
    });
  }

  void hoverPicture(bool isHovered) {
    setState(() {
      isPictHovered = isHovered;
    });
  }

  void render() {
    setState(() {});
  }

  void startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        print('file $file');

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
            savedImage = files[0];
            displayedImage = Image.memory(
              uploadedImage,
              fit: BoxFit.cover,
              height: 800,
              width: 800,
            );
          });
        });

        print('result ${reader.result}');

        reader.onError.listen((fileEvent) {
          setState(() {
            error = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('IMAGE ${widget.image}');
    return BlocListener<JobPostBloc, JobPostState>(
      listener: (context, state) {
        if (state is JobPostSaved) {
          dashboardBloc.add(Home());
        }
      },
      child: Center(
        child: Container(
          width: 1280,
          constraints:
              BoxConstraints(minWidth: 600, maxHeight: double.infinity),
          child: BaseLayout(
            // arguments: widget.arguments,
            flexLeft: 3,
            flexRight: 1,
            rightColumn: Column(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onHover: (e) {
                    hoverPicture(true);
                  },
                  onExit: (event) {
                    hoverPicture(false);
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: displayedImage != null ? null : Yellow.mangoYellow,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: displayedImage ??
                                Icon(
                                  Icons.camera_alt,
                                  size: 100,
                                  color: White.white,
                                ),
                          )
                          //  ??
                          //     Image(
                          //       image: widget.image,
                          //       fit: BoxFit.cover,
                          //       height: 800,
                          //       width: 800,
                          //     ),
                          ,
                          if (isPictHovered)
                            GestureDetector(
                              onTap: () {
                                startFilePicker();
                              },
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      color: Colors.black38,
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: White.white,
                                          ),
                                        ),
                                        Text(
                                          'Change',
                                          style: PxText.contentText.copyWith(
                                              color: White.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            leftColumn: Column(
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 200, maxHeight: 550),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 3.0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Center(
                      child: GeneralFormLayout(
                        isJobScreen: true,
                        checkBoxValue: checkBoxValue,
                        onCheckedBox: (value) {
                          print('CHECKBOX VALUE $value');
                          setState(() {
                            checkBoxValue = value;
                          });
                        },
                        isButtonEnabled: jobTitle.text.isNotEmpty &&
                            requirement.text.isNotEmpty &&
                            description.text.isNotEmpty && currency.text.isNotEmpty && budget.text.isNotEmpty,
                        normalSizeController1: jobTitle,
                        normalSizeController2: requirement,
                        isShimmer: false,
                        normalSizeTitle1: 'Job Title',
                        normalSizeTitle2: 'Requirements',
                        normalSizeController3: currency,
                        normalSizeController4: budget,
                        mediumSizeTitle1: 'Description',
                        mediumSizeController1: description,
                        render: render,
                        onSave: () {
                          print('CHECK BOX VALUE $checkBoxValue');
                          bloc.add(SaveJob(
                            jobId: widget.jobId,
                            jobTitle: jobTitle.text,
                            description: description.text,
                            image: savedImage,
                            status: checkBoxValue ? 'open' : 'closed',
                            requirement: requirement.text,
                          ));
                        },
                        onCancel: () {
                          dashboardBloc.add(Home());
                        },
                      ),
                    ),
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

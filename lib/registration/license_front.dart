import 'dart:math';
import 'package:bblease/class_user.dart';
import 'package:bblease/registration/sucsses.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';



class LicenseFront extends StatefulWidget {
  const LicenseFront({Key? key}) : super(key: key);

  @override
  State<LicenseFront> createState() => _LicenseFrontState();
}

class _LicenseFrontState extends State<LicenseFront> {

  late List<CameraDescription> cameras;
  late CameraController _cameraController;
  late XFile _imageFront;
  bool cameraOn=false;

  Future<void> awaitCameras() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'סרוק רישיון',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 243.w,
              child: Text(
                'לצורך הסריקה נשתמש בטכנולוגית SC במידה וניתקלתם בבעיה פנו לנציג החברה',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 34.h),
            Container(
              height: 180.h,
              width: 170.w,
              decoration: BoxDecoration(
                color: Color(0xFFD4E7FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: InkWell(
                  onTap: _onCameraButtonPressed,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_camera_rounded, color: Colors.blueAccent,
                          size: 45.sp),
                      Text(
                        'פתח מצלמה',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: 120.w,
              child: Text(
                'רשיון נהיגה צד קדמי',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 160.h),
            Row(
              children: [
                SizedBox(width: 35.w),
                FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Colors.blueAccent,
                  onPressed: ()=>_cameraController.pausePreview(),
                  tooltip: 'help',
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 180.w),

                FloatingActionButton(
                  heroTag: "btn1",
                  backgroundColor: Colors.blueAccent,
                  onPressed: _onUploadButtonPressed,
                  tooltip: 'Upload',
                  child: const Icon(
                    Icons.file_upload_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onCameraButtonPressed() async {
    print('camera button pressed');
    final cameras = await availableCameras(); // Get a list of available cameras
    final camera = cameras.first; // Use the first camera
    _cameraController = CameraController(camera, ResolutionPreset.high,imageFormatGroup: ImageFormatGroup.yuv420,);
    await _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraOn=true;
      });
    });
    // Show the camera preview on the screen
    print('before showCameraPreview');
    showCameraPreview();
    print('after showCameraPreview');
  }

  void showCameraPreview(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        print('showCameraPreview');
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Center(
                child: Transform.scale(
                  scale: MediaQuery.of(context).size.aspectRatio * _cameraController.value.aspectRatio,
                  child: Transform.rotate(
                      angle: -_cameraController.description.sensorOrientation * pi / 180,
                      child: CameraPreview(_cameraController)),
                ),
              ),
              Center(
                child: Container(
                  height: 250.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow,width: 3)
                  ),
                )
              ),
              Positioned(
                bottom: 0,
                right: 170.w,
                left: 170.w,
                child: ElevatedButton(
                      onPressed: () async{
                        XFile xfile=await _cameraController.takePicture();
                        setState(() {
                          _imageFront= xfile;
                          _cameraController.pausePreview();
                          if (_imageFront != null) {
                            print('_imageFront $_imageFront');
                            //var registration = Registration.of(context);
                            //print('registration: $registration');
                            //print('registration.front: ${registration?.front}');
                            //registration?.front = _imageFront;
                            //print('Registration.of(context)?.front ${Registration.of(context)?.front}');
                            User().regImages[0]=_imageFront;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Success(index: 0)),
                            );
                          }
                        });
                      },
                    child: Icon(Icons.circle_outlined),
                  ),
              ),
              // Container( //show captured image
              //   padding: EdgeInsets.all(30),
              //   child: _imageFront == null?
              //   Text("No image captured"):
              //   Image.file(File(_imageFront!.path), height: 300,),
              //   //display captured image
              // )
            ],
          ),
        );
      },
    );

  }

  // void _getFromCamera() async{
  //   XFile? pickedFile=await ImagePicker().pickImage(source: ImageSource.camera);
  //   _imageFront = File(pickedFile!.path);
  //   Navigator.pop(context);
  // }

  void _onUploadButtonPressed() async {
    if(cameraOn) {
      _cameraController.pausePreview();
      cameraOn=false;
    }
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
    // FilePicker.pickFiles(type: FileType.image,allowMultiple: false,);
    if(result != null) {
      setState(() {
        _imageFront = result;
      });
      User().regImages[0]=_imageFront;
    }
    //else {
    //   // User canceled the file picker
    // }
    showImagePreview;

  }

  // success(){
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Success(index: 0)),
  //   );
  // }

  showImagePreview(){
    print('showImagePreview');
    if(_imageFront!=null) {
      print(_imageFront);
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Success(index: 0,)),
      );
    }
     else {
      const SizedBox(
        height: 210,
        width: 375,
        child: Center(
          child: Positioned.fill(child: Text('No image selected.')),
        ),
      );
    }
  }
}

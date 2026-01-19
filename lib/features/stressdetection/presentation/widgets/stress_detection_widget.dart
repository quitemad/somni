import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../stressdetection/presentation/bloc/stess_bloc.dart';
import '../../../stressdetection/presentation/bloc/stress_event.dart';
import '../../../stressdetection/presentation/bloc/stress_state.dart';

class FacialStressWidget extends StatefulWidget {
  const FacialStressWidget({super.key});

  @override
  State<FacialStressWidget> createState() => _FacialStressWidgetState();
}

class _FacialStressWidgetState extends State<FacialStressWidget> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  String? _validationError;

  late final FaceDetector _faceDetector;

  @override
  void initState() {
    super.initState();

    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true, // eyes open
        enableTracking: false,
        enableContours: false,
        enableLandmarks: false,
      ),
    );
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  // -------------------------------
  // IMAGE PICKING
  // -------------------------------
  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (picked == null) return;
    if (!mounted) return;

    final file = File(picked.path);

    final validation = await _validateFace(file);

    if (validation != null) {
      setState(() {
        _validationError = validation;
        _selectedImage = null;
      });
      return;
    }

    setState(() {
      _validationError = null;
      _selectedImage = file;
    });

    context.read<StressBloc>().add(
      DetectStressFromImage(
        image: file,
        // date: DateTime.now(),
      ),
    );
  }

  // -------------------------------
  // OFFLINE FACE VALIDATION
  // -------------------------------
  Future<String?> _validateFace(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faces = await _faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      return 'No face detected. Please use a clear face image.';
    }

    if (faces.length > 1) {
      return 'Multiple faces detected. Please use a single face.';
    }

    final face = faces.first;

    // Eyes open check
    final leftEyeOpen = face.leftEyeOpenProbability;
    final rightEyeOpen = face.rightEyeOpenProbability;

    if (leftEyeOpen != null &&
        rightEyeOpen != null &&
        (leftEyeOpen < 0.5 || rightEyeOpen < 0.5)) {
      return 'Please keep your eyes open.';
    }

    // Head angle check
    if (face.headEulerAngleY != null &&
        face.headEulerAngleY!.abs() > 20) {
      return 'Please face the camera directly.';
    }

    return null; // VALID
  }

  // -------------------------------
  // UI
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StressBloc, StressState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Facial Stress Detection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (_selectedImage != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      // height: 120,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              if (_validationError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _validationError!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),

              if (state is StressLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: LinearProgressIndicator(),
                ),

              if (state is StressLoaded)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    'Stress Level: ${state.result.stressLevel}',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              if (state is StressError)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo),
                      label: const Text('Gallery'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _submitForAnalysis() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Simulate upload process
      await Future.delayed(Duration(seconds: 2));
      
      // Add your actual upload logic here
      // For example: await uploadImageToServer(_selectedImage!);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image submitted for analysis successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Reset the form
      setState(() {
        _selectedImage = null;
      });
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[900]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A90E2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.upload,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Upload Image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 30),
                
                // Upload Card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFF4A90E2),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: _selectedImage != null
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(13),
                                        child: Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedImage = null;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _pickImage(ImageSource.gallery),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.grey[400]!,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.folder_open,
                                                size: 40,
                                                color: Colors.grey[600],
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Upload Image',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      
                                      SizedBox(height: 30),
                                      
                                      GestureDetector(
                                        onTap: () => _pickImage(ImageSource.camera),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.grey[400]!,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                size: 40,
                                                color: Colors.grey[600],
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Take Photo',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        
                        SizedBox(height: 20),
                        
                        // Submit Button
                        GestureDetector(
                          onTap: _isUploading ? null : _submitForAnalysis,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: _isUploading ? Colors.grey : Colors.black87,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: _isUploading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Uploading...',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Submit For Analysis',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
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

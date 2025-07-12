import 'package:flutter/material.dart';
import 'dart:math';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF4285F4),
        title: Text(
          'Result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background design (Walmart-style spark/burst symbol)
          Positioned(
            top: 60,
            right: 30,
            child: Transform.rotate(
              angle: 0.3,
              child: CustomPaint(
                size: Size(120, 120),
                painter: WalmartSparkPainter(),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 80,
            child: Transform.rotate(
              angle: -0.5,
              child: CustomPaint(
                size: Size(80, 80),
                painter: WalmartSparkPainter(),
              ),
            ),
          ),
          Positioned(
            top: 120,
            right: 10,
            child: Transform.rotate(
              angle: 0.8,
              child: CustomPaint(
                size: Size(60, 60),
                painter: WalmartSparkPainter(),
              ),
            ),
          ),
          
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Result box with dotted border
                Container(
                  width: double.infinity,
                  height: 120,
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: CustomPaint(
                    painter: DottedBorderPainter(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                
                // Data table
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Table header
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF4285F4),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                _buildHeaderCell('Product'),
                                _buildHeaderCell('Count'),
                                _buildHeaderCell('Threshold'),
                                _buildHeaderCell('Status'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Table rows
                      Table(
                        border: TableBorder.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        children: [
                          _buildDataRow('Product 1', '2', '4', Colors.red),
                          _buildDataRow('Product 2', '5', '3', Colors.yellow),
                          _buildDataRow('Product 3', '8', '4', Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Spacer(),
                
                // Buttons
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle download PDF
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2C3E50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Download Pdf',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle refill orders
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2C3E50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Refill Orders',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeaderCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  
  TableRow _buildDataRow(String product, String count, String threshold, Color statusColor) {
    return TableRow(
      children: [
        _buildDataCell(product),
        _buildDataCell(count),
        _buildDataCell(threshold),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildDataCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Custom painter for Walmart spark symbol
class WalmartSparkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFFFC107).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Create 6 pointed star (spark symbol)
    Path path = Path();
    
    for (int i = 0; i < 6; i++) {
      double angle = (i * 60) * (3.14159 / 180);
      double outerRadius = radius;
      double innerRadius = radius * 0.4;
      
      // Outer point
      double outerX = center.dx + outerRadius * cos(angle);
      double outerY = center.dy + outerRadius * sin(angle);
      
      // Inner point (between outer points)
      double innerAngle = ((i * 60) + 30) * (3.14159 / 180);
      double innerX = center.dx + innerRadius * cos(innerAngle);
      double innerY = center.dy + innerRadius * sin(innerAngle);
      
      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      
      path.lineTo(innerX, innerY);
    }
    
    path.close();
    canvas.drawPath(path, paint);
    
    // Add a subtle shadow/glow effect
    final shadowPaint = Paint()
      ..color = Color(0xFFFFC107).withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);
    
    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter for dotted border
class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 8;
    const double dashSpace = 4;
    
    // Top border
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
    
    // Right border
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
    
    // Bottom border
    startX = size.width;
    while (startX > 0) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX - dashWidth, size.height),
        paint,
      );
      startX -= dashWidth + dashSpace;
    }
    
    // Left border
    startY = size.height;
    while (startY > 0) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY - dashWidth),
        paint,
      );
      startY -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  runApp(MaterialApp(
    home: ResultScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
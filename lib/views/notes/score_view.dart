import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ScoreView extends StatefulWidget {
  final double bmiValue;
  const ScoreView({
    super.key,
    required this.bmiValue,
  });

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 12,
          maximum: 45,
          showAxisLine: false,
          showTicks: false,
          showFirstLabel: false,
          showLabels: false,
          labelOffset: 60,
          canRotateLabels: true,
          startAngle: 180,
          endAngle: 0,
          ranges: <GaugeRange>[
            //! ranges
            GaugeRange(
              startValue: 12,
              endValue: 16,
              color: Colors.red.shade600,
              startWidth: 50,
              endWidth: 50,
            ),

            GaugeRange(
              startValue: 16,
              endValue: 17,
              color: Colors.red.withOpacity(0.3),
              startWidth: 50,
              endWidth: 50,
            ),

            GaugeRange(
              startValue: 17,
              endValue: 18.5,
              color: Colors.yellow,
              startWidth: 50,
              endWidth: 50,
            ),
            GaugeRange(
              startValue: 18.5,
              endValue: 25,
              color: Colors.green,
              startWidth: 50,
              endWidth: 50,
            ),
            GaugeRange(
              startValue: 25,
              endValue: 30,
              color: Colors.yellow,
              startWidth: 50,
              endWidth: 50,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 35,
              color: Colors.red.withOpacity(0.4),
              startWidth: 50,
              endWidth: 50,
            ),
            GaugeRange(
              startValue: 35,
              endValue: 40,
              color: Colors.red.shade600,
              startWidth: 50,
              endWidth: 50,
            ),
            GaugeRange(
              startValue: 40,
              endValue: 45,
              color: Colors.red.shade900,
              startWidth: 50,
              endWidth: 50,
            ),
            //! Labels
            GaugeRange(
              rangeOffset: -5,
              startValue: 15.7,
              endValue: 16,
              color: Colors.transparent,
              startWidth: 50,
              endWidth: 50,
              label: '16',
              labelStyle: const GaugeTextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            GaugeRange(
              rangeOffset: -5,
              startValue: 17,
              endValue: 17.2,
              color: Colors.transparent,
              startWidth: 50,
              endWidth: 50,
              label: '17',
              labelStyle: const GaugeTextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            GaugeRange(
              rangeOffset: -5,
              startValue: 25,
              endValue: 25,
              color: Colors.transparent,
              startWidth: 50,
              endWidth: 50,
              label: '25',
              labelStyle: const GaugeTextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            GaugeRange(
              rangeOffset: -5,
              startValue: 30,
              endValue: 30,
              color: Colors.transparent,
              startWidth: 50,
              endWidth: 50,
              label: '30',
              labelStyle: const GaugeTextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            GaugeRange(
              rangeOffset: -5,
              startValue: 35,
              endValue: 35,
              color: Colors.transparent,
              startWidth: 50,
              endWidth: 50,
              label: '35',
              labelStyle: const GaugeTextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            GaugeRange(
              rangeOffset: -5,
              startValue: 40,
              endValue: 40,
              color: Colors.transparent,
              startWidth: 50,
              endWidth: 50,
              label: '40',
              labelStyle: const GaugeTextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: widget.bmiValue,
              knobStyle: const KnobStyle(knobRadius: 0.04, color: Colors.grey),
              needleStartWidth: 2,
              needleEndWidth: 2,
              needleColor: Colors.grey,
            ),
            MarkerPointer(
              value: widget.bmiValue,
              markerOffset: 60,
              markerWidth: 20,
              markerHeight: 20,
              markerType: MarkerType.triangle,
            ),
          ],
          annotations: <GaugeAnnotation>[
            const GaugeAnnotation(
              verticalAlignment: GaugeAlignment.center,
              widget: ArcText(
                radius: 170,
                text: '        Underweight',
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                startAngle: -pi / 1.8,
                startAngleAlignment: StartAngleAlignment.start,
                placement: Placement.outside,
                direction: Direction.clockwise,
              ),
              angle: 90,
              positionFactor: 0.01,
            ),
            const GaugeAnnotation(
              verticalAlignment: GaugeAlignment.near,
              widget: ArcText(
                radius: 170,
                text: '                    Normal',
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                startAngle: -pi / 2.5,
                startAngleAlignment: StartAngleAlignment.start,
                placement: Placement.outside,
                direction: Direction.clockwise,
              ),
              angle: 90,
              positionFactor: 0.01,
            ),
            const GaugeAnnotation(
              verticalAlignment: GaugeAlignment.near,
              widget: ArcText(
                radius: 170,
                text: '                                        Overweight',
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                startAngle: -pi / 2.5,
                startAngleAlignment: StartAngleAlignment.start,
                placement: Placement.outside,
                direction: Direction.clockwise,
              ),
              angle: 90,
              positionFactor: 0.01,
            ),
            const GaugeAnnotation(
              verticalAlignment: GaugeAlignment.near,
              widget: ArcText(
                radius: 170,
                text:
                    '                                                                                   Obesity',
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                startAngle: -pi / 2.5,
                startAngleAlignment: StartAngleAlignment.start,
                placement: Placement.outside,
                direction: Direction.clockwise,
              ),
              angle: 90,
              positionFactor: 0.01,
            ),
            GaugeAnnotation(
              verticalAlignment: GaugeAlignment.far,
              widget: Text(
                'BMI = ${widget.bmiValue.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              angle: 90,
              positionFactor: 0,
            ),
          ],
        )
      ],
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget barGraphBabySitter({required Color colorBar}) => Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.grey[600]),
              ],
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 30, //
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 5, //
                        getTitlesWidget: (double value, TitleMeta meta) => Text(
                          value.toInt().toString(), //
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('2021');
                            case 1:
                              return const Text('2022');
                            case 2:
                              return const Text('2023');
                            case 3:
                              return const Text('2024');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: <BarChartGroupData>[
                    BarChartGroupData(
                      x: 0,
                      barRods: <BarChartRodData>[
                        BarChartRodData(toY: 5, color: colorBar)
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: <BarChartRodData>[
                        BarChartRodData(toY: 25, color: colorBar)
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: <BarChartRodData>[
                        BarChartRodData(toY: 14, color: colorBar)
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: <BarChartRodData>[
                        BarChartRodData(toY: 10, color: colorBar)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

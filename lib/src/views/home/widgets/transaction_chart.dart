import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TransactionChart extends HookWidget {
  const TransactionChart({
    super.key,
    required this.colorBar,
  });

  final Color colorBar;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> showTransactions = useState(true);

    const List<FlSpot> transactionSpots = <FlSpot>[
      FlSpot(0, 5),
      FlSpot(1, 25),
      FlSpot(2, 14),
      FlSpot(3, 10),
    ];

    const List<FlSpot> babysittingSpots = <FlSpot>[
      FlSpot(0, 3),
      FlSpot(1, 15),
      FlSpot(2, 8),
      FlSpot(3, 12),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    showTransactions.value
                        ? 'Transactions'
                        : 'Babysitting History',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      showTransactions.value
                          ? FluentIcons.money_24_regular
                          : FluentIcons.person_24_regular,
                      color: colorBar,
                      size: 24,
                    ),
                    onPressed: () {
                      showTransactions.value = !showTransactions.value;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 1.7,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 5,
                      getDrawingHorizontalLine: (double value) => FlLine(
                        color: Colors.grey.shade200,
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          interval: 5,
                          getTitlesWidget: (double value, TitleMeta meta) =>
                              Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 32,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const TextStyle style = TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            );
                            String text;
                            switch (value.toInt()) {
                              case 0:
                                text = '2022';
                                break;
                              case 1:
                                text = '2023';
                                break;
                              case 2:
                                text = '2024';
                                break;
                              case 3:
                                text = '2025';
                                break;
                              default:
                                text = '';
                            }
                            return Text(text, style: style);
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 3,
                    minY: 0,
                    maxY: 30,
                    lineBarsData: <LineChartBarData>[
                      LineChartBarData(
                        spots: showTransactions.value
                            ? transactionSpots
                            : babysittingSpots,
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: <Color>[
                            colorBar.withOpacity(0.7),
                            colorBar,
                          ],
                        ),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (FlSpot spot, double percent,
                                  LineChartBarData barData, int index) =>
                              FlDotCirclePainter(
                            radius: 4,
                            color: colorBar,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: <Color>[
                              colorBar.withOpacity(0.2),
                              colorBar.withOpacity(0.0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((LineBarSpot barSpot) {
                            return LineTooltipItem(
                              showTransactions.value
                                  ? '${barSpot.y.toInt()} transactions'
                                  : '${barSpot.y.toInt()} babysitting jobs',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/models.dart';

class TransactionChart extends HookConsumerWidget {
  const TransactionChart({
    super.key,
    required this.colorBar,
  });

  final Color colorBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> showTransactions = useState(true);
    final UserAccount? currentUser = ref.watch(authControllerService).user;

    return StreamBuilder<List<Booking>>(
      stream: ref
          .watch(bookingControllerService.notifier)
          .getBookingsStream(currentUser!),
      builder: (BuildContext context, AsyncSnapshot<List<Booking>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<Booking> bookings = snapshot.data ?? <Booking>[];

        // Calculate yearly statistics
        List<FlSpot> getYearlySpots(bool isTransactions) {
          final Map<int, int> yearlyStats = <int, int>{};
          final int currentYear = DateTime.now().year;

          // Initialize years
          for (int year = currentYear - 2; year <= currentYear + 1; year++) {
            yearlyStats[year] = 0;
          }

          // Count bookings per year
          for (final Booking booking in bookings) {
            final int year = booking.workingDate.year;
            if (yearlyStats.containsKey(year)) {
              if (isTransactions) {
                if (booking.status == 'completed' &&
                    booking.paymentStatus == 'completed') {
                  yearlyStats[year] = yearlyStats[year]! + 1;
                }
              } else {
                yearlyStats[year] = yearlyStats[year]! + 1;
              }
            }
          }

          // Convert to FlSpots
          return yearlyStats.entries.map((MapEntry<int, int> entry) {
            final int index = entry.key - (currentYear - 2);
            return FlSpot(index.toDouble(), entry.value.toDouble());
          }).toList();
        }

        final List<FlSpot> transactionSpots = getYearlySpots(true);
        final List<FlSpot> babysittingSpots = getYearlySpots(false);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                                final int currentYear = DateTime.now().year;
                                final int year =
                                    currentYear - 2 + value.toInt();
                                return Text(
                                  year.toString(),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
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
                            getTooltipItems:
                                (List<LineBarSpot> touchedBarSpots) {
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

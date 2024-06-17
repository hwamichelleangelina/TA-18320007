/*
Widget _buildSessionsPerMonthChart(Future<List<SessionPerMonth>> sessionsPerMonth) {
  int year = selectedYear;
  return FutureBuilder<List<SessionPerMonth>>(
    future: sessionsPerMonth,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available'));
      } else {
        List<charts.Series<SessionPerMonth, DateTime>> seriesList = [
          charts.Series<SessionPerMonth, DateTime>(
            id: 'SessionsPerMonth',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (SessionPerMonth spm, _) {
              DateTime date = _monthToDateTime(spm.month);
              print('Month: ${spm.month}, DateTime: $date'); // Debugging
              return date;
            },
            measureFn: (SessionPerMonth spm, _) => spm.count,
            data: snapshot.data!,
            labelAccessorFn: (SessionPerMonth spm, _) => '${spm.count}',
          ),
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 300,
            child: charts.TimeSeriesChart(
              seriesList,
              animate: true,
              primaryMeasureAxis: const charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontFamily: 'Montserrat',
                    color: charts.MaterialPalette.white,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.white, // Gridline color
                  ),
                ),
              ),
              domainAxis: charts.DateTimeAxisSpec(
                tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
                  [
                    charts.TickSpec(DateTime(year, 1), label: 'Jan'),
                    charts.TickSpec(DateTime(year, 2), label: 'Feb'),
                    charts.TickSpec(DateTime(year, 3), label: 'Mar'),
                    charts.TickSpec(DateTime(year, 4), label: 'Apr'),
                    charts.TickSpec(DateTime(year, 5), label: 'May'),
                    charts.TickSpec(DateTime(year, 6), label: 'Jun'),
                    charts.TickSpec(DateTime(year, 7), label: 'Jul'),
                    charts.TickSpec(DateTime(year, 8), label: 'Aug'),
                    charts.TickSpec(DateTime(year, 9), label: 'Sep'),
                    charts.TickSpec(DateTime(year, 10), label: 'Oct'),
                    charts.TickSpec(DateTime(year, 11), label: 'Nov'),
                    charts.TickSpec(DateTime(year, 12), label: 'Dec'),
                  ],
                ),
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    color: charts.MaterialPalette.white,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.white, // Gridline color
                  ),
                ),
              ),
              behaviors: [
                charts.SeriesLegend(
                  position: charts.BehaviorPosition.bottom,
                  horizontalFirst: true,
                  showMeasures: false,
                  legendDefaultMeasure: charts.LegendDefaultMeasure.none,
                  entryTextStyle: const charts.TextStyleSpec(
                    color: charts.MaterialPalette.white,
                    fontSize: 10,
                  ),
                  desiredMaxColumns: 2,
                ),
                charts.ChartTitle(
                  'Sessions Per Month',
                  behaviorPosition: charts.BehaviorPosition.top,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(
                    color: charts.MaterialPalette.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}

DateTime _monthToDateTime(String month) {
  try {
    return DateTime.parse('$month-01'); // Parse YYYY-MM to DateTime
  } catch (e) {
    throw ArgumentError('Invalid month format: $month');
  }
}
*/
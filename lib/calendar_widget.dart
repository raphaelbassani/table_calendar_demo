import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2021, 4, 2): ['Sexta-Feira Santa'],
  DateTime(2021, 4, 4): ['Páscoa'],
};

enum calendarShown { simples, custom, builder }

class CalendarWidget extends StatefulWidget {
  final calendarShown calendarOption;

  const CalendarWidget({Key key, @required this.calendarOption})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 2)): [
        'Aula de Compiladores',
      ],
      _selectedDay.subtract(Duration(days: 1)): [
        'Aula de IA2',
        'Aula de IHC',
      ],
      _selectedDay: ['Aula de SD', 'Aula de Compiladores', 'Aula DADM'],
      _selectedDay.add(Duration(days: 1)): [
        'Aula de SR',
        'Aula de IA2',
      ]
    };
    _events.addAll(_holidays);

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    String date = day.day.toString() +
        "/" +
        day.month.toString() +
        "/" +
        day.year.toString();
    print('Dia Selecionado $date');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onDaySelectedCustom(DateTime dateTime, List events, List holidays) {
    String date = dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString();
    print('Dia Selecionado $date');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onDayLongPress(DateTime dateTime, List events, List holidays) {
    String date = dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString();
    final snackBar = SnackBar(
      content: Text('Clique Longo $date'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    final snackBar = SnackBar(
      content: Text('Trocar os dias visiveis'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('Calendario Criado');
  }

  void _onHeaderTapped(DateTime first) {
    final snackBar = SnackBar(
      content: Text('Click no Header'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onHeaderLongTapped(DateTime first) {
    final snackBar = SnackBar(
      content: Text('Click longo no Header'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          widget.calendarOption == calendarShown.simples
              ? _buildTableCalendar()
              : Container(),
          widget.calendarOption == calendarShown.custom
              ? _buildTableCalendarCustom()
              : Container(),
          widget.calendarOption == calendarShown.builder
              ? _buildTableCalendarWithBuilders()
              : Container(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      availableCalendarFormats: const {
        CalendarFormat.month: 'Semana',
        CalendarFormat.week: 'Mes',
      },
      initialCalendarFormat: CalendarFormat.week,
      weekendDays: [DateTime.monday, DateTime.saturday, DateTime.sunday],
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.red,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onHeaderTapped: _onHeaderTapped,
      onDayLongPressed: _onDayLongPress,
      onHeaderLongPressed: _onHeaderLongTapped,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildTableCalendarCustom() {
    return TableCalendar(
      //Começo do calendario
      startDay: DateTime(2021, 1, 1),
      //Fim do calendario
      endDay: DateTime(2021, 12, 31),
      //Lingua do Calendario
      locale: "pt_BR",
      //Estilo do calendario
      calendarStyle: CalendarStyle(
        //Decoração do calendario
        /*contentDecoration: BoxDecoration(
          color: Colors.transparent,
        ),*/
        //Alinhamento do calendario
        contentPadding: EdgeInsets.zero,
        //Margin interna dos dias
        //cellMargin: EdgeInsets.all(18),

        //Estilos textuais
        //Mes selecionado
        //Hoje
        todayStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        //Selecionado
        selectedStyle: TextStyle(
            color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
        //Fins de Semana
        weekendStyle: TextStyle(color: Colors.green),
        //Semana
        weekdayStyle: TextStyle(color: Colors.black),
        //Feriado
        holidayStyle: TextStyle(color: Colors.yellow),
        //Dia com Evento
        eventDayStyle: TextStyle(color: Colors.blue),
        //Dia indisponivel
        unavailableStyle: TextStyle(color: Colors.cyan),
        //Fora do mês selecionado
        outsideDaysVisible: true,
        //Semana
        outsideStyle: TextStyle(color: Colors.black38),
        //Feriado
        outsideHolidayStyle: TextStyle(color: Colors.yellow),
        //Fins de semana
        outsideWeekendStyle: TextStyle(color: Colors.black12),

        //Marcadores
        //Podem Estourar
        canEventMarkersOverflow: true,
        //Cor marcador
        markersColor: Colors.red,
        //Alinhamento
        markersAlignment: Alignment.center,
        //Maximo de marcadores TODO
        //markersMaxAmount: 1,
        /*markersPositionBottom: 10,
        markersPositionLeft: 20,*/

        //Selecionados
        //Cor de dia Selecionado
        selectedColor: Colors.green,
        //Cor de hoje não selecionado
        todayColor: Colors.green.withOpacity(.4),

        //Nomes de dias da semana
        renderDaysOfWeek: false,
        //Destaques
        //Hoje
        highlightToday: true,
        //Selecionado
        highlightSelected: true,
      ),
      //Feriados
      holidays: _holidays,
      //Quando selecionar um dia
      onDaySelected: _onDaySelectedCustom,
      //Clique longo no dia
      onDayLongPressed: _onDayLongPress,
      //Controlador do Calendario
      calendarController: _calendarController,
      //Eventos
      events: _events,
      //Estilo do header
      headerStyle: HeaderStyle(
        //Lado esquerdo do header
        leftChevronIcon:
            Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
        //lado direito do header
        rightChevronIcon:
            Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black),
        //Estilo do titulo do calendario
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.black,
        ),
        //Mudar o formato do calendario
        formatButtonVisible: false,
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pt_BR',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        outsideWeekendStyle:
            TextStyle().copyWith(color: Colors.blue[800].withOpacity(.3)),
        outsideStyle: TextStyle().copyWith(color: Colors.black.withOpacity(.2)),
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                    fontSize: _calendarController.isSelected(date) ? 20 : 16),
              ),
            ),
          );
        },
        outsideHolidayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blue[100].withOpacity(.2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(
                  fontSize: _calendarController.isSelected(date) ? 21 : 16),
            ),
          );
        },
        dowWeekdayBuilder: (context, weekday) {
          return Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  weekday,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
        dowWeekendBuilder: (context, weekday) {
          return Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  weekday,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(
                  fontSize: _calendarController.isSelected(date) ? 21 : 16),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.grey
            : _calendarController.isToday(date)
                ? Colors.grey[400]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('Clique no evento: $event'),
                ),
              ))
          .toList(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudokudart/src/model/puzzle.dart';
import 'package:sudokudart/src/widgets/display.dart';
import 'package:sudokudart/src/widgets/input.dart';

void main() {
  runApp(SuduokuSolver());
}

class SuduokuSolver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku Solver',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.lightBlueAccent,
      ),
      home: MainPage(title: 'Sudoku Solver'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SudokuPuzzle puzzle = new SudokuPuzzle();

  FocusNode _focusNode = new FocusNode();

  void _fieldClicked(int index) {
    setState(() {
      puzzle.selectField(index);
    });
  }

  void _keyPressed(RawKeyEvent rawKeyEvent) {
    setState(() {
      // key events are very raw
      if (rawKeyEvent is RawKeyDownEvent) {
        if ("ArrowRight" == rawKeyEvent.character) {
          puzzle.moveSelectionRight();
        } else if ("ArrowLeft" == rawKeyEvent.character) {
          puzzle.moveSelectionLeft();
        } else if ("ArrowUp" == rawKeyEvent.character) {
          puzzle.moveSelectionUp();
        } else if ("ArrowDown" == rawKeyEvent.character) {
          puzzle.moveSelectionDown();
        } else if ("x" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 0;
        } else if ("0" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 0;
        } else if ("1" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 1;
        } else if ("2" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 2;
        } else if ("3" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 3;
        } else if ("4" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 4;
        } else if ("5" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 5;
        } else if ("6" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 6;
        } else if ("7" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 7;
        } else if ("8" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 8;
        } else if ("9" == rawKeyEvent.character) {
          puzzle.getSelectedField().value = 9;
        }
        puzzle.checkPuzzle();
      }
    });
  }

  void _buttonClicked(String value) {
    setState(() {
      if (value == "X") {
        puzzle.resetSelectedField();
      } else {
        puzzle.setSelectedValue(int.parse(value));
      }
      puzzle.checkPuzzle();
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RawKeyboardListener(
            focusNode: _focusNode,
            onKey: _keyPressed,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10.0)),
                // todo maybe grid view would be better
                // todo 3*3 in 3*3
                Table(
                    children: List<RowDisplay>.generate(
                        9, (rowNum) => new RowDisplay(
                        sudokuPuzzle: puzzle,
                        startingIndex: puzzle.getRowStartingIndex(rowNum),
                        numberOfFields: 9,
                        onClicked: _fieldClicked))),
                Spacer(),
                Table(
                  children: [
                    TableRow(
                      children: [
                        TypeValueButton(value: "1", onClicked: _buttonClicked),
                        TypeValueButton(value: "2", onClicked: _buttonClicked),
                        TypeValueButton(value: "3", onClicked: _buttonClicked),
                        TypeValueButton(value: "4", onClicked: _buttonClicked),
                        TypeValueButton(value: "5", onClicked: _buttonClicked),
                      ],
                    ),
                    TableRow(
                      children: [
                        TypeValueButton(value: "6", onClicked: _buttonClicked),
                        TypeValueButton(value: "7", onClicked: _buttonClicked),
                        TypeValueButton(value: "8", onClicked: _buttonClicked),
                        TypeValueButton(value: "9", onClicked: _buttonClicked),
                        TypeValueButton(value: "X", onClicked: _buttonClicked),
                      ],
                    ),
                  ],),
                Padding(padding: EdgeInsets.only(bottom: 10.0)),
              ],
            )),
      ),
    );
  }
}

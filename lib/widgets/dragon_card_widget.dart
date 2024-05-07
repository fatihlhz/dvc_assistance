import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dvc_assistance/providers/dragon_card_provider.dart';
import 'package:dvc_assistance/models/dragon_card_model.dart';
import 'package:dvc_assistance/widgets/statpoint_widget.dart';

class DragonCardWidget extends StatefulWidget {
  final int index;
  final DragonCardModel data;

  const DragonCardWidget({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  _DragonCardWidgetState createState() => _DragonCardWidgetState();
}

class _DragonCardWidgetState extends State<DragonCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;
  int statPoint = 9;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightFactor = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DragonCardProvider>(context, listen: false)
          .calculateReqStat(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    DragonCardProvider provider = Provider.of<DragonCardProvider>(context);
    var dragon = widget.data.dragonData;
    var stat = widget.data.requiredStat;
    double rowWidth = 105;
    double colgap = 7;

    final reqStatColor = widget.data.targetPersonality.fixed == true
        ? Colors.blue.shade600
        : Colors.red;

    final finStatColor = Colors.green.shade700;

    //provider.calculateReqStat(widget.data);

    return Container(
        padding: const EdgeInsets.all(5),
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: provider.selectedCardIndex == widget.index
                      ? Theme.of(context).primaryColor
                      : Colors.black45,
                  width:
                      provider.selectedCardIndex == widget.index ? 1.5 : 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Theme.of(context).canvasColor,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            // elevation: _isExpanded ? 8.0 : 2.0,
            child: GestureDetector(
                onTap: () {
                  provider.selectCard(widget.index);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: Column(children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(dragon.name),
                          subtitle: Text(widget.data.targetPersonality.name),
                          trailing: GestureDetector(
                            onTap: _toggleExpansion,
                            child: RotationTransition(
                              turns:
                                  Tween<double>(begin: 0.0, end: 0.5).animate(
                                CurvedAnimation(
                                  parent: _controller,
                                  curve: Curves.easeInOut,
                                ),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black54, // Customize icon color
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: rowWidth,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("AGI: ${dragon.agility}"),
                                        SizedBox(height: colgap),
                                        Text("FOC: ${dragon.focus}")
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("-${stat.reqAgi}",
                                            style: stat.reqAgi > 0
                                                ? TextStyle(color: reqStatColor)
                                                : TextStyle(
                                                    color: finStatColor)),
                                        SizedBox(height: colgap),
                                        Text("-${stat.reqFoc}",
                                            style: stat.reqFoc > 0
                                                ? TextStyle(color: reqStatColor)
                                                : TextStyle(
                                                    color: finStatColor))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: rowWidth,
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("STR: ${dragon.strength}"),
                                        SizedBox(height: colgap),
                                        Text("INT: ${dragon.intellect}")
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("-${stat.reqStr}",
                                            style: stat.reqStr > 0
                                                ? TextStyle(color: reqStatColor)
                                                : TextStyle(
                                                    color: finStatColor)),
                                        SizedBox(height: colgap),
                                        Text("-${stat.reqInt}",
                                            style: stat.reqInt > 0
                                                ? TextStyle(color: reqStatColor)
                                                : TextStyle(
                                                    color: finStatColor))
                                      ],
                                    )
                                  ])),
                              SizedBox(
                                  width: rowWidth,
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("VIEW : ${dragon.views}"),
                                        SizedBox(height: colgap),
                                        Text("VISIT: ${dragon.visit}")
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("-${stat.reqViews}",
                                            style: stat.reqViews > 0
                                                ? TextStyle(color: reqStatColor)
                                                : TextStyle(
                                                    color: finStatColor)),
                                        SizedBox(height: colgap),
                                        Text("-${stat.reqVisit}",
                                            style: stat.reqVisit > 0
                                                ? TextStyle(color: reqStatColor)
                                                : TextStyle(
                                                    color: finStatColor))
                                      ],
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    AnimatedBuilder(
                      animation: _heightFactor,
                      builder: (context, child) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          constraints: BoxConstraints(
                            maxHeight: _isExpanded ? 300 : 0.0,
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                children: [
                                  const Divider(),
                                  const SizedBox(height: 15),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        StatPointWidget(callback: (int param) {
                                          statPoint = param;
                                        }),
                                        const SizedBox(width: 12),
                                        OutlinedButton(
                                            onPressed: widget.data.history
                                                        ?.isNotEmpty ==
                                                    true
                                                ? () {
                                                    provider
                                                        .undoStep(widget.index);
                                                  }
                                                : null,
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(25, 37),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 9, 10, 9),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                            ),
                                            child: const Icon(
                                              Icons.undo,
                                              size: 18,
                                            )),
                                      ]),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(50, 37),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            onPressed: () {
                                              provider.addAgi(
                                                  widget.index, statPoint);
                                            },
                                            child: const Text("+ AGI"),
                                          ),
                                          const SizedBox(height: 7),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(50, 37),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            onPressed: () {
                                              provider.addFoc(
                                                  widget.index, statPoint);
                                            },
                                            child: const Text("+ FOC"),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(50, 37),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            onPressed: () {
                                              provider.addStr(
                                                  widget.index, statPoint);
                                            },
                                            child: const Text("+ STR"),
                                          ),
                                          const SizedBox(height: 7),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(50, 37),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            onPressed: () {
                                              provider.addInt(
                                                  widget.index, statPoint);
                                            },
                                            child: const Text("+ INT"),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(50, 37),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 8, 20, 8),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            onPressed: () {
                                              provider.addViews(
                                                  widget.index, statPoint);
                                            },
                                            child: const Text("+ VIEWS"),
                                          ),
                                          const SizedBox(height: 7),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(50, 37),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 8, 20, 8),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            onPressed: () {
                                              provider.addVisit(
                                                  widget.index, statPoint);
                                            },
                                            child: const Text("+ VISIT"),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ))));
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

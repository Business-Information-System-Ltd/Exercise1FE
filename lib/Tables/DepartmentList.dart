import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class DepartmentListPage extends StatefulWidget {
  const DepartmentListPage({super.key});

  @override
  State<DepartmentListPage> createState() => _DepartmentListPageState();
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  late final PlutoGridStateManager stateManager;
  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();

    columns.addAll([
      PlutoColumn(
        title: 'Dept Code',
        field: 'dept_code',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Dept Name',
        field: 'dept_name',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          bool isActive = rendererContext.cell.value == 'Active';
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: isActive ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 8, color: isActive ? Colors.green : Colors.orange),
                const SizedBox(width: 6),
                Text(
                  rendererContext.cell.value,
                  style: TextStyle(
                    color: isActive ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 18),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade100),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    ]);

    rows.addAll([
      PlutoRow(cells: {
        'dept_code': PlutoCell(value: 'D-001'),
        'dept_name': PlutoCell(value: 'Admin'),
        'status': PlutoCell(value: 'Active'),
        'action': PlutoCell(value: ''),
      }),
      PlutoRow(cells: {
        'dept_code': PlutoCell(value: 'D-002'),
        'dept_name': PlutoCell(value: 'IT'),
        'status': PlutoCell(value: 'Inactive'),
        'action': PlutoCell(value: ''),
      }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // နောက်ခံအဖြူစပ်စပ်လေး
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Search Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Department List",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // --- Search Bar ပြင်ဆင်ထားသောအပိုင်း ---
                    SizedBox(
                      height: 45,
                      child: TextField(
                        onChanged: (value) {
                          stateManager.setFilter((element) => true); // filter အဟောင်းဖျက်
                          stateManager.setFilter((element) {
                            return element.cells['dept_name']!.value
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                element.cells['dept_code']!.value
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search...",
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Grid Section
              Expanded(
                child: PlutoGrid(
                  columns: columns,
                  rows: rows,
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    stateManager.setColumnSizeConfig(
                      const PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.equal),
                    );
                  },
                  configuration: const PlutoGridConfiguration(
                    style: PlutoGridStyleConfig(
                      gridBorderColor: Colors.transparent, // အတွင်း border ကို ဖျောက်ထားတာ ပိုလှလို့ပါ
                      columnTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 14, 
                        color: Color(0xFF2D3E50),
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
  }
}
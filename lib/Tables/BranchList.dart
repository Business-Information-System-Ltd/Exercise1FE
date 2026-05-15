import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class BranchListPage extends StatefulWidget {
  const BranchListPage({super.key});

  @override
  State<BranchListPage> createState() => _BranchListPageState();
}

class _BranchListPageState extends State<BranchListPage> {
  late final PlutoGridStateManager stateManager;
  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();

    columns.addAll([
      PlutoColumn(
        title: 'Branch Code',
        field: 'branch_code',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Branch Name',
        field: 'branch_name',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Location',
        field: 'location',
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
              _buildActionButton(Icons.edit_outlined, Colors.blue, () {}),
              const SizedBox(width: 8),
              _buildActionButton(Icons.delete_outline, Colors.red, () {}),
            ],
          );
        },
      ),
    ]);

    // Backend ကနေ data မလာခင် ပြနေမယ့် နမူနာ data
    rows.addAll([
      PlutoRow(cells: {
        'branch_code': PlutoCell(value: 'B-001'),
        'branch_name': PlutoCell(value: 'Branch 1'),
        'location': PlutoCell(value: 'Alone'),
        'status': PlutoCell(value: 'Active'),
        'action': PlutoCell(value: ''),
      }),
      PlutoRow(cells: {
        'branch_code': PlutoCell(value: 'B-002'),
        'branch_name': PlutoCell(value: 'Branch 2'),
        'location': PlutoCell(value: 'Hardan'),
        'status': PlutoCell(value: 'Inactive'),
        'action': PlutoCell(value: ''),
      }),
    ]);
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 18),
        onPressed: onPressed,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Branch List",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // --- Search Bar ---
                    SizedBox(
                      height: 45,
                      child: TextField(
                        onChanged: (value) {
                          stateManager.setFilter((element) => true);
                          stateManager.setFilter((element) {
                            final nameMatch = element.cells['branch_name']!.value.toString().toLowerCase().contains(value.toLowerCase());
                            final codeMatch = element.cells['branch_code']!.value.toString().toLowerCase().contains(value.toLowerCase());
                            final locationMatch = element.cells['location']!.value.toString().toLowerCase().contains(value.toLowerCase());
                            return nameMatch || codeMatch || locationMatch;
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
                  onLoaded: (event) {
                    stateManager = event.stateManager;
                    stateManager.setColumnSizeConfig(
                      const PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.equal),
                    );
                  },
                  configuration: const PlutoGridConfiguration(
                    style: PlutoGridStyleConfig(
                      gridBorderColor: Colors.transparent,
                      columnTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF4A5568),
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
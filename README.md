# FanucProgramAnalyze

At it's core it is a simple program parsing information from fanuc robot program files to adequate class objects using REGEX and custom functions.

In console enter valid path to directory with fanuc programs .ls and program will create report.csv file within same folder as this program.

Program structure is prepared to handle following fanuc objects:
1. Program name
2. Called subprograms
3. I/Os: DI, DO, AI, AO, GI, GO, RI, RO, F, UOP, SOP - as CSignal
4. Register R - as CRegister
5. Points P - as CPointJoint or CPointCartesian
6. Position registers PR - as CPositionRegister

Output report is a .CSV file with ';' as delimiter with information structure as table for each program containing program name and objects(type, index and comment) used in the program.

### Notes

Application that read CSV file, may change some cell type to wrong format (like time) and show weird values. This happens when cell object have index and empty comment, example "3:".

### TODO

1. Additional report with called subprograms
2. Read posreg file and parse position register points to CPositionRegister container (should be one and only in CProgramManager because PRs are shared among robot's programs)
3. Additional report with Position Registers points
4. Additional report with Register values

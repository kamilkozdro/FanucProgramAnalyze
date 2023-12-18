#include <iostream>
#include <fstream>
#include <filesystem>
#include <regex>
#include <string>

#include "CProgramsManager.h"

int main()
{
	CProgramsManager programsManager;
	programsManager.addProgramsFromFolder("fanucPrograms/");

	programsManager.exportToCSV(programsManager.getPrograms());

	return 1;

}
#include <iostream>
#include <fstream>
#include <filesystem>
#include <regex>
#include <string>

#include "CProgramsManager.h"
#include "CFileManager.h"

int main()
{
	std::string directory("fanucPrograms/");

	CFileManager fileManager;
	fileManager.findFiles(directory);

	if (fileManager.countProgramFilePaths() <= 0)
	{
		return 0;
	}
	
	CProgramsManager programsManager;
	
	for (int i = 0; i < fileManager.countProgramFilePaths(); i++)
	{
		std::cout << "Parsing " << fileManager.getProgramFilePath(i) << std::endl;
		programsManager.addParseProgram(fileManager.readFileContent(i));
	}

	fileManager.saveToFile("report.csv", programsManager.createAllProgramReport());

	return 1;

}
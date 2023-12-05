#pragma once

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <regex>

#include "CProgram.h"

class CProgramsManager
{
public:
	CProgramsManager();
	~CProgramsManager();

	
	bool addProgramFromFile(std::string fileName);
	void printProgramNameList();
	CProgram* getProgramByName(std::string programName);
	int getProgramIndexByName(std::string programName);
	void programToCSV(CProgram* program);

	std::vector<CProgram*> getPrograms() { return programs; };

	void saveToFile(std::string filePath, std::string text);

	void exportToCSV(CProgram* program);
	void exportToCSV(std::vector<CProgram*> programs);

private:
	std::vector<CProgram*> programs;
	std::string readFileContent(std::string fileName);
	void addProgram(std::string newProgramText, std::string newProgramName);
	bool hasProgramName(std::string programName);
	std::string readProgramName(std::string& buffer);
	std::string createProgramReport(std::vector<CProgram*> programs);
	std::string createProgramReport(CProgram* program);

protected:

};


#pragma once

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

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

private:
	std::vector<CProgram*> programs;
	std::string readFileContent(std::string fileName);
	bool addProgram(std::string newProgramText, std::string newProgramName);
	bool hasProgramName(std::string programName);
	std::string readProgramName(std::string& buffer);
	

protected:

};


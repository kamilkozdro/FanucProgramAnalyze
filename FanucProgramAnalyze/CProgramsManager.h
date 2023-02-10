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

	void readFile(std::string fileName);

	void printProgramNameList();

private:

	std::ifstream streamRead;
	std::vector<CProgram*> programs;

	std::string readProgramNameFromFile();
	bool addProgram(std::string newProgramName);
	bool hasProgramName(std::string programName);

protected:

};


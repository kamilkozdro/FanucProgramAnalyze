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

	
	bool readProgramFromFile(std::string fileName);
	void printProgramNameList();
	CProgram* getProgramByName(std::string programName);
	int getProgramIndexByName(std::string programName);

private:
	std::vector<CProgram*> programs;
	std::string readFileContent(std::string fileName);
	//std::vector<std::string> readPointsFromFile();
	bool addProgram(std::string newProgramText, std::string newProgramName);
	bool hasProgramName(std::string programName);
	std::string readProgramName(std::string& buffer);
	

protected:

};


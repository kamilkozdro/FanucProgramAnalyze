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
	
	bool addParseProgram(std::string programText);
	CProgram* getProgramByName(std::string programName);
	int getProgramIndexByName(std::string programName);
	std::vector<CProgram*> getPrograms() { return _programs; };
	void printProgramNameList();
	std::string createAllProgramReport();
	std::string createProgramReport(CProgram* program);

private:
	std::vector<CProgram*> _programs;

	void addProgram(std::string newProgramText, std::string newProgramName);
	bool hasProgramName(std::string programName);
	std::string readProgramName(std::string& buffer);

protected:

};


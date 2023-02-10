#pragma once
#include <iostream>
#include <vector>

#include "CPoint.h"

class CProgram
{
public:
	CProgram();
	CProgram(std::string name);
	~CProgram();

	std::vector<CProgram*> subPrograms;

	void addSubProgram(CProgram* subProgram);
	void addPointJoint();
	void addPointJoint(float positions[6]);
	void addPointCartesian();
	void addPointCartesian(float positions[6],
		CPointCartesian::pointConfig config,
		unsigned int frame,
		unsigned int tool);
	void setProgramName(std::string newName) { programName = newName; };
	std::string getProgramName() { return programName; };

	void printPoints();
	void printPrograms();
private:
	std::vector<CPoint*> points;
	std::string programName;


};


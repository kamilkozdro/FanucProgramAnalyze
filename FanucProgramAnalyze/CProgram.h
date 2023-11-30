#pragma once
#include <iostream>
#include <vector>
#include <string>
#include <regex>

#include "CPoint.h"
#include "CSignal.h"
#include "CRegister.h"
#include "CPositionRegister.h"
#include "CPointCartesian.h"
#include "CPointJoint.h"

class CProgram
{
public:
	CProgram();
	CProgram(std::string text, std::string name);
	~CProgram();

	std::vector<CProgram*> subPrograms;

	void addSubProgram(CProgram* subProgram);
	void addPointJoint();
	void addPointJoint(unsigned int index, float positions[6]);
	void addPointJoint(unsigned int index, std::vector<float> positions);
	void addPointCartesian();
	void addPointCartesian(unsigned int index,
		float positions[6],
		CPointCartesian::pointConfig config,
		unsigned int frame,
		unsigned int tool);
	void addPointCartesian(unsigned int index,
		std::vector<float> positions,
		CPointCartesian::pointConfig config,
		unsigned int frame,
		unsigned int tool);
	void setProgramName(std::string newName) { programName = newName; };
	std::string getProgramName() { return programName; };
	bool readPointsAttributes();
	bool readProgramsCalls();
	bool readSignals();
	bool readRegisters();
	bool readPositionRegisters();
	bool readAll();

	void printPoints();
	void printSignals();
	void printRegisters();
	void printPositionRegisters();
	void printProgramsNames();

	std::vector<CSignal> getSignals() { return signals; };
	std::vector<CSignal> getSignals(CSignal::SignalType signalType);
	std::vector<CRegister> getRegisters() { return registers; };
	std::vector<CPositionRegister> getPositionRegister() { return positionRegisters; };

	static std::string findString(std::string& buffer,
		std::string sStartWith,
		std::string sEndsWith,
		size_t& offPos,
		bool ignoreWhitespace);
	static std::string findString(std::string& buffer,
		std::string sStartWith,
		std::string sEndsWith,
		bool ignoreWhitespace);
	static std::string readNumber(std::string& buffer, size_t startPos);
	

private:
	
	std::vector<CPoint*> points;
	std::vector<std::string> calledProgramsNames;
	std::vector<CSignal> signals;
	std::vector<CRegister> registers;
	std::vector<CPositionRegister> positionRegisters;
	std::string programName;
	std::string programText;

	bool readSinglePointAttributes(std::string& buffer);

	bool containSignal(CSignal newSignal);
	bool containRegister(CRegister newRegister);
};


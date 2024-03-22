#include "CProgramsManager.h"

CProgramsManager::CProgramsManager()
{

}

CProgramsManager::~CProgramsManager()
{
	for (CProgram* program : _programs)
	{
		delete program;
		program = nullptr;
	}
	_programs.clear();
}

void CProgramsManager::addProgram(std::string newProgramText, std::string newProgramName = "")
{
	CProgram* newProgram = new CProgram(newProgramText, newProgramName);
	_programs.push_back(newProgram);

}

bool CProgramsManager::hasProgramName(std::string programName)
{
	for (CProgram* program : _programs)
	{
		if (program->getProgramName() == programName)
			return true;
	}
	return false;
}

bool CProgramsManager::addParseProgram(std::string programText)
{
	if (programText.empty())
	{
		std::cout << "Error: Empty program" << std::endl;
		return false;
	}

	std::string programName = readProgramName(programText);

	if (programName.empty())
	{
		std::cout << "Could not find program name in program text" << std::endl;
		return false;
	}
	if (hasProgramName(programName))
	{
		std::cout << "Program is already added" << std::endl;
		return false;
	}

	CProgram* newProgram = new CProgram(programText, programName);
	newProgram->readAll();
	_programs.push_back(newProgram);

	return true;
}

std::string CProgramsManager::readProgramName(std::string& buffer)
{
	std::regex pattern("/PROG\\s+([^\\s]+)");

	std::smatch match;
	std::regex_search(buffer, match, pattern);

	return match[1].str();
}

void CProgramsManager::printProgramNameList()
{
	std::cout << "Program names:" << std::endl;
	for (CProgram* program : _programs)
	{
		std::cout << program->getProgramName() << std::endl;
	}
}

CProgram* CProgramsManager::getProgramByName(std::string programName)
{
	for (unsigned int i = 0; i < _programs.size(); ++i)
	{
		if (_programs.at(i)->getProgramName() == programName)
			return _programs.at(i);
	}

	return nullptr;
}

int CProgramsManager::getProgramIndexByName(std::string programName)
{
	for (unsigned int i = 0; i < _programs.size(); ++i)
	{
		if (_programs.at(i)->getProgramName() == programName)
			return i;
	}
	return -1;
}

std::string CProgramsManager::createProgramReport(CProgram* program)
{
	std::string header = program->getProgramName() + ";R;PR;";
	for (CSignal::SignalType signalType : CSignal::getAllSignalTypes())
	{
		header.append(CSignal::getTypeString(signalType) + ";");
	}
	header.append("\n");

	size_t maxSize = 0;

	std::vector<CRegister> registersToExport = program->getRegisters();
	if (maxSize < registersToExport.size())
		maxSize = registersToExport.size();

	std::vector<CPositionRegister> positionRegistersToExport = program->getPositionRegister();
	if (maxSize < positionRegistersToExport.size())
		maxSize = positionRegistersToExport.size();

	std::vector<std::vector<CSignal>> signalsToExport;
	for (CSignal::SignalType signalType : CSignal::getAllSignalTypes())
	{
		std::vector<CSignal> signalsOneTypeVec = program->getSignals(signalType);
		signalsToExport.push_back(signalsOneTypeVec);
		if (maxSize < signalsOneTypeVec.size())
			maxSize = signalsOneTypeVec.size();
	}

	std::string body = "";
	for (int i = 0; i < maxSize; ++i)
	{
		body.append(";");

		if (registersToExport.size() < i + 1)
			body.append(";");
		else
		{
			std::string registerString = std::to_string(registersToExport[i].getIndex()) + ":" + registersToExport[i].getComment();
			body.append(registerString + ";");
		}

		if (positionRegistersToExport.size() < i + 1)
			body.append(";");
		else
		{
			std::string positionRegisterString = std::to_string(positionRegistersToExport[i].getIndex()) + ":" + positionRegistersToExport[i].getComment();
			body.append(positionRegisterString + ";");
		}

		for (std::vector<CSignal> signalVec : signalsToExport)
		{
			if (signalVec.size() < i + 1)
			{
				body.append(";");
			}
			else
			{
				std::string signalString = std::to_string(signalVec[i].getIndex()) + ":" + signalVec[i].getComment();
				body.append(signalString + ";");
			}
		}
		body.append("\n");
	}

	return header + body + '\n';
}

std::string CProgramsManager::createAllProgramReport()
{
	std::string programsReport = "";
	for (CProgram* program : _programs)
	{
		programsReport.append(createProgramReport(program));
	}

	return programsReport;
}


#include "CProgramsManager.h"

CProgramsManager::CProgramsManager()
{

}

CProgramsManager::~CProgramsManager()
{
	for (CProgram* program : programs)
	{
		delete program;
		program = nullptr;
	}
	programs.clear();
}

void CProgramsManager::addProgram(std::string newProgramText, std::string newProgramName = "")
{
	CProgram* newProgram = new CProgram(newProgramText, newProgramName);
	programs.push_back(newProgram);

}

bool CProgramsManager::hasProgramName(std::string programName)
{
	for (CProgram* program : programs)
	{
		if (program->getProgramName() == programName)
			return true;
	}
	return false;
}

std::string CProgramsManager::readFileContent(std::string fileName)
{
	std::ifstream fileStream;

	if (fileStream.is_open())
		fileStream.close();

	fileStream.open(fileName);

	if (!fileStream.is_open())
	{
		std::cout << "Cannot open file: " << fileName << std::endl;
		return "";
	}

	std::stringstream strStream;
	strStream << fileStream.rdbuf();
	fileStream.close();
	return strStream.str();

}

bool CProgramsManager::addProgramFromFile(std::string fileName)
{
	if (fileName.empty())
	{
		std::cout << "Error: Empty program file name" << std::endl;
		return false;
	}

	std::string fileBuffer = readFileContent(fileName);
	if (fileBuffer.empty())
	{
		std::cout << "Error: Empty program: " << fileName << std::endl;
		return false;
	}

	std::string programName = readProgramName(fileBuffer);

	if (programName.empty())
	{
		std::cout << "There is no program name in: " << fileName << "\n";
		return false;
	}
	if (hasProgramName(programName))
	{
		std::cout << "Program already opened" << std::endl;
		return false;
	}

	CProgram *newProgram = new CProgram(fileBuffer, programName);
	newProgram->readAll();
	programs.push_back(newProgram);

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
	for (CProgram* program : programs)
	{
		std::cout << program->getProgramName() << std::endl;
	}
}

CProgram* CProgramsManager::getProgramByName(std::string programName)
{
	for (unsigned int i = 0; i < programs.size(); ++i)
	{
		if (programs.at(i)->getProgramName() == programName)
			return programs.at(i);
	}

	return nullptr;
}

int CProgramsManager::getProgramIndexByName(std::string programName)
{
	for (unsigned int i = 0; i < programs.size(); ++i)
	{
		if (programs.at(i)->getProgramName() == programName)
			return i;
	}
	return -1;
}

void CProgramsManager::programToCSV(CProgram* program)
{
	std::string header = program->getProgramName()+ ";R;PR;";
	for (CSignal::SignalType signalType : CSignal::getAllSignalTypes())
	{
		header.append(CSignal::getTypeString(signalType)+";");
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
	for (int i = 0; i < maxSize ; ++i)
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
			if (signalVec.size() < i+1)
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

}

void CProgramsManager::saveToFile(std::string filePath, std::string text)
{
	std::ofstream outputStream(filePath);
	if (outputStream.is_open())
	{
		outputStream << text;

		outputStream.close();

		std::cout << "Report successfully saved to " << filePath << std::endl;
	}
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

std::string CProgramsManager::createProgramReport(std::vector<CProgram*> programs)
{
	std::string programsReport = "";
	for (CProgram* program : programs)
	{
		programsReport.append(createProgramReport(program));
	}

	return programsReport;
}

void CProgramsManager::exportToCSV(CProgram* program)
{
	saveToFile("report.csv", createProgramReport(program));
}

void CProgramsManager::exportToCSV(std::vector<CProgram*> programs)
{
	saveToFile("report.csv", createProgramReport(programs));
}
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

bool CProgramsManager::addProgram(std::string newProgramText, std::string newProgramName = "")
{
	//std::cout << "Adding program: " << newProgramName << std::endl;

	CProgram* newProgram = new CProgram(newProgramText, newProgramName);
	programs.push_back(newProgram);

	return true;
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
		//THROW ERROR
		return false;
	}

	std::string fileBuffer = readFileContent(fileName);
	if (fileBuffer.empty())
	{
		//THROW ERROR
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
		//THROW ERROR
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
	std::string programNameKeyword = "/PROG";
	std::string programName;
	size_t programNameIndex = buffer.find(programNameKeyword);
	if (programNameIndex == std::string::npos)
	{
		return "";
	}
	programNameIndex += programNameKeyword.length();
	// Skip whitespaces after keyword
	while (std::isspace(buffer[programNameIndex]))
	{
		programNameIndex++;
	}
	// Read program name
	while (std::isalnum(buffer[programNameIndex])
		|| buffer[programNameIndex] == '_'
		|| buffer[programNameIndex] == '-')
	{
		programName.push_back(buffer[programNameIndex]);
		programNameIndex++;
	}

	return programName;
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
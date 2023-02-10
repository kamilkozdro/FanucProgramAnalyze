#include "CProgramsManager.h"

CProgramsManager::CProgramsManager()
{

}

CProgramsManager::~CProgramsManager()
{
	for (CProgram* program : programs)
	{
		delete program;
	}
	programs.clear();

	std::cout << "CProgramsManager destroyed" << std::endl;
}

bool CProgramsManager::addProgram(std::string newProgramName)
{
	if (hasProgramName(newProgramName))
	{
		std::cout << "Program already opened" << std::endl;
		return false;
	}

	std::cout << "Adding program: " << newProgramName << std::endl;

	CProgram* newProgram = new CProgram(newProgramName);
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

void CProgramsManager::readFile(std::string fileName)
{
	if (streamRead.is_open())
		streamRead.close();

	streamRead.open(fileName);

	if (!streamRead.is_open())
	{
		std::cout << "Cannot open file: " << fileName << std::endl;
		return;
	}

	std::string newProgramName = readProgramNameFromFile();

	if (newProgramName == "")
	{
		std::cout << "Could not find program name in file" << std::endl;
		return;
	}

	if (!addProgram(newProgramName))
	{
		return;
	}

	streamRead.close();
}

void CProgramsManager::printProgramNameList()
{
	for (CProgram* program : programs)
	{
		std::cout << "program name:" << program->getProgramName() << std::endl;
		std::cout << " Sub programs:" << std::endl;
		program->printPrograms();
		std::cout << std::endl;
	}
}

std::string CProgramsManager::readProgramNameFromFile()
{
	if (!streamRead.is_open())
	{
		std::cout << "File is not opened" << std::endl;
		return "";
	}
	// Return to beggining of file
	streamRead.clear();
	streamRead.seekg(0, std::ios::beg);

	std::string lineRead;
	std::string programName;
	std::string PROGString("/PROG");

	while (!streamRead.eof())
	{
		std::getline(streamRead, lineRead);
		std::size_t pos = lineRead.find(PROGString);
		if (pos != std::string::npos)
		{
			std::stringstream lineStream(lineRead);
			lineStream.seekg(pos + PROGString.length(), std::ios::beg);
			lineStream >> programName;
			return programName;
		}
	}

	return "";
}

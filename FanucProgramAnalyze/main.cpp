#include <iostream>
#include <fstream>
#include <filesystem>

#include "CProgramsManager.h"

int main()
{
	
	std::vector<std::string> excludePrograms{};

	std::string path("fanucPrograms/");
	std::string allowedExtension(".ls");
	std::vector<std::string> programFiles;

	for (auto& p : std::filesystem::recursive_directory_iterator(path))
	{
		if (p.path().extension() == allowedExtension)
		{
			programFiles.push_back(p.path().stem().string() + allowedExtension);
		}
	}

	if (programFiles.empty())
	{
		std::cout << "Could not find adequate programs" << std::endl;
		return 0;
	}

	CProgramsManager programManager;

	for (std::string file : programFiles)
	{
		programManager.readProgramFromFile(path + file);
	}
	
	CProgram* fanucProgram = programManager.getProgramByName("SPRAWDZIANY");
	if (fanucProgram == nullptr)
		return 0;

	fanucProgram->readSignals();
	fanucProgram->printSignals();
	
	


	return 1;
}
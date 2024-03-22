#pragma once
#include "CProgram.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <filesystem>

class CFileManager
{
public:
	CFileManager();
	~CFileManager();

	void findFiles(std::string directory);
	static std::string readFileContent(std::string filePath);
	std::string readFileContent(int index);
	void saveToFile(std::string filePath, std::string text);

	size_t countProgramFilePaths() { return programFilePaths.size(); };
	std::string getProgramFilePath(int index);

	void addExcludeProgram(std::string programName) { excludePrograms.push_back(programName); };

protected:

	std::string programsDir;
	std::vector<std::string> excludePrograms;
	std::vector<std::string> programFilePaths;
	std::string allowedExtension;

	bool checkProgramFilePathsIndex(int index);

};
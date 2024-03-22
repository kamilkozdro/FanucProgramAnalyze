#include "CFileManager.h"

CFileManager::CFileManager()
{
	excludePrograms = { "-bckedt-", "erract", "errall", "errapp", "errcomm", "errcurr", "errext", "errhist", "errmot", 
		"errpwd", "errsys", "getdata", "hist", "logbook", "reqmenu", "senddata", "sendevnt", "sendsysv", "updtlog" };
	allowedExtension = ".ls";
}

CFileManager::~CFileManager()
{

}

void CFileManager::findFiles(std::string directory)
{
	programFilePaths.clear();
	programsDir = directory;
	for (auto& p : std::filesystem::recursive_directory_iterator(directory))
	{

		if (std::find(excludePrograms.begin(), excludePrograms.end(), p.path().filename().stem()) != excludePrograms.end())
			continue;
		if (p.path().extension() == allowedExtension)
		{
			programFilePaths.push_back(p.path().string());
		}
	}

	if (programFilePaths.empty())
	{
		std::cout << "Could not find adequate programs" << std::endl;
		return;
	}
}

std::string CFileManager::getProgramFilePath(int index)
{
	if (!checkProgramFilePathsIndex(index))
		return "";

	return programFilePaths.at(index);
}

void CFileManager::saveToFile(std::string filePath, std::string text)
{
	std::ofstream outputStream(filePath);
	if (outputStream.is_open())
	{
		outputStream << text;
		outputStream.close();
	}
}

std::string CFileManager::readFileContent(std::string filePath)
{
	std::ifstream fileStream;

	fileStream.open(filePath);

	if (!fileStream.is_open())
	{
		std::cout << "Cannot open file: " << filePath << std::endl;
		return "";
	}

	std::stringstream strStream;
	strStream << fileStream.rdbuf();
	fileStream.close();
	return strStream.str();

}

std::string CFileManager::readFileContent(int index)
{
	if (!checkProgramFilePathsIndex(index))
		return "";

	return readFileContent(programFilePaths.at(index));
}

bool CFileManager::checkProgramFilePathsIndex(int index)
{
	if (index < 0 || index >= countProgramFilePaths())
	{
		std::cout << "Index is out of range";
		return false;
	}
	return true;
}
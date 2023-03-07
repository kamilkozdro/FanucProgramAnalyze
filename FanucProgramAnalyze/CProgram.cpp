#include "CProgram.h"

CProgram::CProgram()
{

}

CProgram::CProgram(std::string text, std::string name = "")
{
	programText = text;
	programName = name;
}

CProgram::~CProgram()
{
	for (CPoint* point : points)
	{
		delete point;
	}
	points.clear();

	//std::cout << "CProgram destroyed" << std::endl;
}

void CProgram::addSubProgram(CProgram* subProgram)
{
	subPrograms.push_back(subProgram);
}

void CProgram::addPointJoint()
{
	CPointJoint* newPoint = new CPointJoint;

	points.push_back(newPoint);
}

void CProgram::addPointJoint(unsigned int index, float positions[6])
{
	CPointJoint* newPoint = new CPointJoint;

	newPoint->setIndex(index);
	newPoint->setPosition(positions);

	points.push_back(newPoint);
}

void CProgram::addPointJoint(unsigned int index, std::vector<float> positions)
{
	CPointJoint* newPoint = new CPointJoint;

	newPoint->setIndex(index);
	newPoint->setPosition(positions);

	points.push_back(newPoint);
}

void CProgram::addPointCartesian()
{
	CPointCartesian* newPoint = new CPointCartesian;

	points.push_back(newPoint);
}

void CProgram::addPointCartesian(unsigned int index,
	float positions[6],
	CPointCartesian::pointConfig config,
	unsigned int frame,
	unsigned int tool)
{
	CPointCartesian* newPoint = new CPointCartesian;

	newPoint->setIndex(index);
	newPoint->setPosition(positions);
	newPoint->setConfig(config);
	newPoint->setFrame(frame);
	newPoint->setTool(tool);

	points.push_back(newPoint);
}

void CProgram::addPointCartesian(unsigned int index,
	std::vector<float> positions,
	CPointCartesian::pointConfig config,
	unsigned int frame,
	unsigned int tool)
{
	CPointCartesian* newPoint = new CPointCartesian;

	newPoint->setIndex(index);
	newPoint->setPosition(positions);
	newPoint->setConfig(config);
	newPoint->setFrame(frame);
	newPoint->setTool(tool);

	points.push_back(newPoint);
}

bool CProgram::readPointsAttributes()
{
	if (programText.empty())
	{
		//THROW ERROR
		return false;
	}

	// Divide /POS section to multiple P[]{}; sections
	std::vector<std::string> sPointsAttributes;
	size_t posBlockIndex = programText.rfind("/POS");
	size_t pointStartIndex = programText.find("P[", posBlockIndex);

	if (posBlockIndex == std::string::npos
		|| pointStartIndex == std::string::npos)
	{
		return false;
	}

	size_t pointEndIndex = 0;
	while (pointStartIndex != std::string::npos)
	{
		pointEndIndex = programText.find("};", pointStartIndex);
		std::string sPointAttribute = programText.substr(pointStartIndex,
			pointEndIndex - pointStartIndex);
		sPointsAttributes.push_back(sPointAttribute);
		pointStartIndex = programText.find("P[", pointEndIndex);
	}
	
	if (sPointsAttributes.empty())
	{
		std::cout << "No points attributes in program:" << programName << "\n";
		return false;
	}

	for (std::string pointAttr : sPointsAttributes)
	{
		readSinglePointAttributes(pointAttr);
	}

	return true;
}

bool CProgram::readProgramsCalls()
{
	size_t sectionStartPos = programText.find("/MN");
	if (sectionStartPos == std::string::npos)
	{
		return false;
	}
	size_t sectionEndPos = programText.find("/POS", sectionStartPos);
	if (sectionEndPos == std::string::npos)
	{
		return false;
	}

	std::string programSection = programText.substr(sectionStartPos, sectionEndPos - sectionStartPos);
	size_t pos = 0;
	while (pos < programSection.length())
	{
		std::string calledProgramName = readProgramCall(programSection, pos);
		if (calledProgramName == "")
			break;

		if (!std::count(calledProgramsNames.begin(), 
			calledProgramsNames.end(), 
			calledProgramName))
		{
			calledProgramsNames.push_back(calledProgramName);
		}
	}

	return true;
}

void CProgram::printPoints()
{
	for (CPoint* point : points)
	{
		point->printInfo();
		std::cout << "\n";
	}
}

void CProgram::printSignals()
{
	std::cout << "Signals:\n";
	for (CSignal signal : signals)
	{
		std::cout << "\t- ";
		signal.printInfo();
	}
}

void CProgram::printRegisters()
{
	std::cout << "Registers:\n";
	for (CRegister reg : registers)
	{
		std::cout << "\t- ";
		reg.printInfo();
	}
}

void CProgram::printProgramsNames()
{
	std::cout << "Called Programs:\n";
	for (std::string program : calledProgramsNames)
	{
		std::cout << "\t - " << program << "\n";
	}
}

std::string CProgram::findString(std::string& buffer,
	std::string sStartWith,
	std::string sEndsWith,
	size_t& offPos,
	bool ignoreWhitespace = false)
{
	size_t startIndex = buffer.find(sStartWith, offPos);
	if (startIndex == std::string::npos)
		return "";

	offPos = startIndex;
	startIndex +=  sStartWith.length();
	
	size_t endIndex = 0;
	if (sEndsWith == "")
	{
		endIndex = buffer.length();
	}
	else
	{
		endIndex = buffer.find(sEndsWith, startIndex);
		if (endIndex == std::string::npos)
			return "";
	}
	
	std::string foundString = buffer.substr(startIndex, endIndex - startIndex);

	if (!ignoreWhitespace)
	{
		foundString.erase(std::remove_if(foundString.begin(),
			foundString.end(),
			[](unsigned char x) { return std::isblank(x); }),
			foundString.end());
	}

	return foundString;
}

std::string CProgram::findString(std::string& buffer,
	std::string sStartWith,
	std::string sEndsWith,
	bool ignoreWhitespace = false)
{
	size_t zeroPos = 0;
	return findString(buffer, sStartWith, sEndsWith, zeroPos, ignoreWhitespace);
}

std::string CProgram::readNumber(std::string& buffer, size_t startPos = 0)
{
	bool allowMinusSign = true;
	bool allowDotSign = true;
	std::size_t index = startPos;
	std::string resultString;

	// Find beggining of number
	while (!std::isdigit(buffer.at(index))
		&& buffer.at(index) != '-'
		&& buffer.at(index) != '.')
	{
		index++;
		if (index >= buffer.length())
			break;
	}

	if (index >= buffer.length())
		return "";

	// Read and save digits and allowed characters
	std::string returnNumberString;
	while (std::isdigit(buffer.at(index))
		|| (buffer.at(index) == '-' && allowMinusSign)
		|| (buffer.at(index) == '.' && allowDotSign))
	{
		if (buffer.at(index) == '.')
			allowDotSign = false;
		if (buffer.at(index) == '-')
			allowMinusSign = false;

		returnNumberString.push_back(buffer.at(index));
		index++;
		if (index >= buffer.length())
			break;
	}

	return returnNumberString;
}

std::string CProgram::readProgramCall(std::string& buffer, size_t& pos)
{
	std::string keyword = "CALL";
	size_t callFoundPos = buffer.find(keyword, pos);
	if (callFoundPos == std::string::npos)
	{
		return "";
	}

	pos = callFoundPos + keyword.length();
	// Find beggining of called program name
	while (!std::isalnum(buffer.at(pos)))
	{
		pos++;
		if (pos >= buffer.length())
		{
			return "";
		}
	}

	// Add characters to name string
	std::string calledProgramName;
	while (std::isalnum(buffer.at(pos))
		|| buffer.at(pos) == '-'
		|| buffer.at(pos) == '_')
	{
		calledProgramName.push_back(buffer.at(pos));
		pos++;
		if (pos >= buffer.length())
		{
			return "";
		}
	}

	return calledProgramName;
}

bool CProgram::readSinglePointAttributes(std::string& buffer)
{
	// Find Point number
	size_t zeroPos = 0;
	std::string sPointNumber = findString(buffer, "P[", "]");
	if (sPointNumber.empty())
	{
		std::cout << "sPointNumber - empty" << "\n";
		return false;
	}
	unsigned int iPointNumber = std::stoi(sPointNumber);

	// Find config and point type
	CPoint::PointType pointType;
	std::string sConfig = findString(buffer, "CONFIG : '", "'");
	if (sConfig.empty())
	{
		pointType = CPoint::PointType::Joint;
	}
	else
	{
		pointType = CPoint::PointType::Cartesian;

	}

		switch (pointType)
	{
	case CPoint::PointType::Joint:
	{
		//Find point coordinates
		std::vector<float> sCordsValues;
		std::vector<std::string> sCordsKeywords =
		{ "J1=", "J2=", "J3=", "J4=", "J5=", "J6=" };

		for (std::string keyword : sCordsKeywords)
		{
			size_t cordIndex = buffer.find(keyword);
			if (cordIndex == std::string::npos)
			{
				std::cout << "Could not find " << keyword << " value\n";
				return false;
			}

			std::string sCordValue = CProgram::readNumber(buffer, cordIndex + keyword.length());
			if (sCordValue.empty())
			{
				std::cout << "sCordValue.empty()\n";
				return false;
			}
			
			sCordValue = readNumber(sCordValue);
			sCordsValues.push_back(std::stof(sCordValue));
		}

		//Add Joint Point
		//std::cout << "Added point: " << iPointNumber << "\n";
		addPointJoint(iPointNumber, sCordsValues);

		return true;
	}
	case  CPoint::PointType::Cartesian:
	{
		//Find point coordinates
		std::vector<float> sCordsValues;
		std::vector<std::string> sCordsKeywords =
		{ "X =", "Y =", "Z =", "W =", "P =", "R =" };

		for (auto& keyword : sCordsKeywords)
		{
			size_t cordIndex = buffer.find(keyword);
			if (cordIndex == std::string::npos)
			{
				std::cout << "Could not find " << keyword << " value\n";
				return false;
			}

			std::string sCordValue = CProgram::readNumber(buffer, cordIndex + keyword.length());
			if (sCordValue.empty())
			{
				return false;
			}
			sCordValue = readNumber(sCordValue);
			sCordsValues.push_back(std::stof(sCordValue));
		}

		//Find point Config
		CPointCartesian::pointConfig pointConfig;
		// Remove spaces and ','
		sConfig.erase(std::remove(sConfig.begin(), sConfig.end(), ' '), sConfig.end());
		sConfig.erase(std::remove(sConfig.begin(), sConfig.end(), ','), sConfig.end());

		if (sConfig.length() != 6)
		{
			//THROW ERROR
			return false;
		}

		if (sConfig.at(0) == 'N')
			pointConfig.flag1 = CPointCartesian::ConfigFlag1::N;
		else if (sConfig.at(0) == 'F')
			pointConfig.flag1 = CPointCartesian::ConfigFlag1::F;
		else
		{
			//THROW ERROR
			return false;
		}

		if (sConfig.at(1) == 'D')
			pointConfig.flag2 = CPointCartesian::ConfigFlag2::D;
		else if (sConfig.at(1) == 'U')
			pointConfig.flag2 = CPointCartesian::ConfigFlag2::U;
		else
		{
			//THROW ERROR
			return false;
		}

		if (sConfig.at(2) == 'B')
			pointConfig.flag3 = CPointCartesian::ConfigFlag3::B;
		else if (sConfig.at(2) == 'T')
			pointConfig.flag3 = CPointCartesian::ConfigFlag3::T;
		else
		{
			//THROW ERROR
			return false;
		}

		if (sConfig.at(3) == '0')
			pointConfig.flag4 = CPointCartesian::ConfigFlag01::Zero;
		else if (sConfig.at(3) == '1')
			pointConfig.flag4 = CPointCartesian::ConfigFlag01::One;
		else
		{
			//THROW ERROR
			return false;
		}

		if (sConfig.at(4) == '0')
			pointConfig.flag5 = CPointCartesian::ConfigFlag01::Zero;
		else if (sConfig.at(4) == '1')
			pointConfig.flag5 = CPointCartesian::ConfigFlag01::One;
		else
		{
			//THROW ERROR
			return false;
		}

		if (sConfig.at(5) == '0')
			pointConfig.flag6 = CPointCartesian::ConfigFlag01::Zero;
		else if (sConfig.at(5) == '1')
			pointConfig.flag6 = CPointCartesian::ConfigFlag01::One;
		else
		{
			//THROW ERROR
			return false;
		}

		//Find UFRAME and UTOOL
		std::string sFrame = findString(buffer, "UF :", ",");
		std::string sTool = findString(buffer, "UT :", ",");

		if (sFrame.empty() || sTool.empty())
		{
			return false;
		}
		unsigned int iFrame = std::stoi(readNumber(sFrame));
		unsigned int iTool = std::stoi(readNumber(sTool));

		addPointCartesian(iPointNumber,
			sCordsValues,
			pointConfig,
			iFrame,
			iTool);

		return true;
	}
	default:
	{
		return false;
	}
	}

}

bool CProgram::readSignals()
{
	std::string keywordSign = "[";
	std::string keywordEnd = "]";
	std::string keywordCommentBegin = ":";
	std::string keywordCommentEnd = "";
	for (CSignal::SignalType signalType : CSignal::getAllSignalTypes())
	{
		if (signalType == CSignal::SignalType::None)
			continue;
		for	(CSignal::SignalIO signalIO : CSignal::getAllIO())
		{
			if (signalIO == CSignal::SignalIO::None)
				continue;
			std::string keywordBegin =
				CSignal::getTypeKeyword(signalType)
				+ CSignal::getIOKeyword(signalIO)
				+ keywordSign;
			std::string foundString = "Init";
			size_t searchPos = 0;

			while (!foundString.empty() && searchPos < programText.length())
			{
				foundString = findString(programText, keywordBegin, keywordEnd, searchPos);
				if (foundString.empty())
				{
					continue;
				}

				// Find signal index
				size_t searchPos2 = 0;
				std::string sSignalIndex;
				while (std::isdigit(foundString.at(searchPos2))
					&& searchPos2 < foundString.length())
				{
					sSignalIndex.push_back(foundString.at(searchPos2));
					searchPos2++;
				}
				if (sSignalIndex.empty())
					continue;
				unsigned int signalIndex = std::stoi(sSignalIndex);

				// Find signal comment
				std::string signalComment =
					findString(foundString, keywordCommentBegin, keywordCommentEnd);
				// Create Signal, check if already exist, if not -> add
				CSignal newSignal(signalIndex, signalType, signalIO, signalComment);
				if (!containSignal(newSignal))
				{
					signals.push_back(newSignal);
				}
					
				searchPos += foundString.length();
			}
		}
	}

	return true;
}

bool CProgram::readRegisters()
{
	std::string keywordSign = "[";
	std::string keywordEnd = "]";
	std::string keywordCommentBegin = ":";
	std::string keywordCommentEnd = "";
	for (CRegister::RegisterType registerType : CRegister::getAllRegisterTypes())
	{
		if (registerType == CRegister::RegisterType::None)
			continue;

		std::string keywordBegin = 
			CRegister::getTypeKeyword(registerType) + keywordSign;
		std::string foundString = "Init";
		size_t searchPos = 0;

		while (!foundString.empty() && searchPos < programText.length())
		{
			foundString = findString(programText, keywordBegin, keywordEnd, searchPos);
			if (foundString.empty())
			{
				continue;
			}

			// Find register index
			size_t searchPos2 = 0;
			std::string sRegisterIndex;
			while (std::isdigit(foundString.at(searchPos2))
				&& searchPos2 < foundString.length())
			{
				sRegisterIndex.push_back(foundString.at(searchPos2));
				searchPos2++;
			}
			if (sRegisterIndex.empty())
				continue;
			unsigned int registerIndex = std::stoi(sRegisterIndex);

			// Find register comment
			std::string signalComment =
				findString(foundString, keywordCommentBegin, keywordCommentEnd);
			// Create register, check if already exist, if not -> add
			CRegister newRegister(registerIndex, registerType, signalComment);
			if (!containRegister(newRegister))
			{
				registers.push_back(newRegister);
			}

			searchPos += foundString.length();
		}
	}

	return true;
}

bool CProgram::containSignal(CSignal newSignal)
{
	for (CSignal singleSignal : signals)
	{
		if (singleSignal == newSignal)
			return true;
	}
	return false;
}

bool CProgram::containRegister(CRegister newRegister)
{
	for (CRegister singleRegister : registers)
	{
		if (singleRegister == newRegister)
			return true;
	}
	return false;
}
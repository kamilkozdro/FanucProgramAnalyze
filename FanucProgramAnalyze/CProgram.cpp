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

void CProgram::printPoints()
{
	for (CPoint* point : points)
	{
		point->printInfo();
		std::cout << "\n";
	}
}

void CProgram::printPrograms()
{
	for (CProgram* program : subPrograms)
	{
		std::cout << "subPrograms:" << std::endl;
		program->getProgramName();
		std::cout << std::endl;
		program->printPrograms();
		std::cout << std::endl;
	}
}

std::string CProgram::findString(std::string& buffer,
	std::string sStartWith,
	std::string sEndsWith,
	bool ignoreWhitespace = false)
{
	size_t startIndex = buffer.find(sStartWith);
	if (startIndex == std::string::npos)
		return "";

	startIndex += sStartWith.length();

	size_t endIndex = buffer.find(sEndsWith, startIndex);
	if (endIndex == std::string::npos)
		return "";

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

bool CProgram::readSinglePointAttributes(std::string& buffer)
{
	// Find Point number
	std::string sPointNumber = findString(buffer, "P[", "]");
	if (sPointNumber.empty())
	{
		std::cout << "sPointNumber - empty" << "\n";
		return false;
	}
	unsigned int iPointNumber = std::stoi(sPointNumber);

	// Find config and point type
	CPoint::Type pointType;
	std::string sConfig = findString(buffer, "CONFIG : '", "'");
	if (sConfig.empty())
	{
		pointType = CPoint::Type::Joint;
	}
	else
	{
		pointType = CPoint::Type::Cartesian;

	}

		switch (pointType)
	{
	case CPoint::Type::Joint:
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
	case  CPoint::Type::Cartesian:
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

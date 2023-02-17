#include "CPoint.h"

// ******************** CPoint ************************

CPoint::CPoint()
{
	type = Type::None;
}

CPoint::~CPoint()
{
	//std::cout << "CPoint[" << pointIndex << "] destroyed" << std::endl;
}

void CPoint::setPosition(float newPos[6])
{
	for (unsigned short i = 0; i < 6; ++i)
	{
		position[i] = newPos[i];
	}
}

void CPoint::setPosition(std::vector<float> newPos)
{
	if (newPos.size() != 6)
	{
		//THROW ERROR
		return;
	}

	for (unsigned short i = 0; i < 6; ++i)
	{
		position[i] = newPos[i];
	}
}

void CPoint::setPosition(unsigned int index, float newPos)
{
	try
	{
		if (index >= 6)
			throw std::out_of_range("Index out of position array range (max 5)");

		position[index] = newPos;
	}
	catch (std::exception &e)
	{
		std::cout << "CPoint::setPos():" << e.what() << std::endl;
	}
}

float CPoint::getPosition(unsigned int index)
{
	try
	{
		if (index >= 6)
			throw std::out_of_range("Index out of position array range (max 5)");

		return position[index];
	}
	catch (std::exception& e)
	{
		std::cout << "CPoint::getPos():" << e.what() << std::endl;
		return 0;
	}
}

void CPoint::printInfo()
{
	std::cout << "Point P[" << pointIndex << "]:" << std::endl;
	for (unsigned int i = 0; i < 6; ++i)
	{
		std::cout << "\t" << i + 1 << ": " << position[i] << std::endl;
	}
}

// ******************** CPointJoint ************************

CPointJoint::CPointJoint()
{
	type = Type::Joint;
}

void CPointJoint::printInfo()
{
	std::cout << "Point P[" << pointIndex << "]:" << std::endl;
	for (unsigned int i = 0; i < 6; ++i)
	{
		std::cout << "\tJ" << i + 1 << ": " << position[i] << " deg" << std::endl;
	}
}

// ******************** CPointCartesian ************************

CPointCartesian::CPointCartesian()
{
	type = Type::Cartesian;
}

void CPointCartesian::setConfig(ConfigFlag1 newFlag1,
	ConfigFlag2 newFlag2,
	ConfigFlag3 newFlag3,
	ConfigFlag01 newFlag4,
	ConfigFlag01 newFlag5,
	ConfigFlag01 newFlag6)
{
	config.flag1 = newFlag1;
	config.flag2 = newFlag2;
	config.flag3 = newFlag3;
	config.flag4 = newFlag4;
	config.flag5 = newFlag5;
	config.flag6 = newFlag6;

}

void CPointCartesian::setConfig(pointConfig newConfig)
{
	config = newConfig;
}

void CPointCartesian::setDefaultConfig()
{
	config.flag1 = ConfigFlag1::N;
	config.flag2 = ConfigFlag2::U;
	config.flag3 = ConfigFlag3::T;
	config.flag4 = ConfigFlag01::Zero;
	config.flag5 = ConfigFlag01::Zero;
	config.flag6 = ConfigFlag01::Zero;
}

std::string CPointCartesian::getConfigString()
{
	std::string configString;

	if (config.flag1 == ConfigFlag1::N)
		configString.append("N,");
	else if (config.flag1 == ConfigFlag1::F)
		configString.append("F,");

	if (config.flag2 == ConfigFlag2::U)
		configString.append("U,");
	else if (config.flag2 == ConfigFlag2::D)
		configString.append("D,");

	if (config.flag3 == ConfigFlag3::T)
		configString.append("T,");
	else if (config.flag3 == ConfigFlag3::B)
		configString.append("B,");

	if (config.flag4 == ConfigFlag01::Zero)
		configString.append("0,");
	else if (config.flag4 == ConfigFlag01::One)
		configString.append("1,");

	if (config.flag5 == ConfigFlag01::Zero)
		configString.append("0,");
	else if (config.flag5 == ConfigFlag01::One)
		configString.append("1,");

	if (config.flag6 == ConfigFlag01::Zero)
		configString.append("0");
	else if (config.flag6 == ConfigFlag01::One)
		configString.append("1");

	return configString;
}

void CPointCartesian::printInfo()
{
	std::cout << "Point P[" << pointIndex << "]:" << std::endl;
	std::cout << "\t1: X: " << position[0] << " mm" << std::endl;
	std::cout << "\t2: Y: " << position[1] << " mm" << std::endl;
	std::cout << "\t3: Z: " << position[2] << " mm" << std::endl;
	std::cout << "\t4: W: " << position[3] << " deg" << std::endl;
	std::cout << "\t5: P: " << position[4] << " deg" << std::endl;
	std::cout << "\t6: R: " << position[5] << " deg" << std::endl;
	std::cout << "\tConfig: " << getConfigString() << std::endl;
	std::cout << "\tFrame: " << frame << " Tool: " << tool << std::endl;
}




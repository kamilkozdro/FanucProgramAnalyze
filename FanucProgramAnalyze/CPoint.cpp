#include "CPoint.h"

// ******************** CPoint ************************

CPoint::CPoint()
{
	type = PointType::None;
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



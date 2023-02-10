#include "CProgram.h"

CProgram::CProgram()
{

}

CProgram::CProgram(std::string name)
{
	programName = name;
}

CProgram::~CProgram()
{
	for (CPoint* point : points)
	{
		delete point;
	}
	points.clear();

	std::cout << "CProgram destroyed" << std::endl;
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

void CProgram::addPointJoint(float positions[6])
{
	CPointJoint* newPoint = new CPointJoint;

	newPoint->setPosition(positions);

	points.push_back(newPoint);
}

void CProgram::addPointCartesian()
{
	CPointCartesian* newPoint = new CPointCartesian;

	points.push_back(newPoint);
}

void CProgram::addPointCartesian(float positions[6],
	CPointCartesian::pointConfig config,
	unsigned int frame,
	unsigned int tool)
{
	CPointCartesian* newPoint = new CPointCartesian;

	newPoint->setPosition(positions);
	newPoint->setConfig(config);
	newPoint->setFrame(frame);
	newPoint->setTool(tool);

	points.push_back(newPoint);
}

void CProgram::printPoints()
{
	for (CPoint* point : points)
	{
		point->printInfo();
		std::cout << std::endl;
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
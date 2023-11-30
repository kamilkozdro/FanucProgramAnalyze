#include "CPointJoint.h"

CPointJoint::CPointJoint()
{
	type = PointType::Joint;
}

void CPointJoint::printInfo()
{
	std::cout << "Point P[" << index << "]:" << std::endl;
	for (unsigned int i = 0; i < 6; ++i)
	{
		std::cout << "\tJ" << i + 1 << ": " << position[i] << " deg" << std::endl;
	}
}
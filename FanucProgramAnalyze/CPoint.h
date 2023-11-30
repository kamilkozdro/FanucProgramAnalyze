#pragma once
#include <iostream>
#include <vector>

#include "CIndexed.h"

class CPoint : public CIndexed
{
public:
	enum class PointType {Joint, Cartesian, None};

	CPoint();
	virtual ~CPoint();

	void setPosition(float newPos[6]);
	void setPosition(std::vector<float> newPos);
	void setPosition(unsigned int index, float newPos);
	float getPosition(unsigned int index);
	PointType getType() { return type; };
	void virtual printInfo();

private:
	
protected:
	float position[6] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
	PointType type;
};


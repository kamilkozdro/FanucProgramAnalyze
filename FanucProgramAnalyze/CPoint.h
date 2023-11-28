#pragma once
#include <iostream>
#include <vector>

class CPoint
{
public:
	enum class PointType {Joint, Cartesian, None};

	CPoint();
	virtual ~CPoint();

	void setPosition(float newPos[6]);
	void setPosition(std::vector<float> newPos);
	void setPosition(unsigned int index, float newPos);
	float getPosition(unsigned int index);
	void setIndex(unsigned int newIndex) { pointIndex = newIndex; };
	unsigned int getIndex() { return pointIndex; };
	PointType getType() { return type; };
	void virtual printInfo();

private:
	
protected:
	float position[6] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
	unsigned int pointIndex = 0;
	PointType type;
};


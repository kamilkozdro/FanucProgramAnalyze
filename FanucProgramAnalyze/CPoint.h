#pragma once
#include <iostream>
#include <vector>

class CPoint
{
public:
	enum class Type {Joint, Cartesian, None};

	CPoint();
	virtual ~CPoint();

	void setPosition(float newPos[6]);
	void setPosition(std::vector<float> newPos);
	void setPosition(unsigned int index, float newPos);
	float getPosition(unsigned int index);
	void setIndex(unsigned int newIndex) { pointIndex = newIndex; };
	unsigned int getIndex() { return pointIndex; };
	Type getType() { return type; };
	void virtual printInfo();

private:
	
protected:
	float position[6] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };
	unsigned int pointIndex = 0;
	Type type;
};

class CPointJoint : public CPoint
{
public:
	CPointJoint();

	void printInfo();
private:

protected:
};

class CPointCartesian : public CPoint
{
	

public:
	enum class ConfigFlag1 { N, F };
	enum class ConfigFlag2 { U, D };
	enum class ConfigFlag3 { T, B };
	enum class ConfigFlag01 { Zero, One };

	struct pointConfig
	{
		ConfigFlag1 flag1 = ConfigFlag1::N;
		ConfigFlag2 flag2 = ConfigFlag2::U;
		ConfigFlag3 flag3 = ConfigFlag3::T;
		ConfigFlag01 flag4 = ConfigFlag01::Zero;
		ConfigFlag01 flag5 = ConfigFlag01::Zero;
		ConfigFlag01 flag6 = ConfigFlag01::Zero;
	};

	CPointCartesian();

	void setConfig(ConfigFlag1 newFlag1,
		ConfigFlag2 newFlag2,
		ConfigFlag3 newFlag3,
		ConfigFlag01 newFlag4,
		ConfigFlag01 newFlag5,
		ConfigFlag01 newFlag6);
	void setConfig(pointConfig newConfig);
	void setDefaultConfig();
	std::string getConfigString();
	void setFrame(unsigned int newFrame) { frame = newFrame; };
	unsigned int getFrame() { return frame; };
	void setTool(unsigned int newTool) { tool = newTool; };
	unsigned int getTool() { return tool; };
	void printInfo();

private:
	pointConfig config;
	unsigned int frame = 0;
	unsigned int tool = 0;

protected:
};


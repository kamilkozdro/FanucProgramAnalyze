#pragma once
#include <iostream>
#include <vector>

class CSignal
{
public:
	enum class SignalType { Digital, Analog, Group, 
		Robot, Flag , UOP, SOP, None};
	enum class SignalIO { Input, Output, None};

	CSignal();
	CSignal(unsigned int newIndex, SignalType newType, SignalIO newIO, std::string newComment);

	void setIndex(unsigned int newIndex) { index = newIndex; };
	unsigned int getIndex() { return index; };
	void setType(SignalType newType) { type = newType; };
	SignalType getType() { return type; };
	void setComment(std::string newComment) { comment = newComment; };
	std::string getComment() { return comment; };
	static std::string getTypeString(SignalType typeToGet);
	std::string getTypeString() { return getTypeString(type); };
	static std::vector<SignalType> getAllSignalTypes();
	static std::vector<std::string> getAllSignalTypesString();
	static std::string getTypeKeyword(SignalType typeToGet);
	std::string getTypeKeyword() { return getTypeKeyword(type); };
	
	void setIO(SignalIO newIO) { io = newIO; };
	SignalIO getIO() { return io; };
	std::string getIOString();
	static std::vector<SignalIO> getAllIO();
	static std::string getIOKeyword(SignalIO ioToGet);
	std::string getIOKeyword() { return getIOKeyword(io); };
	void virtual printInfo();

	bool operator ==(CSignal signalToCompare);

private:

protected:
	unsigned int index = 0;
	SignalType type = SignalType::None;
	SignalIO io = SignalIO::None;
	std::string comment = "";

};

class CSignalDigital : public CSignal
{
public:
	CSignalDigital(unsigned int newIndex, SignalIO newIO, std::string newComment);
};

class CSignalAnalog : public CSignal
{
public:
	CSignalAnalog(unsigned int newIndex, SignalIO newIO, std::string newComment);
};

class CSignalGroup : public CSignal
{
public:
	CSignalGroup(unsigned int newIndex, SignalIO newIO, std::string newComment);
};

class CSignalRobot : public CSignal
{
public:
	CSignalRobot(unsigned int newIndex, SignalIO newIO, std::string newComment);
};

class CSignalFlag : public CSignal
{
public:
	CSignalFlag(unsigned int newIndex, SignalIO newIO, std::string newComment);
};

class CSignalUOP : public CSignal
{
public:
	CSignalUOP(unsigned int newIndex, SignalIO newIO, std::string newComment);
};

class CSignalSOP : public CSignal
{
public:
	CSignalSOP(unsigned int newIndex, SignalIO newIO, std::string newComment);
};

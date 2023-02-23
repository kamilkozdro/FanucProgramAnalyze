#pragma once
#include <iostream>
#include <vector>

class CSignal
{
public:
	enum class Type { Digital, Analog, Group, 
		Robot, Flag , UOP, SOP, None};
	enum class IO { Input, Output, None};

	CSignal();
	CSignal(unsigned int newIndex, Type newType, IO newIO, std::string newComment);

	void setIndex(unsigned int newIndex) { index = newIndex; };
	unsigned int getIndex() { return index; };
	void setType(Type newType) { type = newType; };
	Type getType() { return type; };
	void setComment(std::string newComment) { comment = newComment; };
	std::string getComment() { return comment; };
	static std::string getTypeString(Type typeToGet);
	std::string getTypeString() { return getTypeString(type); };
	static std::vector<Type> getAllTypes();
	static std::vector<std::string> getAllTypesString();
	static std::string getTypeKeyword(Type typeToGet);
	std::string getTypeKeyword() { return getTypeKeyword(type); };
	
	void setIO(IO newIO) { io = newIO; };
	IO getIO() { return io; };
	std::string getIOString();
	static std::vector<IO> getAllIO();
	static std::string getIOKeyword(IO ioToGet);
	std::string getIOKeyword() { return getIOKeyword(io); };
	void virtual printInfo();

	bool operator ==(CSignal signalToCompare);

private:

protected:
	unsigned int index = 0;
	Type type = Type::None;
	IO io = IO::None;
	std::string comment = "";

};

class CSignalDigital : public CSignal
{
public:
	CSignalDigital(unsigned int newIndex, IO newIO, std::string newComment);
};

class CSignalAnalog : public CSignal
{
public:
	CSignalAnalog(unsigned int newIndex, IO newIO, std::string newComment);
};

class CSignalGroup : public CSignal
{
public:
	CSignalGroup(unsigned int newIndex, IO newIO, std::string newComment);
};

class CSignalRobot : public CSignal
{
public:
	CSignalRobot(unsigned int newIndex, IO newIO, std::string newComment);
};

class CSignalFlag : public CSignal
{
public:
	CSignalFlag(unsigned int newIndex, IO newIO, std::string newComment);
};

class CSignalUOP : public CSignal
{
public:
	CSignalUOP(unsigned int newIndex, IO newIO, std::string newComment);
};

class CSignalSOP : public CSignal
{
public:
	CSignalSOP(unsigned int newIndex, IO newIO, std::string newComment);
};

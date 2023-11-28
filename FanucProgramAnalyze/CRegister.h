#pragma once
#include <iostream>
#include <vector>
#include "CPoint.h"

class CRegister
{
	

public:
	enum class RegisterType { Register, PositionRegister, None };

	CRegister();
	CRegister(unsigned int newIndex, RegisterType newType, std::string newComment);
	CRegister(unsigned int newIndex, std::string newComment);

	void setIndex(unsigned int newIndex) { index = newIndex; };
	unsigned int getIndex() { return index; };
	void setType(RegisterType newType) { type = newType; };
	RegisterType getType() { return type; };
	void setComment(std::string newComment) { comment = newComment; };
	std::string getComment() { return comment; };
	static std::string getTypeString(RegisterType typeToGet);
	std::string getTypeString() { return getTypeString(type); };
	static std::vector<RegisterType> getAllRegisterTypes();
	static std::vector<std::string> getAllRegisterTypesString();
	static std::string getTypeKeyword(RegisterType typeToGet);
	std::string getTypeKeyword() { return getTypeKeyword(type); };

	void printInfo();

	bool operator ==(CRegister registerToCompare);

protected:
	unsigned int index = 0;
	RegisterType type = RegisterType::None;
	std::string comment = "";
	float value = 0;

private:


};

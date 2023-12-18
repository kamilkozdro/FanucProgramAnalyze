#pragma once
#include <iostream>
#include <vector>
#include "CPoint.h"
#include "CIndexed.h"

class CRegister : public CIndexed
{
	

public:
	enum class RegisterType { Register, PositionRegister};

	CRegister();
	CRegister(unsigned int newIndex, RegisterType newType, std::string newComment = "");
	CRegister(unsigned int newIndex, std::string newComment = "");

	void setType(RegisterType newType) { type = newType; };
	RegisterType getType() { return type; };
	static std::string getTypeString(RegisterType typeToGet);
	std::string getTypeString() { return getTypeString(type); };
	static std::vector<RegisterType> getAllRegisterTypes();
	static std::vector<std::string> getAllRegisterTypesString();
	static std::string getTypeKeyword(RegisterType typeToGet);
	std::string getTypeKeyword() { return getTypeKeyword(type); };

	virtual void printInfo() override;

	bool operator ==(CRegister registerToCompare);
	bool operator >(CRegister registerToCompare) { return index > registerToCompare.getIndex(); };
	bool operator <(CRegister registerToCompare) { return index < registerToCompare.getIndex(); };

protected:
	RegisterType type;
	float value;

private:


};

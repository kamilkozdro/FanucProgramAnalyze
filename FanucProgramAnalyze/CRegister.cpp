#include "CRegister.h"

CRegister::CRegister()
{
	index = 0;
	comment = "";
	type = RegisterType::Register;
	value = 0;
}

CRegister::CRegister(unsigned int newIndex, RegisterType newType, std::string newComment)
{
	type = newType;
	index = newIndex;
	comment = newComment;
}

CRegister::CRegister(unsigned int newIndex, std::string newComment)
{
	type = RegisterType::Register;
	index = newIndex;
	comment = newComment;
}

std::string CRegister::getTypeString(CRegister::RegisterType typeToGet)
{
	switch (typeToGet)
	{
	case RegisterType::Register:
		return "Register";
	case RegisterType::PositionRegister:
		return "PositionRegister";
	default:
		return "";
	}
}

std::vector<CRegister::RegisterType> CRegister::getAllRegisterTypes()
{
	std::vector<RegisterType> registerTypes =
	{
		RegisterType::Register, RegisterType::PositionRegister
	};
	return registerTypes;
}

std::vector<std::string> CRegister::getAllRegisterTypesString()
{
	std::vector<std::string> registerTypesStrings;
	for (RegisterType singleType : getAllRegisterTypes())
	{
		registerTypesStrings.push_back(getTypeString(singleType));
	}
	return registerTypesStrings;
}

std::string CRegister::getTypeKeyword(CRegister::RegisterType typeToGet)
{
	switch (typeToGet)
	{
	case RegisterType::Register:
		return "R";
	case RegisterType::PositionRegister:
		return "PR";
	default:
		return "";
	}
}

void CRegister::printInfo()
{
	std::cout << getTypeString()
		<< "[" << getIndex()
		<< ":" << getComment() << "]\n";
}

bool CRegister::operator ==(CRegister registerToCompare)
{
	if (index == registerToCompare.getIndex()
		&& type == registerToCompare.getType())
		return true;
	else
		return false;
}


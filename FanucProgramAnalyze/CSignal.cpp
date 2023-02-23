#include "CSignal.h"

CSignal::CSignal()
{
	type = Type::None;
}

CSignal::CSignal(unsigned int newIndex, Type newType, IO newIO, std::string newComment)
{
	type = newType;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

std::string CSignal::getTypeString(Type typeToGet)
{
	switch (typeToGet)
	{
	case Type::Digital:
		return "Digital";
	case Type::Analog:
		return "Analog";
	case Type::Group:
		return "Group";
	case Type::Robot:
		return "Robot";
	case Type::Flag:
		return "Flag";
	case Type::UOP:
		return "UOP";
	case Type::SOP:
		return "SOP";
	default:
		return "None";
	}
}

std::vector<CSignal::Type> CSignal::getAllTypes()
{
	std::vector<Type> signalsTypes =
	{
		Type::Digital, Type::Analog, Type::Group,
		Type::Robot, Type::Flag, Type::UOP, Type::SOP,
		Type::None
	};
	return signalsTypes;
}

std::vector<std::string> CSignal::getAllTypesString()
{
	std::vector<std::string> signalTypesStrings;
	for (CSignal::Type singleType : CSignal::getAllTypes())
	{
		signalTypesStrings.push_back(CSignal::getTypeString(singleType));
	}
	return signalTypesStrings;
}

std::string CSignal::getTypeKeyword(Type typeToGet)
{
	switch (typeToGet)
	{
	case Type::Digital:
		return "D";
	case Type::Analog:
		return "A";
	case Type::Group:
		return "G";
	case Type::Robot:
		return "R";
	case Type::Flag:
		return "F";
	case Type::UOP:
		return "U";
	case Type::SOP:
		return "S";
	default:
		return "";
	}

}

std::string CSignal::getIOString()
{
	switch (io)
	{
	case IO::Input:
		return "Input";
	case IO::Output:
		return "Output";
	default:
		return "None";
	}
}

std::vector<CSignal::IO> CSignal::getAllIO()
{
	std::vector<IO> signalIOs =
	{
		IO::Input, IO::Output, IO::None
	};
	return signalIOs;
}

std::string CSignal::getIOKeyword(IO ioToGet)
{
	switch (ioToGet)
	{
	case IO::Input:
		return "I";
	case IO::Output:
		return "O";
	default:
		return "";
	}
}

void CSignal::printInfo()
{
	std::cout << getTypeString()
		<< " " << getIOString()
		<< " " << getIndex()
		<< " " << getComment() << "\n";
}


bool CSignal::operator == (CSignal signalToCompare)
{
	if (index == signalToCompare.getIndex()
		&& type == signalToCompare.getType()
		&& io == signalToCompare.getIO())
		return true;
	else
		return false;
}


CSignalDigital::CSignalDigital(unsigned int newIndex, IO newIO, std::string newComment = "")
{
	type = Type::Digital;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalAnalog::CSignalAnalog(unsigned int newIndex, IO newIO, std::string newComment = "")
{
	type = Type::Analog;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalGroup::CSignalGroup(unsigned int newIndex, IO newIO, std::string newComment = "")
{
	type = Type::Group;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalRobot::CSignalRobot(unsigned int newIndex, IO newIO, std::string newComment = "")
{
	type = Type::Robot;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalFlag::CSignalFlag(unsigned int newIndex, IO newIO, std::string newComment = "")
{
	type = Type::Flag;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalUOP::CSignalUOP(unsigned int newIndex, IO newIO, std::string newComment = "")
{
	type = Type::UOP;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalSOP::CSignalSOP(unsigned int newIndex, IO newIO, std::string newComment = "")
{
	type = Type::SOP;
	index = newIndex;
	io = newIO;
	comment = newComment;
}
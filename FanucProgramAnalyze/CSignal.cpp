#include "CSignal.h"

CSignal::CSignal()
{
	type = SignalType::None;
}

CSignal::CSignal(unsigned int newIndex, SignalType newType, SignalIO newIO, std::string newComment)
{
	type = newType;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

std::string CSignal::getTypeString(SignalType typeToGet)
{
	switch (typeToGet)
	{
	case SignalType::Digital:
		return "Digital";
	case SignalType::Analog:
		return "Analog";
	case SignalType::Group:
		return "Group";
	case SignalType::Robot:
		return "Robot";
	case SignalType::Flag:
		return "Flag";
	case SignalType::UOP:
		return "UOP";
	case SignalType::SOP:
		return "SOP";
	default:
		return "None";
	}
}

std::vector<CSignal::SignalType> CSignal::getAllSignalTypes()
{
	std::vector<SignalType> signalsTypes =
	{
		SignalType::Digital, SignalType::Analog, SignalType::Group,
		SignalType::Robot, SignalType::Flag, SignalType::UOP, SignalType::SOP,
		SignalType::None
	};
	return signalsTypes;
}

std::vector<std::string> CSignal::getAllSignalTypesString()
{
	std::vector<std::string> signalTypesStrings;
	for (SignalType singleType : getAllSignalTypes())
	{
		signalTypesStrings.push_back(getTypeString(singleType));
	}
	return signalTypesStrings;
}

std::string CSignal::getTypeKeyword(SignalType typeToGet)
{
	switch (typeToGet)
	{
	case SignalType::Digital:
		return "D";
	case SignalType::Analog:
		return "A";
	case SignalType::Group:
		return "G";
	case SignalType::Robot:
		return "R";
	case SignalType::Flag:
		return "F";
	case SignalType::UOP:
		return "U";
	case SignalType::SOP:
		return "S";
	default:
		return "";
	}

}

std::string CSignal::getIOString()
{
	switch (io)
	{
	case SignalIO::Input:
		return "Input";
	case SignalIO::Output:
		return "Output";
	default:
		return "None";
	}
}

std::vector<CSignal::SignalIO> CSignal::getAllIO()
{
	std::vector<SignalIO> signalIOs =
	{
		SignalIO::Input, SignalIO::Output, SignalIO::None
	};
	return signalIOs;
}

std::string CSignal::getIOKeyword(SignalIO ioToGet)
{
	switch (ioToGet)
	{
	case SignalIO::Input:
		return "I";
	case SignalIO::Output:
		return "O";
	default:
		return "";
	}
}

void CSignal::printInfo()
{
	std::cout << getTypeString()
		<< "" << getIOString()
		<< "[" << getIndex()
		<< ":" << getComment() << "]\n";
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


CSignalDigital::CSignalDigital(unsigned int newIndex, SignalIO newIO, std::string newComment = "")
{
	type = SignalType::Digital;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalAnalog::CSignalAnalog(unsigned int newIndex, SignalIO newIO, std::string newComment = "")
{
	type = SignalType::Analog;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalGroup::CSignalGroup(unsigned int newIndex, SignalIO newIO, std::string newComment = "")
{
	type = SignalType::Group;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalRobot::CSignalRobot(unsigned int newIndex, SignalIO newIO, std::string newComment = "")
{
	type = SignalType::Robot;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalFlag::CSignalFlag(unsigned int newIndex, SignalIO newIO, std::string newComment = "")
{
	type = SignalType::Flag;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalUOP::CSignalUOP(unsigned int newIndex, SignalIO newIO, std::string newComment = "")
{
	type = SignalType::UOP;
	index = newIndex;
	io = newIO;
	comment = newComment;
}

CSignalSOP::CSignalSOP(unsigned int newIndex, SignalIO newIO, std::string newComment = "")
{
	type = SignalType::SOP;
	index = newIndex;
	io = newIO;
	comment = newComment;
}
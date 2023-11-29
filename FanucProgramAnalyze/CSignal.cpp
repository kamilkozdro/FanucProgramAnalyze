#include "CSignal.h"

CSignal::CSignal()
{
	index = 0;
	comment = "";
	type = SignalType::F;
}

CSignal::CSignal(unsigned int newIndex, SignalType newType, std::string newComment)
{
	type = newType;
	index = newIndex;
	comment = newComment;
}

std::string CSignal::getTypeString(SignalType typeToGet)
{
	switch (typeToGet)
	{
	case SignalType::DI:
		return "DI";
	case SignalType::DO:
		return "DO";
	case SignalType::AI:
		return "AI";
	case SignalType::AO:
		return "AO";
	case SignalType::RI:
		return "RI";
	case SignalType::RO:
		return "RO";
	case SignalType::GI:
		return "GI";
	case SignalType::GO:
		return "GO";
	case SignalType::F:
		return "F";
	case SignalType::UOP:
		return "UOP";
	case SignalType::SOP:
		return "SOP";
	default:
		return "";
	}
}

std::vector<CSignal::SignalType> CSignal::getAllSignalTypes()
{
	std::vector<SignalType> signalsTypes =
	{
		SignalType::DI, SignalType::DO,
		SignalType::AI, SignalType::AO,
		SignalType::RI, SignalType::RO,
		SignalType::GI, SignalType::GO,
		SignalType::F,
		SignalType::UOP, SignalType::SOP
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

void CSignal::printInfo()
{
	std::cout << getTypeString()
		<< "[" << getIndex()
		<< ":" << getComment() << "]\n";
}


bool CSignal::operator == (CSignal signalToCompare)
{
	if (index == signalToCompare.getIndex()
		&& type == signalToCompare.getType())
		return true;
	else
		return false;
}

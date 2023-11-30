#pragma once
#include <iostream>
#include <vector>
#include "CIndexed.h"

class CSignal : public CIndexed
{
public:
	enum class SignalType { DI, DO, AI, AO, GI, GO, 
		RI, RO, F , UOP, SOP};

	CSignal(unsigned int newIndex, SignalType newType, std::string newComment = "");

	void setType(SignalType newType) { type = newType; };
	SignalType getType() { return type; };
	static std::string getTypeString(SignalType typeToGet);
	std::string getTypeString() { return getTypeString(type); };
	static std::vector<SignalType> getAllSignalTypes();
	static std::vector<std::string> getAllSignalTypesString();
	void virtual printInfo();

	bool operator ==(CSignal signalToCompare);
	bool operator >(CSignal signalToCompare) { return index > signalToCompare.getIndex(); };
	bool operator <(CSignal signalToCompare) { return index < signalToCompare.getIndex(); };

private:

protected:
	SignalType type;

};
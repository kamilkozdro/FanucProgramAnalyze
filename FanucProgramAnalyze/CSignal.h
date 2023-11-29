#pragma once
#include <iostream>
#include <vector>

class CSignal
{
public:
	enum class SignalType { DI, DO, AI, AO, GI, GO, 
		RI, RO, F , UOP, SOP};

	CSignal();
	CSignal(unsigned int newIndex, SignalType newType, std::string newComment);

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
	void virtual printInfo();

	bool operator ==(CSignal signalToCompare);

private:

protected:
	unsigned int index;
	SignalType type;
	std::string comment;

};
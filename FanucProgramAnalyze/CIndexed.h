#pragma once
#include <string>
#include <iostream>
class CIndexed
{
	public:

		CIndexed();
		void setIndex(unsigned int newIndex) { index = newIndex; };
		unsigned int getIndex() { return index; };
		void setComment(std::string newComment) { comment = newComment; };
		std::string getComment() { return comment; };
		virtual void printInfo();

	protected:
		unsigned int index;
		std::string comment;


};


#include "CPositionRegister.h"

CPositionRegister::CPositionRegister(unsigned int newIndex, CPoint newPosition, std::string newComment)
{
	type = RegisterType::PositionRegister;
	index = newIndex;
	comment = newComment;
	position = newPosition;
}

CPositionRegister::CPositionRegister(unsigned int newIndex, std::string newComment)
{
	type = RegisterType::PositionRegister;
	index = newIndex;
	comment = newComment;
}
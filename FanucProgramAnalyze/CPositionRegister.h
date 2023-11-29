#pragma once
#include "CRegister.h"

class CPositionRegister : public CRegister
{
public:
	CPositionRegister(unsigned int newIndex, CPoint newPosition, std::string newComment);
	CPositionRegister(unsigned int newIndex, std::string newComment);
protected:

private:
	CPoint position;
};


#include "CIndexed.h"

CIndexed::CIndexed()
{
	index = 0;
	comment = "";
}

void CIndexed::printInfo()
{
	std::cout << "Index:" << index << " Komentarz:" << comment << std::endl;
}

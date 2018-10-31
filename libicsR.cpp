// libicsR.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include <malloc.h>
#include "libics.h"

extern "C" {

	/*
	Ics_2D16_getDims

	Get the dimensions of a 2D 16-bit unsigned image. Also checks for the correct type.
	Use the returned size to allocate a vector for the data.

	\param file Path to file to open. R passes a vector of strings, use the first element.
	\param width To return the image width.
	\param height To return the image height.
	\param ret A return value to pass back to R. -ve = an error, 0 = no error.
	
	*/

	__declspec(dllexport) void Ics_2D16_getDims(char **file, int *width, int *height, int *ret)
	{
		ICS *ics;
		Ics_Error err;
		Ics_DataType dt;
		int          nDims;
		size_t       dims[ICS_MAXDIM];
		
		err = IcsOpen(&ics, file[0], "r");

		if (err != IcsErr_Ok) {
			*ret = -1;
			return;
		}

		IcsGetLayout(ics, &dt, &nDims, dims);

		if(dt != Ics_uint16) {
			*ret = -2;
			return;
		}

		if (nDims != 2) {
			*ret = -3;
			return;
		}

		*width = dims[0];
		*height = dims[1];
		*ret = 0;

		IcsClose(ics);
	}


	/*
	Ics_2D16_getData

	Get the data of a 2D 16-bit unsigned image.
	Use Ics_2D16_getDims to get the size of the data.

	\param file Path to file to open. R passes a vector of strings, use the first element.
	\param data To return the image data. Must be correct size
	\param size The size of the data in number of elements.
	\param ret A return value to pass back to R. -ve = an error, 0 = no error.

	*/

	__declspec(dllexport) void Ics_2D16_getData(char **file, int *data, int *size, int *ret)
	{
		ICS *ics;
		Ics_Error err;
		
		err = IcsOpen(&ics, file[0], "r");

		if (err != IcsErr_Ok) {
			*ret = -1;
			return;
		}

		USHORT *file_bytes = (USHORT *)malloc(*size * sizeof(USHORT));

		if (!file_bytes) {
			*ret = -2;
			return;
		}

		IcsGetData(ics, file_bytes, *size * sizeof(USHORT));

		// Copy the data into the R vector, NB 16-bit unsigned numbers
		for (int i = 0; i < *size; i++) {
			data[i] = file_bytes[i];
		}

		*ret = 0;

		free(file_bytes);
		IcsClose(ics);
	}


}


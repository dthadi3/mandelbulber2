/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * rotatedAbs & Rotated Folding transform from M3D
 * - Rotate by the given angles
 *- fold
 *- RotateBack by the given angles
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_rotation_folding.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfRotationFoldingIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	if (fractal->transformCommon.functionEnabled)
	{
		if (fractal->transformCommon.functionEnabledx)
			z.x = fabs(z.x + fractal->transformCommon.offset000.x) - fractal->transformCommon.offset000.x;
		if (fractal->transformCommon.functionEnabledy)
			z.y = fabs(z.y + fractal->transformCommon.offset000.y) - fractal->transformCommon.offset000.y;
		if (fractal->transformCommon.functionEnabledz)
			z.z = fabs(z.z + fractal->transformCommon.offset000.z) - fractal->transformCommon.offset000.z;
	}

	if (fractal->transformCommon.functionEnabledAyFalse)
	{
		if (fractal->transformCommon.functionEnabledAx)
			z.x = fabs(z.x + fractal->transformCommon.offset111.x)
						- fabs(z.x - fractal->transformCommon.offset111.x) - z.x;
		if (fractal->transformCommon.functionEnabledAy)
			z.y = fabs(z.y + fractal->transformCommon.offset111.y)
						- fabs(z.y - fractal->transformCommon.offset111.y) - z.y;
		if (fractal->transformCommon.functionEnabledAz)
			z.z = fabs(z.z + fractal->transformCommon.offset111.z)
						- fabs(z.z - fractal->transformCommon.offset111.z) - z.z;
	}

	if (fractal->transformCommon.functionEnabledAzFalse)
	{
		if (fractal->transformCommon.functionEnabledBx)
		{
			if (fabs(z.x) > fractal->mandelbox.foldingLimit)
			{
				z.x = sign(z.x) * fractal->mandelbox.foldingValue - z.x;
				// aux->color += fractal->mandelbox.color.factor.x;
			}
		}
		if (fractal->transformCommon.functionEnabledBy)
		{
			if (fabs(z.y) > fractal->mandelbox.foldingLimit)
			{
				z.y = sign(z.y) * fractal->mandelbox.foldingValue - z.y;
				// aux->color += fractal->mandelbox.color.factor.y;
			}
		}
		if (fractal->transformCommon.functionEnabledBz)
		{
			REAL zLimit = fractal->mandelbox.foldingLimit * fractal->transformCommon.scale1;
			REAL zValue = fractal->mandelbox.foldingValue * fractal->transformCommon.scale1;
			if (fabs(z.z) > zLimit)
			{
				z.z = sign(z.z) * zValue - z.z;
				// aux->color += fractal->mandelbox.color.factor.z;
			}
		}
	}
	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix2, z);
	return z;
}
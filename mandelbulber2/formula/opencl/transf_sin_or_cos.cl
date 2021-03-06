/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * sin or cos z

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_sin_or_cos.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSinOrCosIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 oldZ = z;
	REAL4 trigZ = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
	REAL4 scaleZ = z * fractal->transformCommon.constantMultiplierC111;

	if (fractal->transformCommon.functionEnabledAx)
	{
		if (!fractal->transformCommon.functionEnabledAxFalse)
			trigZ.x = native_sin(scaleZ.x);
		else
			trigZ.x = native_cos(scaleZ.x); // scale =0, cos = 1
	}
	if (fractal->transformCommon.functionEnabledAy)
	{
		if (!fractal->transformCommon.functionEnabledAyFalse)
			trigZ.y = native_sin(scaleZ.y);
		else
			trigZ.y = native_cos(scaleZ.y);
	}
	if (fractal->transformCommon.functionEnabledAz)
	{
		if (!fractal->transformCommon.functionEnabledAzFalse)
			trigZ.z = native_sin(scaleZ.z);
		else
			trigZ.z = native_cos(scaleZ.z);
	}

	z = trigZ * fractal->transformCommon.scale;
	if (fractal->transformCommon.functionEnabledFalse)
	{
		z.x = z.x * fractal->transformCommon.scale / (fabs(oldZ.x) + 1.0f);
		z.y = z.y * fractal->transformCommon.scale / (fabs(oldZ.y) + 1.0f);
		z.z = z.z * fractal->transformCommon.scale / (fabs(oldZ.z) + 1.0f);
		// aux->DE = aux->DE * length(z) / length(oldZ);
	}
	//   if z == oldZ    z = oldZ * fractal->transformCommon.scale;
	if (!fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fabs(fractal->transformCommon.scale) + 1.0f;
	else
		aux->DE = aux->DE * fabs(fractal->transformCommon.scale) * fractal->analyticDE.scale1
							+ fractal->analyticDE.offset1;
	return z;
}
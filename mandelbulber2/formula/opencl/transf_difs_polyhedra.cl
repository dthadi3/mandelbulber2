/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * TransfDIFSPrismIteration  fragmentarium code, mdifs by knighty (jan 2012)
 * and http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_difs_prism.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSPolyhedraIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	int Type = fractal->transformCommon.int3;
	// U 'barycentric' coordinate for the 'principal' node
	REAL U = fractal->transformCommon.constantMultiplier100.x;
	REAL V = fractal->transformCommon.constantMultiplier100.y;
	REAL W = fractal->transformCommon.constantMultiplier100.z;
	// vertex radius
	REAL VRadius = fractal->transformCommon.offset01;
	// segments radius
	REAL SRadius = fractal->transformCommon.offsetp05;

	// this block does not use z so could be inline precalc
	REAL cospin = M_PI / (REAL)(Type);
	cospin = cos(cospin);
	REAL scospin = sqrt(0.75 - cospin * cospin);
	REAL4 nc = (REAL4)(-0.5, -cospin, scospin, 0.0);
	REAL4 pab = (REAL4)(0.0, 0.0, 1.0, 0.0);
	REAL4 pbc = normalize((REAL4)(scospin, 0.0, 0.5, 0.0));
	REAL4 pca = normalize((REAL4)(0.0, scospin, cospin, 0.0));
	REAL4 p = normalize(U * pab + V * pbc + W * pca);

	REAL d = 10000.0;
	REAL4 colVec = (REAL4)(1000.0, 1000.0, 1000.0, 1000.0);
	REAL4 zc = z * fractal->transformCommon.scale1;
	aux->DE = aux->DE * fractal->transformCommon.scale1;

	for (int n = 0; n < Type; n++)
	{
		zc.xy = fabs(zc.xy);
		REAL t = -2.0 * min(0.0, dot(zc, nc));
		zc += t * nc;
	}

	REAL4 zcv = zc;

	if (!fractal->transformCommon.functionEnabledBxFalse)
	{ // faces
		REAL d0 = dot(zc, pab) - dot(pab, p);
		REAL d1 = dot(zc, pbc) - dot(pbc, p);
		REAL d2 = dot(zc, pca) - dot(pca, p);
		REAL df = max(max(d0, d1), d2);
		colVec.x = df;
		d = min(d, df);
	}

	if (!fractal->transformCommon.functionEnabledByFalse)
	{ // Segments
		zc -= p;
		REAL dla = length(zc - min(0.0, zc.x) * (REAL4)(1.0, 0.0, 0.0, 0.0));
		REAL dlb = length(zc - min(0.0, zc.y) * (REAL4)(0.0, 1.0, 0.0, 0.0));
		REAL dlc = length(zc - min(0.0, dot(zc, nc)) * nc);
		REAL ds = min(min(dla, dlb), dlc) - SRadius;
		colVec.y = ds;
		d = min(d, ds);
	}

	if (!fractal->transformCommon.functionEnabledBzFalse)
	{ // Vertices
		REAL dv;
		if (!fractal->transformCommon.functionEnabledDFalse)
		{
			dv = length(zcv - p) - VRadius;
		}
		else
		{
			REAL4 ff = fabs(zcv - p);
			dv = max(max(ff.x, ff.y), ff.z) - VRadius;
		}
		colVec.z = dv;
		d = min(d, dv);
	}

	aux->dist = min(aux->dist, d) / aux->DE;
	if (fractal->transformCommon.functionEnabledzFalse) z = zc;

	if (fractal->foldColor.auxColorEnabled)
	{
		colVec.x *= fractal->foldColor.difs0000.x;
		colVec.y *= fractal->foldColor.difs0000.y;
		colVec.z *= fractal->foldColor.difs0000.z;
		if (!fractal->foldColor.auxColorEnabledFalse)
		{
			REAL colorAdd = 0.0;
			colorAdd += colVec.x;
			colorAdd += colVec.y;
			colorAdd += colVec.z;
			// colorAdd += colVec.w;
			aux->color = colorAdd * 256.0;
		}
		else
		{
			aux->color = min(min(colVec.x, colVec.y), colVec.z)
				* fractal->foldColor.difs1 * 1024.0;
		}
	}
	return z;
}

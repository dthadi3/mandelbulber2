/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * JosLeys-Kleinian V3 formula
 * @reference
 * http://www.fractalforums.com/3d-fractal-generation/an-escape-tim-algorithm-for-kleinian-group-limit-sets/msg98248/#msg98248
 * This formula contains aux.color and aux.DE

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_jos_kleinian_v2.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 JosKleinianV3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// polyfold
	if (fractal->transformCommon.functionEnabledPFalse
			&& aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP1)
	{
		// pre abs
		if (fractal->transformCommon.functionEnabledx) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledy) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledz) z.z = fabs(z.z);

		if (fractal->transformCommon.functionEnabledCx)
		{
			REAL psi = M_PI_F / fractal->transformCommon.int8X;
			psi = fabs(fmod(atan2(z.y, z.x) + psi, 2.0f * psi) - psi);
			REAL len = native_sqrt(z.x * z.x + z.y * z.y);
			z.x = native_cos(psi) * len;
			z.y = native_sin(psi) * len;
		}

		if (fractal->transformCommon.functionEnabledCyFalse)
		{
			REAL psi = M_PI_F / fractal->transformCommon.int8Y;
			psi = fabs(fmod(atan2(z.z, z.y) + psi, 2.0f * psi) - psi);
			REAL len = native_sqrt(z.y * z.y + z.z * z.z);
			z.y = native_cos(psi) * len;
			z.z = native_sin(psi) * len;
		}

		if (fractal->transformCommon.functionEnabledCzFalse)
		{
			REAL psi = M_PI_F / fractal->transformCommon.int8Z;
			psi = fabs(fmod(atan2(z.x, z.z) + psi, 2.0f * psi) - psi);
			REAL len = native_sqrt(z.z * z.z + z.x * z.x);
			z.z = native_cos(psi) * len;
			z.x = native_sin(psi) * len;
		}
		z += fractal->transformCommon.offsetF000;
	}

	// sphere inversion
	if (fractal->transformCommon.sphereInversionEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD1)
	{
		REAL rr = 1.0f;
		z += fractal->transformCommon.offset000;
		rr = dot(z, z);
		z *= fractal->transformCommon.maxR2d1 / rr;
		z += fractal->transformCommon.additionConstant000 - fractal->transformCommon.offset000;
		z *= fractal->transformCommon.scaleA1;
		aux->DE *= (fractal->transformCommon.maxR2d1 / rr) * fractal->analyticDE.scale1
							 * fractal->transformCommon.scaleA1;
	}

	if (fractal->transformCommon.functionEnabledCyFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC1)
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
	}

	if (fractal->transformCommon.functionEnabledJFalse
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		if (z.z > z.x)
		{
			REAL temp = z.x;
			z.x = z.z;
			z.z = temp;
		}
	}

	// kleinian
	if (aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
	{
		REAL a = fractal->transformCommon.foldingValue;
		REAL b = fractal->transformCommon.offset;
		//REAL c = fractal->transformCommon.offsetA0;
		REAL f = sign(b);

		// wrap
		REAL4 box_size = fractal->transformCommon.offset111;
		//REAL3 box1 = (REAL3){2.0f * box_size.x, a * box_size.y, 2.0f * box_size.z};
		//REAL3 box2 = (REAL3){-box_size.x, -box_size.y + 1.0f, -box_size.z};
		//REAL3 wrapped = wrap(z.xyz, box1, box2);

		//z = (REAL4){wrapped.x, wrapped.y, wrapped.z, z.w};
		{
			z.x += box_size.x;
			z.y += box_size.y;
			z.x = z.x - 2.0f * box_size.x * floor(z.x / 2.0f * box_size.x) - box_size.x;
			z.y = z.y - 2.0f * box_size.y * floor(z.y / 2.0f * box_size.y) - box_size.y;
			z.z += box_size.z - 1.0f;
			z.z = z.z - a * box_size.z * floor(z.z / a * box_size.z);
			z.z -= (box_size.z - 1.0f);
		}

		if (z.z >= a * (0.5f + 0.2f * native_sin(f * M_PI_F * (z.x + b * 0.5f) / box_size.x)))
		{
			z.x = -z.x - b;
			z.z = -z.z + a;
			//z.z = -z.z - c;
		}

		REAL rr = dot(z, z);

		REAL4 colorVector = (REAL4){z.x, z.y, z.z, rr};
		aux->color = min(aux->color, length(colorVector)); // For coloring

		REAL iR = 1.0f / rr;
		z *= -iR; // invert and mirror
		z.x = -z.x - b;
		z.z = a + z.z;
		//z.z = -z.z - c;

		aux->DE *= fabs(iR);
	}

	if (fractal->transformCommon.functionEnabledEFalse
			&& aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		z.z = sign(z.z)
					* (fractal->transformCommon.offset1 - fabs(z.z)
						 + fabs(z.z) * fractal->transformCommon.scale0);
	}

	REAL Ztemp = z.z;
	if (fractal->transformCommon.spheresEnabled)
		Ztemp = min(z.z, fractal->transformCommon.foldingValue - z.z);
	aux->dist = min(Ztemp, fractal->analyticDE.tweak005) / max(aux->DE, fractal->analyticDE.offset1);

	return z;
}

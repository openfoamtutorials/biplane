Include "SingleBendAirfoil.geo";
Include "WindTunnel.geo";
Include "parameters.geo";

// Units are multiples of chord.

ce = 0;

Arguments[] = {aoa2, bendHeight, bendLocation, thickness, AirfoilLc, biplaneStagger, -biplaneGap};
Call SingleBendAirfoil;
AirfoilLoop2 = Results[0];

Arguments[] = {aoa1, bendHeight, bendLocation, thickness, AirfoilLc, 0, 0};
Call SingleBendAirfoil;
AirfoilLoop = Results[0];

WindTunnelHeight = 20;
WindTunnelLength = 40;
WindTunnelLc = 3;
Call WindTunnel;

Surface(ce++) = {WindTunnelLoop, AirfoilLoop, AirfoilLoop2};
TwoDimSurf = ce - 1;

cellDepth = 0.1;

ids[] = Extrude {0, 0, cellDepth}
{
	Surface{TwoDimSurf};
	Layers{1};
	Recombine;
};

Physical Surface("outlet") = {ids[2]};
Physical Surface("walls") = {ids[{3, 5}]};
Physical Surface("inlet") = {ids[4]};
Physical Surface("airfoil") = {ids[{6:23}]};
Physical Surface("frontAndBack") = {ids[0], TwoDimSurf};
Physical Volume("volume") = {ids[1]};


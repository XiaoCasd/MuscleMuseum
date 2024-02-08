classdef OpticalLattice < OpticalPotential
    %OPTICALLATTICE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        DepthKd
        DepthSpec
        RadialFrequencySlosh
    end

    properties (Dependent)
        LatticeSpacing % in meters
        Depth % in Hz, calculated from laser power and waists
        AxialFrequency % in Hz, linear frequency, calculated from laser power and waists
        AxialFrequencyKd % in Hz, linear frequency, calculated from KD depth
        AxialFrequencySpec % in Hz, linear frequency, calculated from spectrum depth
        RadialFrequency % in Hz, linear frequency, calculated from laser power and waists
        RadialFrequencyKd % in Hz, linear frequency, calculated from KD depth
        RadialFrequencySpec % in Hz, linear frequency, calculated from spectrum depth
    end

    methods
        function obj = OpticalLattice(atom,laser,name)
            %OPTICALLATTICE Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                atom (1,1) Atom
                laser (1,1) Laser
                name string = string.empty
            end
            obj@OpticalPotential(atom,laser,name);
        end

        function a0 = get.LatticeSpacing(obj)
            a0 = obj.Laser.Wavelength / 2;
        end

        function v0 = get.Depth(obj)
            v0 =  4 * abs(obj.ScalarPolarizabilityGround * abs(obj.Laser.ElectricFieldAmplitude)^2 / 4);
        end

        function fZ = get.AxialFrequency(obj)
            fZ = obj.computeAxialFrequency(obj.Depth);
        end

        function fZ = get.AxialFrequencyKd(obj)
            fZ = obj.computeAxialFrequency(obj.DepthKd);
        end

        function fZ = get.AxialFrequencySpec(obj)
            fZ = obj.computeAxialFrequency(obj.DepthSpec);
        end

        function fRho = get.RadialFrequency(obj)
            fRho = obj.computeRadialFrequency(obj.Depth);
        end

        function fRho = get.RadialFrequencyKd(obj)
            fRho = obj.computeRadialFrequency(obj.DepthKd);
        end

        function fRho = get.RadialFrequencySpec(obj)
            fRho = obj.computeRadialFrequency(obj.DepthSpec);
        end
        
        function fZ = computeAxialFrequency(obj,depth)
            lambda = obj.Laser.Wavelength;
            m = obj.Atom.mass;
            v0 =  2 * pi * Constants.SI("hbar") * depth;
            fZ = sqrt(v0 / m / lambda^2);
        end

        function fRho = computeRadialFrequency(obj,depth)
            if class(obj.Laser) == "GaussianBeam"
                w0 = sqrt(prod(obj.Laser.Waist));
                m = obj.Atom.mass;
                v0 = 2 * pi * Constants.SI("hbar") * depth;
                fRho = sqrt(4 * v0 / m / w0^2) / 2 / pi;
            else
                fRho = NaN;
            end
        end

    end
end


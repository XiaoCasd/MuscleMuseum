classdef OpticalLattice < OpticalPotential
    %OPTICALLATTICE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Dependent)
        LatticeSpacing % in meters
        Depth % in Hz
        AxialFrequency % in Hz, linear frequency
        RadialFrequency % in Hz, linear frequency
    end
    
    methods
        function obj = OpticalLattice(atom,laser)
            %OPTICALLATTICE Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                atom (1,1) Atom
                laser (1,1) Laser
            end
            obj@OpticalPotential(atom,laser);
        end

        function a0 = get.LatticeSpacing(obj)
            a0 = obj.Laser.Wavelength / 2;
        end

        function v0 = get.Depth(obj)
            v0 =  4 * abs(obj.ScalarPolarizabilityGround * abs(obj.Laser.ElectricFieldAmplitude)^2 / 4);
        end
        
        function fRho = get.RadialFrequency(obj)
            if class(obj.Laser) == "GaussianBeam"
                w0 = sqrt(prod(obj.Laser.Waist));
                m = obj.Atom.mass;
                v0 = 2 * pi * Constants.SI("hbar") * obj.Depth;
                fRho = sqrt(4 * v0 / m / w0^2) / 2 / pi;
            else
                fRho = NaN;
            end
        end

        function fZ = get.AxialFrequency(obj)
            lambda = obj.Laser.Wavelength;
            m = obj.Atom.mass;
            v0 =  2 * pi * Constants.SI("hbar") * obj.Depth;
            fZ = sqrt(v0 / m / lambda^2);
        end

    end
end


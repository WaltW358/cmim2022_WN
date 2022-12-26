function sys = add_force_single(sys,body, F, location)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    arguments
        sys (1,1) struct
        body (1,1) string
        F (3,1) = [0;0;0];
        location (2,1) double = [0;0];
    end
    check_body_exists(sys, body)

    force = struct();
    force.body_i_qidx = body_name_to_qidx(sys, body);
    force.F = F;
    force.location = location; 

    sys.forces.external = [sys.forces.external, force];

    
end
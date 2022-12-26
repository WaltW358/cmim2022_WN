function sys = add_force_torsional_spring(sys,body_i, body_j, kn, cn,fi)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    arguments
        sys (1,1) struct
        body_i (1,1) string
        body_j (1,1) string
        kn (1,1) double = 0;
        cn (1,1) double = 0;
        fi (1,1) double = 0;
    end
    check_body_exists(sys, body_i)
    check_body_exists(sys, body_j)

    force = struct();
    force.body_i_qidx = body_name_to_qidx(sys, body_i);
    force.body_j_qidx = body_name_to_qidx(sys, body_j);
    force.kn = kn;
    force.cn = cn;
    force.fi = fi;

    sys.forces.internal = [sys.forces.internal, force];

    
end
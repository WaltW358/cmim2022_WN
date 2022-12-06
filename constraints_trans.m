function C = constraints_trans(sys, q)
%CONSTRAINTS_REVOLUTE Compute constraints for the revolute joints
C = zeros(2 * length(sys.joints.trans), 1);
c_id = 1;

for j = sys.joints.trans

    
    qi = q(j.body_i_qidx);
    qj = q(j.body_j_qidx);
    Ai = rot(qi(3));
    Aj = rot(qj(3));
    Pi = qi(1:2) + Ai *j.s_i_p;
    Pj = qj(1:2) + Aj *j.s_j_p;
    Qi = qi(1:2) + Ai *j-s_i_q;

    

    C(c_id) = (Pi(1) - Qi(1))*(Pj(2) - Pi(2)) - (Pi(2) - Qi(2)) * (Pj(1) - Pi(1));
    C(c_id + 1) = qi(c_id) - qj(c_id+3) - (j.fi_i_0 - fi_j_0);



    C(c_id + (1:2)) = qi(1:2) + Ai * j.s_i ...
        - qj(1:2) - Aj * j.s_j;
    c_id = c_id + 2;
end

end


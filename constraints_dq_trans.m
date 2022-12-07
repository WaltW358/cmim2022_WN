function Cq = constraints_dq_trans(sys, q)
%CONSTRAINTS_REVOLUTE Compute constraints for the revolute joints
Cq = zeros(2 * length(sys.joints.trans), length(q));
c_id = 1;


for j = sys.joints.trans
    qi = q(j.body_i_qidx);
    qj = q(j.body_j_qidx);
    Ai = rot(qi(3));
    Aj = rot(qj(3));
    Pi = qi(1:2) + Ai *j.s_i;
    Pj = qj(1:2) + Aj *j.s_j;
    Qi = qi(1:2) + Ai *j.s_i_q;


    Cq(c_id,j.body_i_qidx(1)) = Pi(2) -Qi(2);
    Cq(c_id,j.body_i_qidx(2)) = Qi(1) -Pi(1);
    Cq(c_id,j.body_i_qidx(3)) = 0;

    Cq(c_id+1, j.body_i_qidx(1)) = 0;
    Cq(c_id+1, j.body_i_qidx(2)) = 0;
    Cq(c_id+1, j.body_i_qidx(3)) = 1;

    Cq(c_id, j.body_j_qidx(1)) = Qi(2) - Pi(2);
    Cq(c_id, j.body_j_qidx(2)) = Pi(1) - Qi(1);
    Cq(c_id, j.body_j_qidx(2)) = 0;

    Cq(c_id,j.body_j_qidx(1)) = 0;
    Cq(c_id,j.body_j_qidx(2)) = 0;
    Cq(c_id,j.body_j_qidx(3)) = -1;



% 
%     Cq(c_id + (1:2), j.body_i_qidx) = -[(j.s_i - j.s_i_q)'* Aj'*I, (j.s_i - j.s_i_q)'*I*j.s_j;zeros(1,2),1];
%     Cq(c_id + (1:2), j.body_j_qidx) = [(j.s_i - j.s_i_q)'*Aj'*I, (j.s_i - j.s_i_q)'*Aj'*O*Ai*(j.fi_j_0)*j.s_j;zeros(1,2),1];
    c_id = c_id + 2;
end

end


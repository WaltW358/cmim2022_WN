function sys = add_joint_trans(sys, body_i, ...
    body_j, s_i_p, s_i_q, s_j_p )


    arguments
        sys (1,1) struct
        body_i (1,1) string
        body_j (1,1) string
        s_i_p (2,1) double = [0;0]
        s_i_q (2,1) double = [0;0]
        s_j_p (2,1) double = [0;0]

    end

    check_body_exists(sys,body_i)
    check_body_exists(sys,body_j)

    joint = struct();
    joint.body_i_qidx = body_name_to_qidx(sys, body_i);
    joint.body_j_qidx = body_name_to_qidx(sys, body_j);
    joint.s_i = s_i_p;
    joint.s_i_q = s_i_q;
    joint.s_j = s_j_p;
    joint.fi_i_0 = sys.bodies(body_name_to_id(sys, body_i)).orientation;
    % Finds the initial rotation of body i to be later used in constraint
    joint.fi_j_0 = sys.bodies(body_name_to_id(sys, body_j)).orientation;
    % Finds the initial rotation of body j to be later used in constraint
    

    sys.joints.trans = [sys.joints.trans, joint];
end
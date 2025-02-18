%% PREPROCESSOR
% Globally we have a complete multibody system
% It must contain bodies, joints, analysis settings
sys = make_system();

% Bodies

% What do we need to describe our body?
% location, orientation, name 

sys = add_body(sys, "ground");
sys = add_body(sys, "crank", [-0.1, 0.05], -deg2rad(30));
sys = add_body(sys, "link", [-0.5, 0.05], deg2rad(15));
sys = add_body(sys, "slider", [-0.7, 0]);

% Joints - kinematic (revolute and simple)
sys = add_joint_revolute(sys, "ground", "crank", [0; 0], [0.1; 0]);
sys = add_joint_revolute(sys, "crank", "link", [-0.1; 0], [0.3; 0]);
sys = add_joint_revolute(sys, "link", "slider", [-0.2; 0]);

sys = add_joint_simple(sys, "slider", "y");
sys = add_joint_simple(sys, "slider", "fi");

%sys = add_joint_trans(sys, "slider", "ground", [-0.6;0],[-0.5;0],[0;0]);

sys = add_joint_simple(sys, "ground", "x");
sys = add_joint_simple(sys, "ground", "y");
sys = add_joint_simple(sys, "ground", "fi");



% sys = add_joint_simple_driving(sys, "crank", "fi", ...,
%     @(t) -deg2rad(30) - 1.2 * t, ...
%     @(t) - 1.2);

sys = set_solver_settings(sys, 10, 0.001);

%% SOLVER 

[T, Q, Qd] = solve_kinematics_NR(sys);

%% POSTPROCESSING

pidx = 10:12;
plot(T, Qd(pidx, :), ...
    T(1:end-1), (Q(pidx, 2:end)-Q(pidx, 1:end-1))/0.001, '--')
legend('X movement', 'Y movement', 'Rotation')
 %axis equal


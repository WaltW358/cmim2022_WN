%% Preprocessor

sys = make_system([0;0]);

% Bodies

l = 1;
%f = 100.0;
nlinks = 2;



sys = add_body(sys, "ground");
sys = add_body(sys, "link1", [0.5;0]);


sys = add_joint_revolute(sys,"ground","link1",[0;0],[-0.5;0]);

f_t_1 = @(t) [0; -f;0];
sys = add_force_single(sys, "link1", [0;-100;0], [l/2; 0.0]);

sys = set_solver_settings(sys, 10, 0.1);

%% Solve system

[T, Q,Qd] = wn_solve_dynamics_EC(sys);

%% Postprocessing
val = 6;
 figure('Name',"Simple pendulum rotation")
    plot(T,Q(val,:))
    hold on
    plot(T,Qd(val,:))
    xlabel("Time")
    ylabel("Radians")
    grid on
    title("Rotation of a simple pendulum")
    legend("Pos", "Vel")
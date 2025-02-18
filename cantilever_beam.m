%% PREPROCESSOR

sys = make_system();

% Bodies

l = 0.9;
f = 100.0;
kn = 20;
cn = 1000;
nlinks = 3;
llink = l/nlinks;


sys = add_body(sys, "ground");
sys = add_body(sys, "link1", [llink / 2; 0.0],0,1,1e-3);
sys = add_body(sys, "link2", [llink + llink / 2; 0.0],0,1,1e-3);
sys = add_body(sys, "link3", [2*llink + llink / 2; 0.0],0,1,1e-3);


% Joints
sys = add_joint_simple(sys,"ground","x");
sys = add_joint_simple(sys, "ground", "y");
sys = add_joint_simple(sys,"ground", "fi");

sys = add_joint_revolute(sys,"ground","link1",[0; 0],[-llink / 2;0.0]);
sys = add_joint_revolute(sys,"link1","link2",[llink / 2; 0.0],[-llink / 2; 0.0]);
sys = add_joint_revolute(sys,"link2", "link3", [llink / 2; 0.0], [-llink / 2; 0.0]);

% Forces
sys = add_force_torsional_spring(sys, "ground", "link1", kn, cn, 0); %interface to add torsional spring-damper, bodies names, spring coeff, damping coeff, initial angle
sys = add_force_torsional_spring(sys, "link1", "link2", kn, cn, 0);
sys = add_force_torsional_spring(sys, "link2", "link3", kn, cn, 0);

% End force
f_t_1 = @(t) [0; -f];
f_t_2 = @(t) [0; -exp(t - 2) * f];
sys = add_force_single(sys, "link3", f_t_1, [llink / 2; 0.0]);

% [T, Q, Qd] = solve_dynamics_ode45(sys);

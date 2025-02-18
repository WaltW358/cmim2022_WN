function [T, Q,Qd] = wn_solve_dynamics_EC(sys)
%SOLVE_DYNAMICS_EC_NO_CONSTRAINTS Solve the multibody system sys on
%dynamics using Euler-Cromer integration scheme and assuming that there can
%be only simple constraints!!!

q0 = initial_coordinates(sys);
qd0 = zeros(size(q0));

C = constraints(sys, q0, 0.0);
nC = length(C);

if norm(C) > 1e-12
    warning("Initial constraint norm is too large - expect incorrect results!")
end

M = mass_matrix(sys);
%f = forces(sys);

% Here put proper code for g vector. But for simple constraints this is
% accurate
 %g = zeros(length(nC), 1);
 f(sys.forces.external.body_i_qidx) = sys.forces.external.F;
 imp = length(M)+nC-length(f); % Variable to create the zeros for A matrix

    %g = [0,0,0,0,-100,0,-100,-100]';
    %g = [0,0,0,0,-100,0,0,0]';
%g = zeros(imp,1);
g = rot(sys.bodies(2).orientation)*[sys.forces.external.F(1,1);sys.forces.external.F(2,1)];



    function qdd = accfun(q,dq,t)
        Cq = constraints_dq(sys, q);
        A = [M, Cq'
            Cq, zeros(imp)];
        b = [f';g];
        qdd_lambda = A \ b;
        qdd = qdd_lambda(1:end - nC);
    end
% [T,Q] = ode15i(accfun,[0,10],q0,qd0);
%[T,Q] = ode45(accfun(q0),[0, sys.solver.t_final],q0);

[T, Q, Qd] = odeEulerCromer(@accfun, q0, qd0, ...
    sys.solver.t_step, sys.solver.t_final);
end
function C = constraints(sys, q, t)

C = [
    constraints_revolute(sys, q)
    constraints_trans(sys, q)
    constraints_simple(sys, q)
    constraints_simple_driving(sys, q, t)
    
    ];